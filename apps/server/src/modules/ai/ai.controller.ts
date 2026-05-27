import { CurrentUser, Public } from '@/common'
import { ChatDto, CreateConversationDto, UpdateConversationTitleDto } from './ai.dto'
import { AiService } from './ai.service'
import { Body, Controller, Delete, Get, Post, Put, Query, Res } from '@nestjs/common'

@Controller('ai')
export class AiController {
  constructor(private readonly aiService: AiService) {}

  @Post('chat/stream')
  public chatStream(@Body() chatDto: ChatDto, @CurrentUser('userId') userId: string, @Res({ passthrough: true }) response: ExpressResponse) {
    return this.aiService.streamChat(chatDto, userId, response)
  }

  /** 查询用户会话列表 */
  @Get('conversation/list')
  public getConversations(@CurrentUser('userId') userId: string) {
    return this.aiService.getConversations(userId)
  }

  /** 删除会话 */
  @Delete('conversation/delete')
  public deleteConversation(@Query('conversationId') conversationId: string) {
    return this.aiService.deleteConversation(conversationId)
  }

  /** 更新会话标题 */
  @Put('conversation/updateTitle')
  public updateConversationTitle(@Body() updateConversationTitleDto: UpdateConversationTitleDto) {
    return this.aiService.updateConversationTitle(updateConversationTitleDto)
  }

  /** 查询会话消息列表 */
  @Get('message/list')
  public getMessages(@Query('conversationId') conversationId: string) {
    return this.aiService.getMessages(conversationId)
  }
}
