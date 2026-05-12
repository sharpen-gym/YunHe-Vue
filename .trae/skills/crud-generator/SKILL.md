---
name: crud-generator
description: 全栈 CRUD 代码生成器，根据字段描述一键生成 Entity/DTO/Service/Controller/Module + Vue3 列表页/Types/API，严格遵循项目规范。当用户说"新增XX模块""加一个XX管理"\"创建XX CRUD"时自动调用。
---

# 全栈 CRUD 生成器

根据字段描述一键生成完整 CRUD 模块，覆盖后端 5 层 + 前端 5 层，严格遵循 YunHe-Vue 项目代码规范。

## CRUD 模式

开始前先确认模式：

| 模式     | 场景                    | 输出                                          |
| -------- | ----------------------- | --------------------------------------------- |
| **标准** | 用户/角色（单表列表页） | 1 个 Entity + 1 套前后端                      |
| **树形** | 菜单类（含 parentId）   | 标准 + `listToTree` + `tree` 接口             |
| **主从** | 字典类（Master-Detail） | 2 个 Entity + 2 套前后端，子表路由带 masterId |

---

## 工作流程

### Step 0: 收集信息

收集以下信息后再生成代码：

```
模块中文名: 公告管理
所属区域:   system | monitor | ai
模式:       标准 | 树形 | 主从
Entity 名:  Notice
数据库表:   sys_notice
字段列表:
  - 字段名 (类型, 必填/可选, 中文标签, 是否导出, 字典类型或默认值)
  - title (string, 必填, 公告标题, 是)
  - noticeType (string, 必填, 公告类型, 否, sys_notice_type)
  - status (string, 必填, 状态, 是, sys_common_status, 默认: '1')
  - content (text, 必填, 公告内容, 否)
```

### Step 1: 生成后端

按顺序生成，每层完成后确认无遗漏再继续下一层。

```
1-1. Entity
1-2. DTO
1-3. Service
1-4. Controller
1-5. Module + 注册
```

### Step 2: 生成前端

```
2-1. Types
2-2. API Request
2-3. index.vue
2-4. register（提示手动步骤）
```

### Step 3: 全局注册提示

生成完所有文件后，列出需要手动操作的注册步骤。**不自动改这些文件**，只输出以下提示让用户执行：

```
🔧 需要手动注册的步骤：

1. apps/server/src/common/index.ts — 添加 Entity 导出（详见 1-1 节「Entity 导出规则」）：
   按区域分组（ai → system → monitor），插入对应区域末尾

2. apps/admin/src/types/index.ts — 添加类型导出（桶导出）：
   export * from './api/system/notice'

3. 动态路由 — 登录后台 → 菜单管理 → 新增菜单：
   菜单名称: 公告管理
   路由地址: notice
   组件路径: system/notice/index
   权限标识: system:notice:query
   菜单图标: Tool

4. 如果主模块有子页面（如主从模式的子表页），生成后需要在 router.database.ts 中注册为隐藏静态路由：
   { path: '/system/notice/detail', component: Layout, meta: { hidden: true },
     children: [{ path: '', component: () => import('@/views/system/notice/detail.vue'),
                   name: 'NoticeDetail', meta: { title: '公告详情', activeMenu: '/system/notice' } }] }
```

**路由规则：**

- 标准 CRUD 的**列表页** → 不需要改 `router.database.ts`，通过菜单管理配置即可（动态路由）
- 主从模式的**子表页**或**详情页** → 需要在 `router.database.ts` 注册，`meta: { hidden: true }`（静态路由，不在菜单中显示）

---

## 后端生成规范

### 1-1. Entity

文件路径: `apps/server/src/common/entities/<area>/<entity>.entity.ts`

