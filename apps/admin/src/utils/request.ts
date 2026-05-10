import axios from 'axios'
import { getAccessToken, sleep } from '.'
import { TipModal } from './tip-modal.util'
import { CommonConstant } from '@/common'

const NProgress = useProgress({ show: import.meta.env.VITE_REQUEST_NPROGRESS !== 'false' })

const instance = axios.create({
  // baseURL 将自动加在 url 前面，除非 url 是一个绝对 URL
  baseURL: import.meta.env.VITE_BASE_API,
  // timeout 指定请求超时的毫秒数(0 表示无超时时间)，如果请求花费了超过 timeout 的时间，请求将被中断
  timeout: parseInt(import.meta.env.VITE_REQUEST_TIMEOUT || '0') * 1000,
})

// 请求拦截器
instance.interceptors.request.use(
  (config) => {
    NProgress.start()
    // 让每个请求携带自定义 token 请根据实际情况自行修改
    const accessToken = getAccessToken()
    if (accessToken) config.headers[CommonConstant.AUTHORIZATION] = `${CommonConstant.TOKEN_PREFIX} ${accessToken}`
    return config
  },
  (error) => {
    NProgress.done()
    return Promise.reject(error)
  },
)

instance.interceptors.response.use(
  async (response) => {
    NProgress.done()
    // console.log('response: ', response)
    const responseType = response.config.responseType || ''
    const contentType = (response.headers['content-type'] || '') as string
    let code = response.data.code || 200
    let message = response.data.message

    console.log('contentType: ', contentType)
    console.log('code: ', code, message, responseType)

    const isJsonBlob = response.data instanceof Blob && response.data.type.includes('application/json')
    const isJsonStream = response.data instanceof ReadableStream && contentType.includes('application/json')

    // 处理二进制返回出现的 JSON 字符串情况
    if (isJsonBlob || isJsonStream) {
      const info = await new Response(response.data).json()
      code = info.code
      message = info.message
    }

    if (code === 401) {
      await useUserStore().logout()
      TipModal.msgError(`会话已过期，即将重新登录`)
      await sleep(1000)
      location.href = '/'
      return Promise.reject(new Error(message))
    }

    // 处理异常响应
    if (code !== 200) {
      TipModal.msgError(message)
      return Promise.reject(new Error(message))
    }

    // 处理二进制响应
    if (['arraybuffer', 'blob'].includes(responseType)) {
      return response
    }

    // 处理流式响应
    if (responseType === 'stream') {
      return response.data
    }

    // 处理普通响应
    if (code === 200) {
      return response.data.data
    }

    return response
  },
  (error: any) => {
    NProgress.done()
    let { message } = error

    // 处理取消请求
    if (axios.isCancel(error) || error?.code === 'ERR_CANCELED' || error?.name === 'CanceledError') {
      return Promise.reject(error)
    }

    if (message == 'Network Error') {
      message = '后端接口连接异常'
    }
    if (message.includes('timeout')) {
      message = '系统接口请求超时'
    }
    if (message.includes('Request failed with status code')) {
      message = `系统接口 ${message.substr(message.length - 3)} 异常`
    }
    if (error?.response?.data?.message) {
      message = error.response.data.message
    }

    TipModal.msgError(message)

    return Promise.reject(error)
  },
)

export const request = instance
