import { AiRequest } from '@/api/ai.request'
import type { Conversation, Message } from '@/types'
import { TipModal } from '@/utils'

export const useAiStore = defineStore('ai', () => {
  /** 当前会话ID */
  const conversationId = ref<string | undefined>(undefined)
  /** 所有会话列表 */
  const conversations = ref<Conversation[]>([])
  /** 当前会话消息列表 */
  const messages = ref<Message[]>([])
  /** 加载状态 */
  const loading = ref<boolean>(false)
  /** 联网搜索开关 */
  const enableInternetSearch = ref<boolean>(false)

  /** 获取会话列表 */
  async function getConversations() {
    try {
      const data = await AiRequest.getConversations()
      conversations.value = data
      // 无会话时清空状态
      if (data.length === 0) {
        conversationId.value = undefined
        messages.value = []
        return
      }
      // 默认选中第一个会话
      if (!conversationId.value) {
        conversationId.value = data[0].id
        await getMessages()
      }
    } catch (error: unknown) {
      const errMsg = error instanceof Error ? error.message : '获取会话列表失败'
      TipModal.msgError(errMsg)
    }
  }

  /** 切换会话 */
  async function changeConversation(id: string) {
    if (id === conversationId.value) return TipModal.msgWarning('你正处于当前会话，无需切换')
    conversationId.value = id
    await getMessages()
  }

  /** 获取会话消息列表 */
  async function getMessages() {
    if (!conversationId.value) return
    const data = await AiRequest.getMessages({ conversationId: conversationId.value })
    messages.value = data
  }

  return {
    conversationId,
    conversations,
    messages,
    loading,
    enableInternetSearch,
    getConversations,
    changeConversation,
    getMessages,
  }
})