```typescript
import { CommonConstant } from '@/common'
import { BaseEntity } from '../base.entity'
import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm'

@Entity('sys_notice')
export class NoticeEntity extends BaseEntity {
  @PrimaryGeneratedColumn('uuid')
  id: string

  @Column({ name: 'title', comment: '公告标题', default: null, length: 255 })
  title: string

  @Column({ name: 'notice_type', comment: '公告类型', default: null, length: 30 })
  noticeType: string

  @Column({ length: 1, comment: '状态', default: CommonConstant.STATUS_NORMAL, type: 'char' })
  status: string

  @Column({ name: 'content', comment: '公告内容', type: 'text', default: null })
  content: string
}
```

**规则：**

- `@PrimaryGeneratedColumn('uuid')` 作为主键，字段名 `id`
- 只有用户明确标注"可导出"的字段才加 `@Excel({ name: '列名' })` 装饰器，默认不加
- 字典字段如果可导出: `@Excel({ name: '名称', dictType: 'sys_xxx' })`，不导出则不加
- 类型映射: `string` → `type: 'varchar', length: 255` / `text` → `type: 'text'` / `number` → `type: 'int'` / `boolean` → `type: 'tinyint'` / `date` → `type: 'datetime'`
- 状态类字段: `@Column({ length: 1, comment: '...', default: CommonConstant.STATUS_NORMAL, type: 'char' })`，禁止硬编码 `'1'` / `'0'`
- `column name` 用 snake_case
- **⚠️ 生成 Entity 后必须立即在 `apps/server/src/common/index.ts` 中添加导出**，位置和规则如下：

### Entity 导出规则（index.ts）

文件 `apps/server/src/common/index.ts` 中有一个专门的 **Entity 区块**（位于 decorator 导出与 exception 导出之间），所有实体导出必须按以下规则添加到该区块：

```
// ===== 以上：class / constant / decorator / dto 导出 =====

export { AiMessageEntity } from './entities/ai/message.entity'        // ← ai 区域
export { AiConversationEntity } from './entities/ai/conversation.entity'

export { UserEntity } from './entities/system/user.entity'            // ← system 区域
export { RoleEntity } from './entities/system/role.entity'
export { MenuEntity } from './entities/system/menu.entity'
export { DictTypeEntity } from './entities/system/dict-type.entity'
export { DictDataEntity } from './entities/system/dict-data.entity'
export { NoticeEntity } from './entities/system/notice.entity'        // ← 新增！插入同区域末尾

export { JobEntity } from './entities/monitor/job.entity'             // ← monitor 区域
export { JobLogEntity } from './entities/monitor/job-log.entity'
export { OperLogEntity } from './entities/monitor/operlog.entity'
export { LogininforEntity } from './entities/monitor/logininfor.entity'

// ===== 以下：exception / filter / guard / interceptor / middleware / module / pipe 导出 =====
```

**排序规则：**

1. **按区域分组**: `ai` → `system` → `monitor`（固定顺序）
2. **同区域内按模块名/Entity 名字母序排列**
3. 新 Entity 插入**对应区域末尾**（保持区域内已有行不动）
4. 导出格式固定为 `export { XxxEntity } from './entities/<area>/<entity>.entity'`（命名导出，非桶导出）

**树形模式额外字段：**

```typescript
@Column({ name: 'parent_id', comment: '父级ID', default: '0', length: 36 })
parentId: string
```

### 1-2. DTO

文件路径: `apps/server/src/modules/<area>/<module>/<module>.dto.ts`

**CreateDto:**

```typescript
import { PaginationDto } from '@/common'
import { IsNotEmpty, IsOptional } from 'class-validator'

export class CreateNoticeDto {
  @IsNotEmpty({ message: '参数 $property  不能为空' })
  title: string

  @IsNotEmpty({ message: '参数 $property  不能为空' })
  noticeType: string

  @IsOptional()
  status: string

  @IsNotEmpty({ message: '参数 $property  不能为空' })
  content: string
}
```

**UpdateDto（继承 + PartialType + id + Exclude）：**

```typescript
import { Exclude } from 'class-transformer'
import { PartialType } from '@nestjs/mapped-types'
import { IsNotEmpty } from 'class-validator'

export class UpdateNoticeDto extends PartialType(CreateNoticeDto) {
  @IsNotEmpty({ message: '参数 $property  不能为空' })
  id: string

  @Exclude()
  createBy: string
}
```

