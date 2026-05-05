/** 复制文本的配置选项 */
export interface CopyTextOptions {
  /** 是否允许复制空白内容（空字符串或纯空格），默认 false */
  allowWhitespace?: boolean
  /** 是否使用旧版复制方法（基于 document.execCommand，不支持空白内容复制），默认 false */
  legacy?: boolean
}

/** 复制文本操作返回的结果 */
export interface CopyTextReturn {
  /** 是否复制成功 */
  success: boolean
  /** 描述操作结果的消息，例如成功时的 "复制成功" 或失败时的错误原因 */
  message: string
}
