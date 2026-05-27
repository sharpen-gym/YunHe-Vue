import { tool } from '@langchain/core/tools'

export const get_weather_tool = tool(
  // 实际场景中可替换为真实的接口调用
  async ({ city }) => {
    return `${city}天气是晴朗的，温度是25摄氏度`
  },
  {
    name: 'get_weather', // 工具唯一标识符，需全局唯一
    description: '获取指定城市的当前天气信息，包括温度、天气状况和湿度。当用户询问某个地方的天气时，使用此工具。', // 工具描述，用于提示用户和调用工具
    schema: {
      type: 'object',
      properties: {
        city: {
          type: 'string',
          description: '要查询天气的城市名称',
        },
      },
      required: ['city'], // 必传参数列表
      additionalProperties: false, // 不允许额外的参数
    },
  },
)
