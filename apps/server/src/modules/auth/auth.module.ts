import { Module } from '@nestjs/common'
import { AuthService } from './auth.service'
import { AuthController } from './auth.controller'
import { LogModule } from '../monitor/log/log.module'
import { UserModule } from '../system/user/user.module'
import { MenuModule } from '../system/menu/menu.module'
import { PassportModule } from '@nestjs/passport'
import { JwtStrategy } from './strategies/jwt.strategy'

@Module({
  imports: [PassportModule, UserModule, LogModule, MenuModule],
  controllers: [AuthController],
  providers: [AuthService, JwtStrategy],
})
export class AuthModule {}
