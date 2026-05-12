import { CommonConstant } from '@/common'
import { BaseEntity } from '../base.entity'
import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm'

@Entity('res_prompt')
export class PromptEntity extends BaseEntity {
  @PrimaryGeneratedColumn('uuid')
  id: string

  @Column({ comment: '提示词标题', default: null, type: 'varchar', length: 200 })
  title: string

  @Column({ comment: '提示词类型', default: null, type: 'varchar', length: 50 })
  type: string

  @Column({ length: 1, comment: '状态', default: CommonConstant.STATUS_NORMAL, type: 'char' })
  status: string

  @Column({ comment: '备注', nullable: true, type: 'varchar', length: 500 })
  remark: string

  @Column({ comment: '提示词内容', type: 'text', default: null })
  content: string
}