**QueryDto（继承 PaginationDto）：**

```typescript
export class QueryNoticeDto extends PaginationDto {
  @IsOptional()
  title: string

  @IsOptional()
  noticeType: string

  @IsOptional()
  status: string
}
```

**规则：**

- 校验消息固定格式: `'参数 $property  不能为空'`（注意 $property 后有两个空格）
- 必填用 `@IsNotEmpty`，可选用 `@IsOptional`，字符串用 `@IsString`
- `QueryDto extends PaginationDto`（来自 `@/common`，不可手写 pageNo/pageSize）
- `UpdateDto extends PartialType(CreateDto)` + 单独写 `id` + `@Exclude()` 掉 `createBy`
- **树形模式**: 在 CreateDto 和 UpdateDto 中各加一个 `@IsOptional()` 的 `parentId: string`

### 1-3. Service

文件路径: `apps/server/src/modules/<area>/<module>/<module>.service.ts`

```typescript
import { BusinessException, CommonConstant, NoticeEntity } from '@/common'
import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { Equal, FindOptionsWhere, In, Like, Not, Repository } from 'typeorm'
import { CreateNoticeDto, QueryNoticeDto, UpdateNoticeDto } from './notice.dto'

@Injectable()
export class NoticeService {
  constructor(@InjectRepository(NoticeEntity) private readonly noticeRepository: Repository<NoticeEntity>) {}

  public async create(createDto: CreateNoticeDto) {
    const { title } = createDto
    const exists = await this.noticeRepository.existsBy({ title: Equal(title) })
    if (exists) throw new BusinessException('公告标题已存在')
    const entity = new NoticeEntity()
    Object.assign(entity, createDto)
    await this.noticeRepository.save(entity)
    return '添加成功'
  }

  public async update(updateDto: UpdateNoticeDto) {
    const { id, title } = updateDto
    const exist = await this.noticeRepository.findOneBy({ id: Equal(id) })
    if (!exist) throw new BusinessException('公告不存在')
    if (title && title !== exist.title) {
      const exists = await this.noticeRepository.existsBy({ title: Equal(title), id: Not(id) })
      if (exists) throw new BusinessException('公告标题已存在')
    }
    Object.assign(exist, updateDto)
    await this.noticeRepository.save(exist)
    return '修改成功'
  }

  public async delete(ids: string[]) {
    const list = await this.noticeRepository.findBy({ id: In(ids) })
    if (!list.length) throw new BusinessException('公告不存在')
    await this.noticeRepository.delete(ids)
    return '删除成功'
  }

  public async findList(queryParams: QueryNoticeDto) {
    const { skip, take, title, noticeType, status } = queryParams
    const queryBuilder = this.noticeRepository.createQueryBuilder('notice')
    const where: FindOptionsWhere<NoticeEntity> = {}
    if (title) where.title = Like(`%${title}%`)
    if (noticeType) where.noticeType = Equal(noticeType)
    if (status) where.status = Equal(status)
    queryBuilder.where(where)
    queryBuilder.orderBy('notice.createTime', 'DESC')
    queryBuilder.skip(skip).take(take)
    const [records, total] = await queryBuilder.getManyAndCount()
    return { total, records }
  }

  public async findOneById(id: string) {
    const data = await this.noticeRepository.findOneBy({ id: Equal(id) })
    if (!data) throw new BusinessException('公告不存在')
    return data
  }
}
```

**规则：**

- **所有 `findOneBy`/`findBy`/`existsBy`（非 queryBuilder 场景）必须显式使用 TypeORM 运算符**：
  - 精确匹配用 `Equal()`，例如 `findOneBy({ id: Equal(id) })`
  - 不等于用 `Not()`，例如 `existsBy({ title: Equal(title), id: Not(id) })`
  - 批量匹配用 `In()`，例如 `findBy({ id: In(ids) })`
  - ⚠️ 禁止直接传原始值（如 `findOneBy({ id })`），否则 `undefined` 会命中第一条记录而非精确匹配
