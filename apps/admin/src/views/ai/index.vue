<template>
  <el-container class="ai-wrapper h-full flex flex-col">
    <SideConversation />
    <el-container>
      <el-main>
        <BubbleList :list="list">
          <template #content="{ item }">
            <MarkdownRenderer :markdown="item.content" class="markdown-content-wrapper" />
          </template>
        </BubbleList>
      </el-main>
      <el-footer>
        <XSender autoFocus clearable variant="updown" :loading ref="senderRef" @submit="handleSubmit" />
      </el-footer>
    </el-container>
  </el-container>
</template>

<script setup lang="ts">
import SideConversation from './components/SideConversation/index.vue'
import { XSender, BubbleList } from 'vue-element-plus-x'
import type { BubbleListProps } from 'vue-element-plus-x/types/BubbleList'
import { MarkdownRenderer } from 'x-markdown-vue'
// @ts-ignore
import 'x-markdown-vue/style'

const aiStore = useAiStore()
const userStore = useUserStore()
const loading = computed(() => aiStore.messages.at(-1)?.loading ?? false)

// 消息列表
const list = computed<BubbleListProps['list']>(() =>
  aiStore.messages.map((item) => ({
    ...item,
    typing: item.role === 'assistant',
    isMarkdown: item.role === 'assistant',
    variant: item.role === 'assistant' ? 'filled' : 'outlined',
    placement: item.role === 'assistant' ? 'start' : 'end',
    avatar: item.role === 'assistant' ? `https://q1.qlogo.cn/g?b=qq&nk=1433224387&s=640` : userStore.avatar,
    avatarSize: '24px',
  })),
)

// 输入框
const senderRef = useTemplateRef('senderRef')

async function handleSubmit() {
  const msg = senderRef.value?.getModelValue().text || ''
  senderRef.value?.clear()
  try {
    await aiStore.send(msg)
  } catch (err: unknown) {
    console.log('err: ', err)
    // 请求被主动取消时静默处理
  }
  if (!aiStore.conversationId) await aiStore.getConversations()
}

onMounted(() => {
  aiStore.getConversations()
})
</script>

<style lang="scss" scoped>
// .ai-wrapper {
// }
.el-main {
  padding: 16px;
}
.el-footer {
  height: auto;
}
.ai-wrapper .el-container {
  padding: 16px;
  gap: 16px;
  .el-main {
    padding: 0;
  }
  .el-footer {
    padding: 0;
  }
}

:deep() .markdown-content-wrapper {
  padding: 0 !important;
  color: inherit !important;
  background-color: transparent !important;
  li {
    list-style: revert;
    margin-left: 2em;
  }
}

// 会话区域

.elx-bubble-list {
  --el-bubble-avatar-size: 42px;
  --el-bubble-text-color: var(--el-text-color-primary);
  --el-bubble-bg-color: var(--el-bg-color);
}

:deep() .elx-bubble-list__item {
  .elx-bubble--end {
    --el-bubble-bg-color: var(--el-color-success-light-5);
  }
  .elx-bubble__avatar {
    width: var(--el-bubble-avatar-size);
    height: var(--el-bubble-avatar-size);
    border-radius: 4px;
    overflow: hidden;
  }
  .elx-bubble__content {
    padding: 8px;
    line-height: 1.5;
    color: var(--el-bubble-text-color);
    background-color: var(--el-bubble-bg-color);
  }
}
</style>
