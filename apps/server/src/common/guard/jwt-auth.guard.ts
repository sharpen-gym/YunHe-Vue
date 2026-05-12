import { Reflector } from '@nestjs/core'
import { JwtService } from '@nestjs/jwt'
import { ConfigService } from '@nestjs/config'
import { RedisService } from '@/shared/redis.service'
import { RedisConstant, CommonConstant, DecoratorConstant, BusinessException } from '@/common'
import { Injectable, CanActivate, ExecutionContext, HttpStatus, Logger } from '@nestjs/common'

@Injectable()
export class JwtAuthGuard implements CanActivate {
  private readonly logger = new Logger(JwtAuthGuard.name)

  constructor(
    private readonly reflector: Reflector,
    private readonly jwtService: JwtService,
    private readonly redisService: RedisService,
    private readonly configService: ConfigService,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const request = context.switchToHttp().getRequest<ExpressRequest>()

    // 放行公开接口
    const isPublic = this.reflector.getAllAndOverride<boolean>(DecoratorConstant.PUBLIC, [context.getHandler(), context.getClass()]) ?? false
    if (isPublic) return true

    try {
      // 提取 AccessToken
      const accessToken = this.extractTokenFromHeader(request)
      if (!accessToken) throw new Error('invalid token')

      // 校验 JWT 签名合法性、是否过期
      const payload = this.jwtService.verify<AuthType.JwtPayload>(accessToken)
      const { userId, uuid } = payload

      // 校验 Redis 中的 AccessToken 是否存在
      const REDIS_TOKEN_KEY = `${RedisConstant.ACCESS_TOKEN_KEY}:${userId}:${uuid}`
      const redisToken = await this.redisService.get(REDIS_TOKEN_KEY)
      if (!redisToken || redisToken !== accessToken) throw new Error('invalid token')

      // 自动续期缓存（best-effort，不阻塞请求，失败仅打日志不影响认证结果）
      Promise.all([
        this.redisService.expire(`${RedisConstant.ACCESS_TOKEN_KEY}:${userId}:${uuid}`, this.expiresIn),
        this.redisService.expire(`${RedisConstant.ADMIN_USER_ONLINE_KEY}:${userId}:${uuid}`, this.expiresIn),
        this.redisService.expire(`${RedisConstant.ADMIN_USER_ROLES}:${userId}`, this.expiresIn),
        this.redisService.expire(`${RedisConstant.ADMIN_USER_PERMISSIONS}:${userId}`, this.expiresIn),
      ]).catch((error: unknown) => {
        const errMsg = error instanceof Error ? error.message : '未知错误'
        this.logger.warn(`Token 续期失败（不影响本次请求）: ${errMsg}`)
      })

      // 将用户信息挂载到请求对象，供后续接口使用
      request[CommonConstant.JWT_PAYLOAD] = payload

      return true
    } catch (error: any) {
      let message = error.message ?? '认证失败，请重新登录'
      if (['invalid token', 'invalid signature', 'jwt expired', 'jwt malformed'].includes(message)) message = '访问凭证已过期或不存在'
      throw new BusinessException(message, HttpStatus.UNAUTHORIZED)
    }
  }

  /** 获取 JWT 过期时间（默认30分钟） */
  private get expiresIn() {
    return this.configService.get<number>('jwt.expiresIn', 1800)
  }

  /** 从请求头中提取 AccessToken */
  private extractTokenFromHeader(request: ExpressRequest): string | undefined {
    const authorization = request.headers[CommonConstant.AUTHORIZATION]
    const [type, token] = (Array.isArray(authorization) ? authorization[0] : authorization)?.split(' ') ?? []
    return type === CommonConstant.TOKEN_PREFIX ? token : undefined
  }
}