- `create` 名称为字符串精确查重 → `existsBy({ name: Equal(name) })`
- `update` 名称为字符串且排除自身 → `existsBy({ name: Equal(name), id: Not(id) })`
- `delete` 入参 `ids: string[]`，先 `findBy({ id: In(ids) })` 检查存在性
- `findList` 必须用 `createQueryBuilder` + `getManyAndCount`（一次查询拿 data + total），不用 `findAndCount`
- 字段类型为 text 的不要做 Equal 查询，只在 `QueryDto` 中不给它加查询条件
- **树形模式**: `findList` 返回 `listToTree(records)`（from `@/utils`）

### 1-4. Controller

文件路径: `apps/server/src/modules/<area>/<module>/<module>.controller.ts`

```typescript
import { NoticeService } from './notice.service'
import { OperLog, BusinessType, PaginationPipe, RequirePermissions, RepeatSubmit } from '@/common'
import { CreateNoticeDto, QueryNoticeDto, UpdateNoticeDto } from './notice.dto'
import { Controller, Get, Post, Put, Delete, Body, ParseArrayPipe, Query } from '@nestjs/common'

@Controller('system/notice')
export class NoticeController {
  constructor(private readonly noticeService: NoticeService) {}

  @Post('create')
  @RequirePermissions(['system:notice:create'])
  @OperLog({ title: '公告管理', businessType: BusinessType.INSERT })
  @RepeatSubmit()
  create(@Body() createDto: CreateNoticeDto) {
    return this.noticeService.create(createDto)
  }

  @Put('update')
  @RequirePermissions(['system:notice:update'])
  @OperLog({ title: '公告管理', businessType: BusinessType.UPDATE })
  @RepeatSubmit()
  update(@Body() updateDto: UpdateNoticeDto) {
    return this.noticeService.update(updateDto)
  }

  @Delete('delete')
  @RequirePermissions(['system:notice:delete'])
  @OperLog({ title: '公告管理', businessType: BusinessType.DELETE })
  delete(@Query('ids', new ParseArrayPipe()) ids: string[]) {
    return this.noticeService.delete(ids)
  }

  @Get('list')
  @RequirePermissions(['system:notice:query'])
  list(@Query(PaginationPipe) queryParams: QueryNoticeDto) {
    return this.noticeService.findList(queryParams)
  }

  @Get('detail')
  @RequirePermissions(['system:notice:query'])
  detail(@Query('id') id: string) {
    return this.noticeService.findOneById(id)
  }
}
```

**规则：**

- `@Get` list (分页列表) 和 `@Get` detail (详情) → 传参用 `@Query`，**不加 `@RepeatSubmit` 和 `@OperLog`**，只加 `@RequirePermissions`
- `@Post` create → 传参用 `@Body`，**三个装饰器齐全**: `@RequirePermissions` + `@OperLog` + `@RepeatSubmit`
- `@Put` update → 传参用 `@Body`，**三个装饰器齐全**: `@RequirePermissions` + `@OperLog` + `@RepeatSubmit`
- `@Delete` delete → 传参用 `@Query('ids', new ParseArrayPipe())`，**三个装饰器齐全**: `@RequirePermissions` + `@OperLog` + `@RepeatSubmit`
- `@OperLog` 的 `title` 为模块中文名，`businessType` 与 HTTP 动词对应: INSERT / UPDATE / DELETE
- 权限码格式: `<area>:<module>:query / create / update / delete`
- 不写 `export/import/clear` 等功能

### 1-5. Module + 注册

文件路径: `apps/server/src/modules/<area>/<module>/<module>.module.ts`

```typescript
import { Module } from '@nestjs/common'
import { TypeOrmModule } from '@nestjs/typeorm'
import { NoticeEntity } from '@/common'
import { NoticeController } from './notice.controller'
import { NoticeService } from './notice.service'

@Module({
  imports: [TypeOrmModule.forFeature([NoticeEntity])],
  controllers: [NoticeController],
  providers: [NoticeService],
})
export class NoticeModule {}
```

