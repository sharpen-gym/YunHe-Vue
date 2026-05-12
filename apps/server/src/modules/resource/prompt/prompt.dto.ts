import { PaginationDto } from '@/common'
import { Exclude } from 'class-transformer'
import { PartialType } from '@nestjs/mapped-types'
import { IsNotEmpty, IsOptional, Length } from 'class-validator'

export class CreatePromptDto {
  @Length(1, 16, { message: '提示词标题长度必须在 1 到 16 个字符之间' })
  @IsNotEmpty({ message: '参数 $property  不能为空' })
  title: string

  @IsNotEmpty({ message: '参数 $property  不能为空' })
  type: string

  @IsOptional()
  status: string

  @IsOptional()
  remark: string

  @IsNotEmpty({ message: '参数 $property  不能为空' })
  content: string
}

export class UpdatePromptDto extends PartialType(CreatePromptDto) {
  @IsNotEmpty({ message: '参数 $property  不能为空' })
  id: string

  @Exclude()
  createBy: string
}

export class QueryPromptDto extends PaginationDto {
  @IsOptional()
  @Length(1, 16, { message: '提示词标题长度必须在 1 到 16 个字符之间' })
  title: string

  @IsOptional()
  type: string

  @IsOptional()
  status: string
}
