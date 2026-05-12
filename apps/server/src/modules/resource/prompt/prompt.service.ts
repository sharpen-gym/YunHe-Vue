import { BusinessException, PromptEntity } from '@/common'
import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { Equal, FindOptionsWhere, In, Like, Not, Repository } from 'typeorm'
import { CreatePromptDto, QueryPromptDto, UpdatePromptDto } from './prompt.dto'

@Injectable()
export class PromptService {
  constructor(@InjectRepository(PromptEntity) private readonly promptRepository: Repository<PromptEntity>) {}

  public async create(createDto: CreatePromptDto) {
    const { title, type } = createDto
    const exists = await this.promptRepository.existsBy({ title: Equal(title), type: Equal(type) })
    if (exists) throw new BusinessException('提示词标题已存在')
    const entity = new PromptEntity()
    Object.assign(entity, createDto)
    await this.promptRepository.save(entity)
    return '添加成功'
  }

  public async update(updateDto: UpdatePromptDto) {
    const { id, title } = updateDto
    const exist = await this.promptRepository.findOneBy({ id: Equal(id) })
    if (!exist) throw new BusinessException('提示词不存在')
    if (title && title !== exist.title) {
      const exists = await this.promptRepository.existsBy({ title: Equal(title), id: Not(id) })
      if (exists) throw new BusinessException('提示词标题已存在')
    }
    Object.assign(exist, updateDto)
    await this.promptRepository.save(exist)
    return '修改成功'
  }

  public async delete(ids: string[]) {
    const list = await this.promptRepository.findBy({ id: In(ids) })
    if (!list.length) throw new BusinessException('提示词不存在')
    await this.promptRepository.delete(ids)
    return '删除成功'
  }

  public async findList(queryParams: QueryPromptDto) {
    const { skip, take, title, type, status } = queryParams
    const queryBuilder = this.promptRepository.createQueryBuilder('prompt')
    const where: FindOptionsWhere<PromptEntity> = {}
    if (title) where.title = Like(`%${title}%`)
    if (type) where.type = Like(`%${type}%`)
    if (status) where.status = Equal(status)
    queryBuilder.where(where)
    queryBuilder.orderBy('prompt.createTime', 'DESC')
    queryBuilder.skip(skip).take(take)
    const [records, total] = await queryBuilder.getManyAndCount()
    return { total, records }
  }

  public async findOneById(id: string) {
    const data = await this.promptRepository.findOneBy({ id: Equal(id) })
    if (!data) throw new BusinessException('提示词不存在')
    return data
  }
}