**注册提示**（不自动改，只输出提示）:

```
在 apps/server/src/modules/system/system.module.ts 中:
  import { NoticeModule } from './notice/notice.module'
  imports: [..., NoticeModule]
```

---

## 前端生成规范

### 2-1. Types

文件路径: `apps/admin/src/types/api/<area>/<module>.ts`

```typescript
export interface NoticeQueryParams extends PaginationParams {
  title?: string
  noticeType?: string
  status?: string
}

export interface NoticeEntity extends BaseEntity {
  id: string
  title: string
  noticeType: string
  status: string
  content: string
}
```

**规则:**

- 字段名为 camelCase
- `BaseEntity` / `PaginationParams` 从现有 types 继承
- 可选字段 `?` 标注

**注册提示:**

```
在 apps/admin/src/types/index.ts 中:
  export * from './api/system/notice'
```

### 2-2. API Request

文件路径: `apps/admin/src/api/<area>/<module>.request.ts`

```typescript
import { request } from '@/utils/request'
import type { NoticeEntity, NoticeQueryParams } from '@/types'

export abstract class NoticeRequest {
  static create(data: NoticeEntity): Promise<string> {
    return request.post('/system/notice/create', data)
  }

  static update(data: NoticeEntity): Promise<string> {
    return request.put('/system/notice/update', data)
  }

  static delete(params: { ids: string }): Promise<string> {
    return request.delete('/system/notice/delete', { params })
  }

  static findList(params: NoticeQueryParams): PaginationResponse<NoticeEntity> {
    return request.get('/system/notice/list', { params })
  }

  static findDetail(params: { id: string }): Promise<NoticeEntity> {
    return request.get('/system/notice/detail', { params })
  }
}
```

**规则:**

- `abstract class` + 静态方法，不写 constructor
- `GET` (list/detail) → 用 `{ params }` 传 Query 参数
- `POST` (create) → 第二个参数直接传 `data`（Body）
- `PUT` (update) → 第二个参数直接传 `data`（Body）
- `DELETE` (delete) → 用 `{ params }` 传 Query 参数（ids）
- URL 去掉 `/api` 前缀（request 实例的 baseURL 已配），用 Controller 方法上的小写路径

### 2-3. index.vue

文件路径: `apps/admin/src/views/<area>/<module>/index.vue`

**核心结构（必须一模一样，不能自由发挥）:**

```vue
<template>
  <div class="app-content">
    <ProSearch :items v-model="queryParams" @query="handleQuery" @reset="resetQuery" v-permissions="['system:notice:query']" />

    <div class="mb-16px">
      <el-button plain type="primary" @click="handleCreate" v-permissions="['system:notice:create']">
        <template #icon> <SvgIcon name="Plus" /> </template>
        <span>新增</span>
      </el-button>
      <el-button plain type="danger" @click="handleDelete()" :disabled="!isMultiple" v-permissions="['system:notice:delete']">
        <template #icon> <SvgIcon name="Delete" /> </template>
        <span>批量删除</span>
      </el-button>
    </div>

    <ProTable ref="tableRef" :loading="loading" :data="list" :columns="columns" @selection-change="handleSelectionChange">
      <template #status="{ row }">
        <DictTag :options="sys_normal_disable" :value="row.status" />
      </template>
      <template #action="{ row }">
        <el-link type="primary" @click="handleEdit(row)" v-permissions="['system:notice:update']">修改</el-link>
        <el-link type="primary" @click="handleDelete(row)" v-permissions="['system:notice:delete']">删除</el-link>
      </template>
    </ProTable>

    <ProPagination :total v-model:page="queryParams.pageNo" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <el-dialog v-model="visible" :title="dialogTitle" :close-on-click-modal="false" :width="dialogWidth">
      <el-form ref="formRef" :model="form" :rules="rules" label-width="100px" :labelPosition>
        <!-- 表单字段: 必填字段用 el-input + v-model.trim -->
        <el-form-item label="公告标题" prop="title">
          <el-input v-model.trim="form.title" placeholder="请输入公告标题" />
        </el-form-item>
        <!-- 字典字段用 el-select + DictTag 数据源的 options -->
        <el-form-item label="公告类型" prop="noticeType">
          <el-select v-model="form.noticeType" placeholder="请选择" style="width: 100%">
            <el-option v-for="item in noticeTypeOptions" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
        <!-- 状态字段用 el-radio-group + sys_normal_disable -->
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status" :options="sys_normal_disable" />
        </el-form-item>
        <!-- text 字段用 el-input type="textarea" -->
        <el-form-item label="公告内容" prop="content">
          <el-input v-model.trim="form.content" type="textarea" placeholder="请输入公告内容" :rows="4" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="closeDialog">取消</el-button>
        <el-button type="primary" @click="handleSubmit">确定</el-button>
      </template>
    </el-dialog>
  </div>
</template>
```

