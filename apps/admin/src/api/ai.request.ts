import { request } from '@/utils/request'
import type { AxiosRequestConfig } from 'axios'
import type { ConversationEntity, SendMessage, MessageEntity, UpdateConversationTitleParams } from '@/types'

export abstract class AiRequest {
  static sendMessage(data: SendMessage, config: AxiosRequestConfig = {}): Promise<ReadableStream> {
    config.responseType = 'stream'
    config.adapter = 'fetch'
    return request.post('/ai/chat/stream', data, config)
  }

  /** 删除会话及其对应的消息列表 */
  static deleteConversation(params: { conversationId: string }): Promise<string> {
    return request.delete(`/ai/conversation/delete`, { params })
  }

  /** 更新会话标题 */
  static updateConversationTitle(data: UpdateConversationTitleParams): Promise<string> {
    return request.put(`/ai/conversation/updateTitle`, data)
  }

  /** 查询用户会话列表 */
  static getConversations(): Promise<ConversationEntity[]> {
    return request.get('/ai/conversation/list')
  }

  /** 查询会话消息列表 */
  static getMessages(params: { conversationId: string }): Promise<MessageEntity[]> {
    return request.get(`/ai/message/list`, { params })
  }
}
