import { TipModal } from '@/utils'
import { AiRequest } from '@/api/ai.request'
import type { ConversationMenuCommand } from 'vue-element-plus-x/types/Conversations'
import type { ConversationEntity, MessageEntity } from '@/types'

export const useAiStore = defineStore('ai', () => {
  /** 当前会话 ID */
  const conversationId = ref<string | undefined>(undefined)
  /** 所有会话列表 */
  const conversations = ref<ConversationEntity[]>([])
  /** 当前会话 */
  const currentConversation = computed(() => conversations.value.find((item) => item.id === conversationId.value))
  /** 当前会话消息列表 */
  const messages = ref<MessageEntity[]>([])
  /** 取消请求控制器 */
  let abortController: AbortController | null = null

  /** 获取对话列表 */
  async function getConversations() {
    try {
      const data = await AiRequest.getConversations()
      conversations.value = data
      if (!conversations.value.length || conversationId.value) return
      conversationId.value = conversations.value[0].id
      await getMessages()
    } catch (error: unknown) {
      const errMsg = error instanceof Error ? error.message : '获取会话列表失败'
      TipModal.msgError(errMsg)
    }
  }

  /** 切换会话 */
  function handleConversationChange(item: ConversationEntity) {
    if (conversationId.value === item.id) return
    conversationId.value = item.id
    getMessages()
  }

  /** 处理菜单命令 */
  async function handleMenuCommand(command: ConversationMenuCommand) {
    try {
      if (!conversationId.value || !currentConversation.value) return TipModal.msgError('当前会话不存在')
      if (command === 'delete') {
        await deleteConversation()
      } else if (command === 'rename') {
        await renameConversation()
      }
    } catch (error: unknown) {
      const errMsg = error instanceof Error ? error.message : '处理菜单命令失败'
      console.log('errMsg: ', errMsg)
    }
  }

  /** 新增会话 */
  async function createConversation() {
    conversationId.value = undefined
    messages.value = []
    TipModal.msgSuccess('当前已经处于新会话')
  }

  async function deleteConversation() {
    if (!conversationId.value || !currentConversation.value) return TipModal.msgError('当前会话不存在')
    const { cancel } = await TipModal.confirm(`确定删除该会话吗？`)
    if (cancel) return TipModal.msg('操作已取消')
    await AiRequest.deleteConversation({ conversationId: conversationId.value })
    messages.value = []
    conversationId.value = undefined
    await getConversations()
  }

  /** 重命名当前会话 */
  async function renameConversation() {
    if (!conversationId.value || !currentConversation.value) return TipModal.msgError('当前会话不存在')
    const { cancel, value: title } = await TipModal.prompt('请输入新会话标题', { inputValue: currentConversation.value.title })
    if (cancel) return TipModal.msg('操作已取消')
    await AiRequest.updateConversationTitle({ conversationId: conversationId.value, title })
    await getConversations()
    TipModal.msgSuccess('操作成功')
  }

  /** 获取当前会话消息列表 */
  async function getMessages() {
    if (!conversationId.value) return
    const data = await AiRequest.getMessages({ conversationId: conversationId.value })
    messages.value = data
  }

  async function send(message: string) {
    if (!message) return
    // 取消上一次未完成的请求
    abortController?.abort()
    abortController = new AbortController()
    // 组装推入用户消息和 AI 占位
    messages.value.push({ role: 'user', content: message } as MessageEntity)
    messages.value.push({ role: 'assistant', content: '', loading: true } as MessageEntity)
    // 组装数据并发起请求
    const data = { message, enableInternetSearch: true, conversationId: conversationId.value }
    const stream = await AiRequest.sendMessage(data, { signal: abortController.signal })
    messages.value.at(-1)!.loading = false
    const reader = stream.getReader()
    const decoder = new TextDecoder()
    while (true) {
      const { done, value } = await reader.read().catch((err: unknown) => {
        if (err instanceof DOMException && err.name === 'AbortError') return { done: true, value: undefined }
        throw err
      })
      if (done) break
      const chunk = decoder.decode(value!, { stream: true })
      const lines = chunk.split('\n').filter((i) => i.startsWith('data: '))
      for (const line of lines) {
        const data = JSON.parse(line.replace('data: ', ''))
        if (data.status === 'DONE') return
        messages.value.at(-1)!.content += data.content
      }
    }
  }

  return { messages, conversations, conversationId, send, createConversation, getConversations, handleMenuCommand, handleConversationChange }
})
