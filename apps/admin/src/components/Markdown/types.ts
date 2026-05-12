// https://imzbf.github.io/md-editor-v3/zh-CN

export interface MarkdownProps {
  /** 输入框占位信息 */
  placeholder?: string
  /** 是否显示预览 */
  preview?: boolean
  /** 文本区域允许的最大字符数 */
  maxLength?: number
  /** 编辑器高度 */
  height?: string
  /** 编辑器最小高度 */
  minHeight?: string
  /** 是否只读 */
  readOnly?: boolean
}