**script setup 部分（严格顺序）:**

```vue
<script setup lang="ts">
import { TipModal } from '@/utils'
import { CommonConstant } from '@/common'
import { NoticeRequest } from '@/api/system/notice.request'
import type { ProTableColumn, ProSearchItem, NoticeEntity, NoticeQueryParams } from '@/types'

const router = useRouter()
const { sys_normal_disable } = useDict('sys_normal_disable')
// 如果模块有自定义字典类型，同时声明:
const { noticeTypeOptions } = useDict('sys_notice_type')
```

**变量声明（严格顺序和命名）：**

```typescript
const list = ref<NoticeEntity[]>([])
const multipleSelection = ref<NoticeEntity[]>([])
const total = ref<number>(0)
const loading = ref<boolean>(true)
const isMultiple = computed(() => multipleSelection.value.length > 0)
const tableRef = useTemplateRef('tableRef')
const queryParams = ref<NoticeQueryParams>({ pageNo: 1, pageSize: 10 })

const visible = ref<boolean>(false)
const dialogTitle = ref<string>('新增公告')
const formRef = useTemplateRef('formRef')
const form = ref({ status: CommonConstant.STATUS_NORMAL } as NoticeEntity)
const isUpdate = computed(() => !!form.value.id)

const appStore = useAppStore()
const dialogWidth = computed(() => (appStore.isDesktop ? '600px' : 'calc(100% - 32px)'))
const labelPosition = computed(() => (appStore.isDesktop ? 'left' : 'top'))
```

**ProSearch items（type 在前）：**

```typescript
const items: ProSearchItem[] = [
  { type: 'input', prop: 'title', label: '公告标题' },
  { type: 'select', prop: 'noticeType', label: '公告类型', options: noticeTypeOptions },
  { type: 'select', prop: 'status', label: '状态', options: sys_normal_disable },
]
```

**ProTable columns（字典字段用 slot + DictTag，action 固定最后）：**

```typescript
const columns: ProTableColumn<NoticeEntity>[] = [
  { align: 'center', type: 'selection' },
  { align: 'center', type: 'index', label: '序号', width: 64 },
  { align: 'center', prop: 'title', label: '公告标题', showOverflowTooltip: true, minWidth: 120 },
  { align: 'center', prop: 'noticeType', label: '公告类型', slot: 'noticeType', minWidth: 90 },
  { align: 'center', prop: 'status', label: '状态', slot: 'status' },
  { align: 'center', prop: 'createTime', label: '创建时间', minWidth: 170 },
  { align: 'center', slot: 'action', label: '操作', fixed: 'right', width: 120 },
]
```

**表单校验（rule 和字段 label 一致）：**

```typescript
const rules = {
  title: [{ required: true, message: '公告标题不能为空', trigger: 'blur' }],
  noticeType: [{ required: true, message: '公告类型不能为空', trigger: 'change' }],
  status: [{ required: true, message: '状态不能为空', trigger: 'change' }],
  content: [{ required: true, message: '公告内容不能为空', trigger: 'blur' }],
}
```

