import { Module } from '@nestjs/common'
import { AiService } from './ai.service'
import { AiController } from './ai.controller'
import { TypeOrmModule } from '@nestjs/typeorm'
import { AiMessageEntity, AiConversationEntity } from '@/common'

@Module({
  imports: [TypeOrmModule.forFeature([AiMessageEntity, AiConversationEntity])],
  controllers: [AiController],
  providers: [AiService],
})
export class AiModule {}
