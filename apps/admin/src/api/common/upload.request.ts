import { request } from '@/utils/request'
import type { AxiosRequestConfig } from 'axios'
import type { CheckFileParams, CheckFileResponse, ClearChunkParams, MergeChunkParams } from '@/types'

export abstract class uploadRequest {
  /** 单文件上传 */
  static uploadFile(data: FormData): Promise<string> {
    return request.post('/common/upload/file', data, { headers: { 'Content-Type': 'multipart/form-data' } })
  }

  /** 秒传 + 断点续传检查 */
  static checkFile(data: CheckFileParams): Promise<CheckFileResponse> {
    return request.post('/common/upload/check', data)
  }

  /** 上传单个分片 */
  static uploadChunk(data: FormData, config: AxiosRequestConfig = {}): Promise<string> {
    return request.post('/common/upload/chunk', data, config)
  }

  /** 合并所有分片 */
  static mergeChunks(data: MergeChunkParams): Promise<string> {
    return request.post('/common/upload/chunk/merge', data)
  }

  /** 清理分片 */
  static clearChunk(params: ClearChunkParams): Promise<string> {
    return request.delete('/common/upload/chunk/clear', { params })
  }
}
