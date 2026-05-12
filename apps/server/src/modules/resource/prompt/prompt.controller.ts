import { PromptService } from './prompt.service'
import { OperLog, BusinessType, PaginationPipe, RequirePermissions, RepeatSubmit } from '@/common'
import { CreatePromptDto, QueryPromptDto, UpdatePromptDto } from './prompt.dto'
import { Controller, Get, Post, Put, Delete, Body, ParseArrayPipe, Query } from '@nestjs/common'

@Controller('resource/prompt')
export class PromptController {
  constructor(private readonly promptService: PromptService) {}

  @Post('create')
  @RequirePermissions(['resource:prompt:create'])
  @OperLog({ title: '提示词管理', businessType: BusinessType.INSERT })
  @RepeatSubmit()
  create(@Body() createDto: CreatePromptDto) {
    return this.promptService.create(createDto)
  }

  @Put('update')
  @RequirePermissions(['resource:prompt:update'])
  @OperLog({ title: '提示词管理', businessType: BusinessType.UPDATE })
  @RepeatSubmit()
  update(@Body() updateDto: UpdatePromptDto) {
    return this.promptService.update(updateDto)
  }

  @Delete('delete')
  @RequirePermissions(['resource:prompt:delete'])
  @OperLog({ title: '提示词管理', businessType: BusinessType.DELETE })
  @RepeatSubmit()
  delete(@Query('ids', new ParseArrayPipe()) ids: string[]) {
    return this.promptService.delete(ids)
  }

  @Get('list')
  @RequirePermissions(['resource:prompt:query'])
  list(@Query(PaginationPipe) queryParams: QueryPromptDto) {
    return this.promptService.findList(queryParams)
  }

  @Get('detail')
  @RequirePermissions(['resource:prompt:query'])
  detail(@Query('id') id: string) {
    return this.promptService.findOneById(id)
  }
}
