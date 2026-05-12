<template>
  <div class="markdown-editor">
    <MdEditor ref="editorRef" :readOnly :preview :theme v-model="content" :maxLength :toolbars-exclude="toolbarsEExclude" @save="handleSave" :placeholder />
  </div>
</template>

<script setup lang="ts">
defineOptions({ name: 'Markdown', inheritAttrs: false }) // https://imzbf.github.io/md-editor-v3/en-US
import 'md-editor-v3/lib/style.css'
import { linkDownload } from '@/utils'
import type { MarkdownProps } from './types'
import { MdEditor, type ToolbarNames } from 'md-editor-v3'

const settingStore = useSettingStore()

// const content = defineModel({ type: String, default: '' })
const content = ref('')

const props = withDefaults(defineProps<MarkdownProps>(), {
  placeholder: '请输入内容',
  preview: false,
  readOnly: false,
  maxLength: 0,
})

// const editorRef = useTemplateRef('editorRef')
const theme = computed(() => (settingStore.theme === 'dark' ? 'dark' : 'light'))

/** 排除的工具栏 */
const toolbarsEExclude: ToolbarNames[] = ['github']

/** 保存内容 */
function handleSave(value: string) {
  const blob = new Blob([value], { type: 'text/markdown' })
  linkDownload(blob, `${Date.now()}.md`)
}

onMounted(() => {})
</script>

<style lang="scss" scoped>
.markdown-editor {
  position: relative;
  width: 100%;
  height: 100%;
}
.md-editor {
  --md-color: var(--el-text-color-primary);
  --md-border-color: var(--el-border-color);
  width: 100%;
  height: auto;
  min-height: 20em;
  font-family: var(--el-font-family);
}
</style>
