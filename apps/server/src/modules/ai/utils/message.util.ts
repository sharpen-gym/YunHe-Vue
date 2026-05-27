import { AIMessage, BaseMessage, HumanMessage, SystemMessage } from '@langchain/core/messages'

/**
 * 创建人类消息
 * @param content 消息内容
 * @returns 人类消息
 */
export function createHumanMessage(content: string): BaseMessage {
  return new HumanMessage(content)
}

/**
 * 创建助手消息
 * @param content 消息内容
 * @returns 助手消息
 */
export function createAssistantMessage(content: string): BaseMessage {
  return new AIMessage(content)
}

/**
 * 创建系统消息
 * @param content 消息内容
 * @returns 系统消息
 */
export function createSystemMessage(content: string): BaseMessage {
  return new SystemMessage(content)
}
