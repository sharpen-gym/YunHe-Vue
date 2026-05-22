export interface SendMessage {
  /** 是否启用联网搜索 */
  enableInternetSearch: boolean
  /** 会话ID */
  conversationId?: string
  /** 消息 */
  message: string
}

/** 会话信息 */
export interface ConversationEntity {
  /** 会话ID */
  id: string
  /** 用户ID */
  userId: string
  /** 会话标题 */
  title: string
  /** 会话状态 */
  status: string
  /** 历史对话摘要 */
  summary: string
  /** 备注 */
  remark: string
}

/** 会话消息 */
export interface MessageEntity {
  /** 消息ID */
  id: string
  /** 会话ID */
  conversationId: string
  /** 消息角色 */
  role: 'assistant' | 'system' | 'human' | 'user'
  /** 消耗Token数 */
  tokens: number
  /** 消息内容 */
  content: string
  /** 消息创建时间 */
  createTime: string
  /** 是否正在加载中 */
  loading: boolean
}

export interface UpdateConversationTitleParams {
  conversationId: string
  title: string
}