**方法实现（必须 8 个，命名不可变）：**

```typescript
async function getList() {
  try {
    loading.value = true
    const data = await NoticeRequest.findList(queryParams.value)
    list.value = data.records
    total.value = data.total
  } catch (error) {
    console.error('NoticeRequest findList error:', error)
    return Promise.reject(error)
  } finally {
    loading.value = false
  }
}

function handleQuery() { queryParams.value.pageNo = 1; getList() }
function resetQuery() { queryParams.value = { pageNo: 1, pageSize: 10 }; getList() }

function handleSelectionChange(row: NoticeEntity[]) { multipleSelection.value = row }

function handleCreate() { dialogTitle.value = '新增公告'; resetForm(); visible.value = true }
function handleEdit(row: NoticeEntity) {
  dialogTitle.value = '修改公告'
  form.value = { ...row }
  visible.value = true
}

async function handleDelete(row?: NoticeEntity) {
  try {
    const { cancel } = await TipModal.confirm('确定要删除选中的数据吗？')
    if (cancel) return TipModal.msg('操作取消')
    const ids = row ? row.id : multipleSelection.value.map((item) => item.id).join(',')
    await NoticeRequest.delete({ ids })
    if (list.value.length <= 1) {
      queryParams.value.pageNo = queryParams.value.pageNo > 1 ? queryParams.value.pageNo - 1 : 1
    }
    await getList()
    TipModal.msgSuccess('删除成功')
    if (!row) {
      multipleSelection.value = []
      tableRef.value?.clearSelection()
    }
  } catch (error) {
    console.error('NoticeRequest delete error:', error)
    return Promise.reject(error)
  }
}

async function handleSubmit() {
  try {
    await formRef.value?.validate()
    const func = isUpdate.value ? NoticeRequest.update : NoticeRequest.create
    await func(form.value)
    TipModal.msgSuccess(isUpdate.value ? '修改成功' : '新增成功')
    closeDialog()
    await getList()
  } catch (error: unknown) {
    console.error('error: ', error)
  }
}

function closeDialog() { visible.value = false; resetForm() }
function resetForm() { form.value = { status: CommonConstant.STATUS_NORMAL } as NoticeEntity; formRef.value?.resetFields() }

getList()
</script>

<style lang="scss" scoped></style>
```

**规则：**

- 每个字段在 `<template>` 的 `#xxx="{ row }"` slot 中都要有对应的 `<DictTag>` 或文本渲染
- `<SvgIcon name="" />` 的 name 必须是 `assets/icons` 下存在的文件名
- import 从上到下按行长度短→长排序（含 type imports，整体行长度）
- `<el-button>` 的 icon 统一用 `<template #icon>` 格式
- `ProTable` 使用 `:loading` prop 绑定，非 `v-loading` 指令；`loading` 变量在 `getList` 中必须被赋值
- `ProPagination` 同名属性简写 `:total`，不写 `v-show="total > 0"`（空数据也展示分页）
- entity 有 `status` 字段时，`form` 默认 `{ status: CommonConstant.STATUS_NORMAL }`，需 `import { CommonConstant } from '@/common'`
- `handleDelete` 必须包含 `try/catch`，批量删除后需清理 `multipleSelection` + `tableRef.clearSelection()`，且末页最后一条删除时回退 `pageNo`
- 不写任何注释
- 不要用 UnoCSS 原子类，样式写 `<style lang="scss" scoped>` 内

### 2-4. 注册提示

```
🔧 需要手动操作：

1. 在 apps/admin/src/types/index.ts 中添加导出:
   export * from './api/system/notice'

2. 动态路由（列表页不需要改 router.database.ts）:
   登录后台 → 菜单管理 → 新增菜单:
     菜单名称: 公告管理
     路由地址: notice
     组件路径: system/notice/index
     权限标识: system:notice:query
     菜单图标: Tool
```
