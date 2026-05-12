import { request } from '@/utils/request'
import type { PromptEntity, PromptQueryParams } from '@/types'

export abstract class PromptRequest {
  static create(data: PromptEntity): Promise<string> {
    return request.post('/resource/prompt/create', data)
  }

  static update(data: PromptEntity): Promise<string> {
    return request.put('/resource/prompt/update', data)
  }

  static delete(params: { ids: string }): Promise<string> {
    return request.delete('/resource/prompt/delete', { params })
  }

  static findList(params: PromptQueryParams): PaginationResponse<PromptEntity> {
    return request.get('/resource/prompt/list', { params })
  }

  static findDetail(params: { id: string }): Promise<PromptEntity> {
    return request.get('/resource/prompt/detail', { params })
  }
}
