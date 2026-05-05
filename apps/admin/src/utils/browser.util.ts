import { TipModal } from './tip-modal.util'
import type { CopyTextOptions, CopyTextReturn } from '@/types'

/**
 * 复制文本到剪贴板工具函数
 * @param {string} content 需要复制的文本内容
 * @returns {Promise<CopyTextReturn>} 复制文本操作返回的结果
 */
export async function copyText(content: string, options: CopyTextOptions = {}): Promise<CopyTextReturn> {
  try {
    const { allowWhitespace = false, legacy = false } = options
    if (!allowWhitespace && (!content || content.trim() === '')) {
      TipModal.msgError('复制内容不能为空')
      return { success: false, message: '复制内容不能为空' }
    } else if (navigator.clipboard && window.isSecureContext && !legacy) {
      await navigator.clipboard.writeText(content)
    } else {
      const textarea = document.createElement('textarea')
      textarea.style.cssText = 'position:fixed; opacity:0; z-index:-9999; left:-9999px; top:-9999px;'
      textarea.value = content
      document.body.appendChild(textarea)
      textarea.select()
      textarea.setSelectionRange?.(0, content.length)
      const copied = document.execCommand('copy')
      document.body.removeChild(textarea)
      if (!copied) throw new Error('浏览器限制或无法复制')
    }
    TipModal.msgSuccess('复制成功')
    return { success: true, message: '复制成功' }
  } catch (error: unknown) {
    const errMsg = error instanceof Error ? error.message : '未知错误'
    TipModal.msgError(`复制失败：${errMsg}`)
    return { success: false, message: `${errMsg}` }
  }
}

/** 一个利用 a 标签下载文件的函数 */
export function linkDownload(fileURL: string | Blob | File, fileName?: string): void {
  let href: string = typeof fileURL === 'string' ? fileURL : URL.createObjectURL(fileURL)
  const a = document.createElement('a')
  a.style.display = 'none'
  a.href = href
  a.download = fileName || Date.now().toString()
  document.body.appendChild(a)
  a.click()
  document.body.removeChild(a)
  if (typeof fileURL !== 'string') URL.revokeObjectURL(href)
}
