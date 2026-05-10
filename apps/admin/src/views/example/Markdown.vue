<template>
  <div class="app-content h-full">
    <div class="markdown-desc">Markdown 编辑器 | 基于 md-editor-v3 实现，支持实时预览、丰富的工具栏配置、深色模式适配及内容导出功能</div>

    <div class="editor-wrapper">
      <Markdown v-model="content" />
    </div>
  </div>
</template>

<script setup lang="ts">
const content = ref(`# 欢迎使用 Markdown 编辑器

## 功能特性

- **实时预览**：编辑与预览同步进行
- **工具栏丰富**：支持标题、列表、代码块、图片等
- **深色模式**：自动适配主题切换
- **内容导出**：支持将内容导出为 .md 文件

## 代码示例

\`\`\`javascript
function hello() {
  console.log('Hello, World!')
}
\`\`\`

## 表格示例

| 功能 | 描述 |
|------|------|
| 编辑 | 富文本编辑 |
| 预览 | 实时渲染 |
| 导出 | 下载文件 |

> 这是一个引用块，展示 Markdown 的引用语法。
`)
</script>

<style lang="scss" scoped>
.markdown-desc {
  margin-bottom: 16px;
  padding: 8px 16px;
  background: var(--el-fill-color-light);
  border-left: 4px solid var(--el-color-primary);
  border-radius: 4px;
  color: var(--el-text-color-primary);
  font-size: 14px;
  font-weight: 500;
  line-height: 1.5;
}

.editor-wrapper {
  flex: 1;
  min-height: 0;
  border-radius: 8px;
  overflow: hidden;
  background: var(--el-bg-color);
  box-shadow: var(--el-box-shadow-light);
}
</style>
