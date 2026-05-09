import { Type } from 'class-transformer'
import { IsOptional, IsBoolean, IsArray, ValidateNested, IsNotEmpty, IsString } from 'class-validator'

export class Message {
  @IsString()
  @IsNotEmpty({ message: '消息角色不能为空' })
  role: 'assistant' | 'system' | 'human'

  @IsString()
  @IsNotEmpty({ message: '消息内容不能为空' })
  content: string
}

export class ChatDto {
  /** 是否开启联网搜索 */
  @IsOptional()
  @IsBoolean({ message: 'enableInternetSearch 必须是布尔值' })
  enableInternetSearch: boolean

  @IsOptional()
  conversationId: string

  @IsNotEmpty({ message: '参数 $property 不可为空' })
  message: string
}

export class CreateConversationDto {
  @IsNotEmpty({ message: '会话标题不能为空' })
  @IsString()
  title: string
}

export class UpdateConversationTitleDto {
  @IsNotEmpty({ message: '会话标题不能为空' })
  @IsString()
  title: string

  @IsNotEmpty({ message: '会话ID不能为空' })
  @IsString()
  conversationId: string
}
