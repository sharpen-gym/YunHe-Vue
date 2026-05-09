import { AiConversationEntity, AiMessageEntity, BusinessException, CommonConstant, ConfigConstant } from '@/common'
import { Injectable } from '@nestjs/common'
import { ChatDto, CreateConversationDto, UpdateConversationTitleDto } from './ai.dto'
import { ConfigService } from '@nestjs/config'
import { ChatPromptTemplate } from '@langchain/core/prompts'
import { ChatOpenAI, ChatOpenAIFields } from '@langchain/openai'
import { HumanMessage, SystemMessage, BaseMessage, AIMessage } from '@langchain/core/messages'
import { createAgent, CreateAgentParams } from 'langchain'
import { tools } from './tools'
import { InjectRepository } from '@nestjs/typeorm'
import { Equal, Repository } from 'typeorm'
import { LLMResult } from '@langchain/core/outputs'
import { TokenCounterHandler } from '@/utils'

@Injectable()
export class AiService {
  /** AI 模型实例 */
  private model: ChatOpenAI
  /** 每多少条消息触发一次摘要生成（通用场景：12条） */
  private readonly SUMMARY_TRIGGER_COUNT = 12
  /** 上下文保留的最新消息数量（通用场景：6条=3轮对话） */
  private readonly RECENT_MESSAGE_COUNT = 6

  constructor(
    private readonly configService: ConfigService,
    @InjectRepository(AiMessageEntity) private readonly messageRepository: Repository<AiMessageEntity>,
    @InjectRepository(AiConversationEntity) private readonly conversationRepository: Repository<AiConversationEntity>,
  ) {
    this.initChatModel()
  }

  // public async test() {
  //   const messages = [new SystemMessage('你是一个专业的天气助手'), new HumanMessage('北京的天气怎么样？')]
  //   const result = await this.agent.invoke({
  //     messages,
  //   })
  //   console.log('result: ', result)
  //   return result
  // }

  /** AI 流式对话 */
  public async streamChat(chatDto: ChatDto, userId: string, response: ExpressResponse) {
    try {
      // 从 DTO 中获取会话ID（不传=新建）
      let finalConversationId = chatDto.conversationId
      let fullAiReply = ''
      const userContent = chatDto.message
      // 无会话ID → 自动新建会话
      if (!finalConversationId) {
        const conversation = new AiConversationEntity()
        conversation.userId = userId
        conversation.title = userContent.slice(0, 20) // 标题取前20字
        conversation.status = CommonConstant.STATUS_NORMAL
        const savedConversation = await this.conversationRepository.save(conversation)
        finalConversationId = savedConversation.id
      }
      // 保存用户消息到数据库
      const userMessageId = await this.saveMessage(finalConversationId, 'user', userContent)
      // 构建最优上下文：缓存摘要 + 最新 RECENT_MESSAGE_COUNT 条消息对话
      const langChainMessages = await this.buildContextMessages(finalConversationId)
      // 流式调用 AI
      const chatPrompt = ChatPromptTemplate.fromMessages(langChainMessages)
      const chain = chatPrompt.pipe(this.model)
      const tokenCounter = new TokenCounterHandler()
      const stream = await chain.stream({}, { callbacks: [tokenCounter] })
      // 流式输出
      for await (const chunk of stream) {
        const content = chunk?.content || ''
        fullAiReply += content
        if (!content) continue
        response.write(`data: ${JSON.stringify({ content, conversationId: finalConversationId })}\n\n`)
      }
      // 入库 Token 记录
      await this.saveMessage(finalConversationId, 'assistant', fullAiReply, tokenCounter.completionTokens)
      await this.messageRepository.update(userMessageId, { tokens: tokenCounter.promptTokens })
      // 懒更新摘要
      await this.lazyUpdateSummary(finalConversationId)
      // 结束响应
      if (!response.writableEnded) {
        response.write(`data: ${JSON.stringify({ status: 'DONE', conversationId: finalConversationId })}\n\n`)
        response.end()
      }
    } catch (error: unknown) {
      const errMsg = error instanceof Error ? error.message : '未知错误'
      this.setErrorResponse(response, errMsg)
    }
  }

  // private get agent() {
  //   const options: CreateAgentParams = { model: this.model }
  //   options.tools = tools
  //   return createAgent(options)
  // }

  /** 删除会话 */
  public async deleteConversation(conversationId: string) {
    await this.conversationRepository.delete(conversationId)
    await this.messageRepository.delete({ conversationId })
    return '删除成功'
  }

  /** 更新会话标题 */
  public async updateConversationTitle(updateConversationTitleDto: UpdateConversationTitleDto) {
    const { conversationId, title } = updateConversationTitleDto
    const conversation = await this.conversationRepository.findOneBy({ id: Equal(conversationId) })
    if (!conversation) throw new BusinessException(`会话 ${conversationId} 不存在`)
    conversation.title = title
    await this.conversationRepository.save(conversation)
    return '更新成功'
  }

