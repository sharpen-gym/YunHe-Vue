import { BaseEntity } from '../base.entity'
import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm'

@Entity('ai_message')
export class AiMessageEntity extends BaseEntity {
  @PrimaryGeneratedColumn('uuid')
  id: string

  @Column({ name: 'conversation_id', type: 'varchar', length: 36, comment: '会话ID' })
  conversationId: string

  @Column({ name: 'role', type: 'varchar', length: 20, comment: '对话角色' })
  role: string

  @Column({ name: 'content', type: 'text', comment: '消息内容' })
  content: string

  @Column({ name: 'tokens', type: 'int', nullable: true, comment: '消耗Token数' })
  tokens: number
}
