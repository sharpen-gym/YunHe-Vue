import { Module } from '@nestjs/common'
import { PromptModule } from './prompt/prompt.module'

@Module({
  imports: [PromptModule],
  exports: [PromptModule],
})
export class ResourceModule {}
