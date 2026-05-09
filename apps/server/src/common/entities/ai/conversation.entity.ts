import { CommonConstant } from '@/common'
import { BaseEntity } from '../base.entity'
import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm'

@Entity('ai_conversation')
export class AiConversationEntity extends BaseEntity {
  @PrimaryGeneratedColumn('uuid')
  id: string

  @Column({ name: 'user_id', type: 'varchar', length: 36, comment: '用户ID' })
  userId: string

  @Column({ type: 'varchar', length: 255, comment: '会话标题' })
  title: string

  // @Column({ name: 'model', type: 'varchar', length: 50, comment: 'AI模型' })
  // model: string

  @Column({ default: CommonConstant.STATUS_NORMAL, type: 'char', length: 1 })
  status: string

  @Column({ nullable: true, type: 'text', comment: '历史对话摘要' })
  summary: string

  @Column({ type: 'varchar', length: 500, nullable: true, comment: '备注' })
  remark: string
}
