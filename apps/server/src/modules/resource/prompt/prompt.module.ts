import { Module } from '@nestjs/common'
import { TypeOrmModule } from '@nestjs/typeorm'
import { PromptEntity } from '@/common'
import { PromptController } from './prompt.controller'
import { PromptService } from './prompt.service'

@Module({
  imports: [TypeOrmModule.forFeature([PromptEntity])],
  controllers: [PromptController],
  providers: [PromptService],
})
export class PromptModule {}
