export interface PromptQueryParams extends PaginationParams {
  title?: string
  type?: string
  status?: string
}

export interface PromptEntity extends BaseEntity {
  id: string
  title: string
  type: string
  status: string
  remark: string
  content: string
}
