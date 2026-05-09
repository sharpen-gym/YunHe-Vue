import dayjs from 'dayjs'
import { Column } from 'typeorm'

export abstract class CommonEntity {
  /**
   * 创建时间
   * @description 自动生成，实体首次插入时赋值，后续不可更新
   * @type {Date | string} 数据库存储为 timestamp，加载后可转为格式化字符串
   * @example "2025-01-01 12:00:00" / Date 对象
   */
  @Column({ name: 'create_time', comment: '创建时间', update: false, type: 'datetime', precision: 0, default: () => 'CURRENT_TIMESTAMP' })
  createTime: Date

  /**
   * 更新时间
   * @description 自动生成，实体每次保存（save）时更新
   * @type {Date | string} 数据库存储为 datetime，加载后可转为格式化字符串
   * @example "2025-01-02 14:30:00" / Date 对象
   */
  @Column({ name: 'update_time', comment: '更新时间', type: 'datetime', precision: 0, default: () => 'CURRENT_TIMESTAMP', onUpdate: 'CURRENT_TIMESTAMP' })
  updateTime: Date

  /**
   * 序列化为 JSON 时格式化时间，仅影响接口返回，不影响数据库与业务逻辑
   * - 会在实体实例化后自动调用，无需手动调用
   */
  toJSON() {
    return {
      ...this,
      createTime: dayjs(this.createTime).format('YYYY-MM-DD HH:mm:ss'),
      updateTime: dayjs(this.updateTime).format('YYYY-MM-DD HH:mm:ss'),
    }
  }
}
