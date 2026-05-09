import { LLMResult } from '@langchain/core/outputs'
import { BaseCallbackHandler } from '@langchain/core/callbacks/base'

/**
 * Token 用量统计回调处理器
 * 继承 LangChain 官方 BaseCallbackHandler，确保在 stream / invoke 模式下都能稳定触发
 * 用于自动统计 LLM 对话的 promptTokens 和 completionTokens
 */
export class TokenCounterHandler extends BaseCallbackHandler {
  /** 回调处理器唯一标识（LangChain 内部使用） */
  name = 'TokenCounterHandler'
  /** 提示词 Token 数量（用户输入） */
  public promptTokens = 0
  /** 回复 Token 数量（AI 输出） */
  public completionTokens = 0

  /**
   * LLM 调用结束时触发
   * 官方标准钩子，stream 模式下也会稳定执行
   */
  public handleLLMEnd(output: LLMResult): void {
    const tokenUsage = output.llmOutput?.tokenUsage
    if (!tokenUsage) return
    this.promptTokens = tokenUsage.promptTokens
    this.completionTokens = tokenUsage.completionTokens
  }
}
