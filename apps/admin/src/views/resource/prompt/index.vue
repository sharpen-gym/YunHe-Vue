<template>
  <div class="app-content">
    <ProSearch :items v-model="queryParams" @query="handleQuery" @reset="resetQuery" v-permissions="['resource:prompt:query']" />

    <div class="mb-16px">
      <el-button plain type="primary" @click="handleCreate" v-permissions="['resource:prompt:create']">
        <template #icon> <SvgIcon name="Plus" /> </template>
        <span>新增</span>
      </el-button>
      <el-button plain type="danger" @click="handleDelete()" :disabled="!isMultiple" v-permissions="['resource:prompt:delete']">
        <template #icon> <SvgIcon name="Delete" /> </template>
        <span>批量删除</span>
      </el-button>
    </div>

    <ProTable ref="tableRef" :loading="loading" :data="list" :columns="columns" @selection-change="handleSelectionChange">
      <template #type="{ row }">
        <DictTag :options="res_prompt_type" :value="row.type" />
      </template>
      <template #status="{ row }">
        <DictTag :options="sys_normal_disable" :value="row.status" />
      </template>
      <template #action="{ row }">
        <el-link type="primary" @click="handleEdit(row)" v-permissions="['resource:prompt:update']">修改</el-link>
        <el-link type="primary" @click="handleDelete(row)" v-permissions="['resource:prompt:delete']">删除</el-link>
        <el-link type="primary" @click="handleCopy(row)">复制</el-link>
      </template>
    </ProTable>

    <ProPagination :total v-model:page="queryParams.pageNo" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <el-dialog v-model="visible" :title="dialogTitle" :close-on-click-modal="false" :width="dialogWidth">
      <el-form ref="formRef" :model="form" :rules="rules" label-width="100px" :labelPosition>
        <el-form-item label="提示词标题" prop="title">
          <el-input v-model.trim="form.title" placeholder="请输入提示词标题" />
        </el-form-item>
        <el-form-item label="提示词类型" prop="type">
          <el-select v-model="form.type" placeholder="请选择提示词类型" :options="res_prompt_type" />
        </el-form-item>
        <el-form-item label="提示词状态" prop="status">
          <el-radio-group v-model="form.status" :options="sys_normal_disable" />
        </el-form-item>
        <el-form-item label="提示词内容" prop="content">
          <el-input v-model.trim="form.content" type="textarea" placeholder="请输入提示词内容" maxlength="5000" :rows="8" show-word-limit />
        </el-form-item>
        <el-form-item label="提示词备注" prop="remark">
          <el-input v-model.trim="form.remark" type="textarea" placeholder="请输入备注" :rows="3" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="closeDialog">取消</el-button>
        <el-button type="primary" @click="handleSubmit">确定 </el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { CommonConstant } from '@/common'
import { copyText, TipModal } from '@/utils'
import { PromptRequest } from '@/api/resource/prompt.request'
import type { ProTableColumn, ProSearchItem } from '@/types'
import type { PromptEntity, PromptQueryParams } from '@/types'

const { sys_normal_disable, res_prompt_type } = useDict('sys_normal_disable', 'res_prompt_type')

const list = ref<PromptEntity[]>([])
const multipleSelection = ref<PromptEntity[]>([])
const total = ref<number>(0)
const loading = ref<boolean>(true)
const isMultiple = computed(() => multipleSelection.value.length > 0)
const tableRef = useTemplateRef('tableRef')
const queryParams = ref<PromptQueryParams>({ pageNo: 1, pageSize: 10 })

const visible = ref<boolean>(false)
const dialogTitle = ref<string>('新增提示词')
const formRef = useTemplateRef('formRef')
const form = ref({ status: CommonConstant.STATUS_NORMAL } as PromptEntity)
const isUpdate = computed(() => !!form.value.id)

const appStore = useAppStore()
const dialogWidth = computed(() => (appStore.isDesktop ? '720px' : 'calc(100% - 32px)'))
const labelPosition = computed(() => (appStore.isDesktop ? 'left' : 'top'))

const items: ProSearchItem[] = [
  { type: 'input', prop: 'title', label: '标题' },
  { type: 'select', prop: 'type', label: '类型', options: res_prompt_type },
  { type: 'select', prop: 'status', label: '状态', options: sys_normal_disable },
]

const columns: ProTableColumn<PromptEntity>[] = [
  { align: 'center', type: 'selection' },
  { align: 'center', type: 'index', label: '序号', width: 64 },
  { align: 'center', prop: 'title', label: '提示词标题', showOverflowTooltip: true, minWidth: 120 },
  { align: 'center', slot: 'type', label: '提示词类型', showOverflowTooltip: true, minWidth: 120 },
  { align: 'center', prop: 'status', label: '状态', slot: 'status' },
  { align: 'center', prop: 'remark', label: '备注', showOverflowTooltip: true, minWidth: 120 },
  { align: 'center', prop: 'createTime', label: '创建时间', minWidth: 170 },
  { align: 'center', slot: 'action', label: '操作', fixed: 'right', width: 120 },
]

const rules = {
  title: [
    { required: true, message: '提示词标题不能为空', trigger: 'blur' },
    { min: 1, max: 16, message: '提示词标题长度必须在 1 到 16 个字符之间', trigger: 'blur' },
  ],
  type: [{ required: true, message: '提示词类型不能为空', trigger: 'change' }],
  status: [{ required: true, message: '状态不能为空', trigger: 'change' }],
  content: [{ required: true, message: '提示词内容不能为空', trigger: 'blur' }],
}

async function getList() {
  try {
    loading.value = true
    const data = await PromptRequest.findList(queryParams.value)
    list.value = data.records
    total.value = data.total
  } catch (error) {
    console.error('PromptRequest findList error:', error)
    return Promise.reject(error)
  } finally {
    loading.value = false
  }
}

function handleQuery() {
  queryParams.value.pageNo = 1
  getList()
}
function resetQuery() {
  queryParams.value = { pageNo: 1, pageSize: 10 }
  getList()
}

function handleSelectionChange(row: PromptEntity[]) {
  multipleSelection.value = row
}
function handleCopy(row: PromptEntity) {
  copyText(row.content)
}

function handleCreate() {
  dialogTitle.value = '新增提示词'
  resetForm()
  visible.value = true
}
function handleEdit(row: PromptEntity) {
  dialogTitle.value = '修改提示词'
  form.value = { ...row }
  visible.value = true
}

async function handleDelete(row?: PromptEntity) {
  try {
    const { cancel } = await TipModal.confirm('确定要删除选中的数据吗？')
    if (cancel) return TipModal.msg('操作取消')
    const ids = row ? row.id : multipleSelection.value.map((item) => item.id).join(',')
    await PromptRequest.delete({ ids })
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
    console.error('PromptRequest delete error:', error)
    return Promise.reject(error)
  }
}

async function handleSubmit() {
  try {
    await formRef.value?.validate()
    const func = isUpdate.value ? PromptRequest.update : PromptRequest.create
    await func(form.value)
    TipModal.msgSuccess(isUpdate.value ? '修改成功' : '新增成功')
    closeDialog()
    await getList()
  } catch (error: unknown) {
    console.error('error: ', error)
  }
}

function closeDialog() {
  visible.value = false
  resetForm()
}
function resetForm() {
  form.value = { status: CommonConstant.STATUS_NORMAL } as PromptEntity
  formRef.value?.resetFields()
}

getList()
</script>

<style lang="scss" scoped></style>
