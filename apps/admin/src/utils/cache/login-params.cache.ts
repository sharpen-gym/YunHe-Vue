import { CacheConstant } from '@/common'
import { CacheUtil } from '../cache.util'

export interface LoginParams {
  username: string
  password: string
  rememberMe: boolean
}

export function setLoginParams(value: LoginParams) {
  CacheUtil.set(CacheConstant.LOGIN_PARAMS, value)
}

export function getLoginParams() {
  return CacheUtil.get(CacheConstant.LOGIN_PARAMS) ?? ({} as LoginParams)
}

export function removeLoginParams() {
  CacheUtil.del(CacheConstant.LOGIN_PARAMS)
}