  /** 查询用户会话列表 */
  public async getConversations(userId: string) {
    const queryBuilder = this.conversationRepository.createQueryBuilder('conversation')
    queryBuilder.where('conversation.userId = :userId', { userId })
    queryBuilder.orderBy('conversation.createTime', 'DESC')
    return queryBuilder.getMany()
  }

  /** 查询会话消息列表 */
  public async getMessages(conversationId: string) {
    const queryBuilder = this.messageRepository.createQueryBuilder('message')
    queryBuilder.where('message.conversationId = :conversationId', { conversationId })
    queryBuilder.orderBy('message.createTime', 'ASC')
    return queryBuilder.getMany()
  }

  /** 初始化聊天模型 */
  private initChatModel() {
    const options: ChatOpenAIFields = {}
    options.apiKey = this.configService.get<string>(ConfigConstant.OPENAI_API_KEY)
    options.model = this.configService.get<string>(ConfigConstant.OPENAI_MODEL)
    options.temperature = this.configService.get<number>(ConfigConstant.OPENAI_TEMPERATURE)
    options.maxTokens = this.configService.get<number>(ConfigConstant.OPENAI_MAX_TOKENS)
    options.configuration = {}
    options.configuration.baseURL = this.configService.get<string>(ConfigConstant.OPENAI_BASE_URL)
    this.model = new ChatOpenAI({ ...options })
  }

  /** 懒更新摘要：消息达到阈值才生成，缓存到数据库 */
  private async lazyUpdateSummary(conversationId: string): Promise<void> {
    // 查询总消息数
    const queryBuilder = this.messageRepository.createQueryBuilder('message')
    queryBuilder.where('message.conversationId = :conversationId', { conversationId })
    const count = await queryBuilder.getCount()
    // 小于触发阈值 → 不生成
    if (count < this.SUMMARY_TRIGGER_COUNT) return
    // 纯常量计算：每N条更新一次
    if (!((count - this.SUMMARY_TRIGGER_COUNT) % this.RECENT_MESSAGE_COUNT === 0)) return
    // 生成并更新摘要
    const summary = await this.generateSummary(conversationId)
    await this.conversationRepository.update(conversationId, { summary })
  }

  /** 生成对话摘要（仅懒更新时调用） */
  private async generateSummary(conversationId: string): Promise<string> {
    const queryBuilder = this.messageRepository.createQueryBuilder('message')
    queryBuilder.where('message.conversationId = :conversationId', { conversationId })
    queryBuilder.orderBy('message.createTime', 'ASC')
    const messages = await queryBuilder.getMany()
    const text = messages.map((m) => `${m.role}: ${m.content}`).join('\n')
    const prompt = ChatPromptTemplate.fromTemplate(`将以下对话压缩为简洁摘要，仅保留核心信息：{text}`)
    const chain = prompt.pipe(this.model)
    const result = await chain.invoke({ text })
    return result.content as string
  }

  /** 构建AI上下文：摘要 + 最新 RECENT_MESSAGE_COUNT 条消息 */
  private async buildContextMessages(conversationId: string) {
    // 获取缓存摘要
    const conversation = await this.conversationRepository.findOneBy({ id: conversationId })
    const summary = conversation?.summary || ''
    // 获取最新 RECENT_MESSAGE_COUNT 条消息
    const msgQuery = this.messageRepository.createQueryBuilder('message')
    msgQuery.where('message.conversationId = :conversationId', { conversationId })
    msgQuery.orderBy('message.createTime', 'DESC')
    msgQuery.take(this.RECENT_MESSAGE_COUNT)
    const latestMessages = await msgQuery.getMany()
    const recent = latestMessages.reverse()
    // 3. 组装最终上下文
    const msgs: BaseMessage[] = []
    if (summary) msgs.push(new SystemMessage(summary))
    for (const msg of recent) {
      if (msg.role === 'user') msgs.push(new HumanMessage(msg.content))
      if (msg.role === 'assistant') msgs.push(new AIMessage(msg.content))
    }
    return msgs
  }

  /** 保存消息到数据库 */
  private async saveMessage(conversationId: string, role: 'user' | 'assistant', content: string, tokens: number = 0) {
    const entity = new AiMessageEntity()
    entity.conversationId = conversationId
    entity.role = role
    entity.content = content
    entity.tokens = tokens
    const saved = await this.messageRepository.save(entity)
    return saved.id
  }

  /** 处理错误响应 */
  private setErrorResponse(response: ExpressResponse, message: string) {
    response.write(`data: ${JSON.stringify({ content: message })}\n\n`)
    if (!response.writableEnded) response.write(`data: ${JSON.stringify({ status: 'DONE' })}\n\n`)
    if (!response.writableEnded) response.end()
  }
}
