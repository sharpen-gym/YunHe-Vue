import { AiMessageEntity } from '@/common'
import { ChatOpenAI } from '@langchain/openai'
import { ChatPromptTemplate } from '@langchain/core/prompts'
import { StringOutputParser } from '@langchain/core/output_parsers'
import { HumanMessage, SystemMessage, BaseMessage, AIMessage } from '@langchain/core/messages'

/**
 * 转换数据库消息列表为大模型可识别消息列表
 * @param messages 数据库消息实体列表，role 支持 assistant / system / user
 * @returns 映射后的 LangChain BaseMessage 数组
 */
export function transformMessage(messages: AiMessageEntity[]): BaseMessage[] {
  return messages.map((item) => {
    if (item.role === 'assistant') {
      return new AIMessage(item.content)
    } else if (item.role === 'system') {
      return new SystemMessage(item.content)
    } else {
      return new HumanMessage(item.content)
    }
  })
}

/**
 * 将消息列表格式化为纯文本，每条消息按 `role: content` 拼接，用换行符分隔
 * @param messages 数据库消息实体列表
 * @returns 格式化后的纯文本字符串，如 `user: 你好\nassistant: 你好！`
 */
export function formatMessagesAsText(messages: AiMessageEntity[]): string {
  return messages.map((item) => `${item.role}: ${item.content}`).join('\n')
}

/**
 * 对话摘要生成函数：将多轮对话压缩为简洁核心摘要
 * @param model OpenAI 聊天模型实例
 * @param messages 对话消息数组
 * @returns 对话核心摘要（字符串）
 */
export function generateConversationSummary(model: ChatOpenAI, messages: AiMessageEntity[]) {
  const prompt = ChatPromptTemplate.fromTemplate(`请将以下对话内容压缩为简洁摘要，仅保留核心信息，不要冗余描述：{text}`)
  const chain = prompt.pipe(model).pipe(new StringOutputParser())
  return chain.invoke({ text: formatMessagesAsText(messages) })
}
