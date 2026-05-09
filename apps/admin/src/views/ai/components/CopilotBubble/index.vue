<template>
  <div :class="classes">
    <!-- 头像 -->
    <div class="bubble-avatar">
      <img :src="messageAvatar" class="wh-full object-cover" draggable="false" alt="bubble avatar" />
    </div>

    <!-- 消息区域 -->
    <div class="bubble-body">
      <!-- 消息内容 -->
      <div class="bubble-content">
        <!-- 正在请求的最后一条AI消息：显示loading -->
        <template v-if="isAssistant && currentMessage.content === ''">
          <span class="c-[--el-color-info]">思考中...</span>
        </template>

        <!-- 用户消息：普通文本 -->
        <template v-else-if="isHuman">
          <span>{{ currentMessage.content }}</span>
        </template>

        <!-- AI 消息：流式 Markdown 渲染 -->
        <template v-else-if="isAssistant">
          <MarkdownRender custom-id="doc" class="markdown-render" :content="currentMessage.content" />
        </template>
      </div>

      <!-- 操作栏 -->
      <div v-if="showActions" class="bubble-actions flex items-center gap-8px">
        <SvgIcon name="Copy" @click="copyText(currentMessage.content)" />
        <SvgIcon v-if="isLastAssistant" name="Refresh" @click="emits('regenerate')" />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
defineOptions({ name: 'CopilotBubble' })
import 'markstream-vue/index.css' // https://markstream-vue-docs.simonhe.me/zh
import 'katex/dist/katex.min.css'
import CodeBlockNode from './CodeBlockNode.vue'
import { copyText } from '@/utils'
import type { Message } from '@/types'
import MarkdownRender, { setCustomComponents } from 'markstream-vue'

const userStore = useUserStore()

const props = withDefaults(
  defineProps<{
    index: number
    messages: Message[]
  }>(),
  {},
)

const emits = defineEmits<{
  regenerate: []
}>()

const aiStore = useAiStore()

/** 自定义组件注册 | 覆盖 markstream-vue 的默认组件 */
setCustomComponents('doc', { code_block: CodeBlockNode })

/** 当前的消息内容 */
const currentMessage = computed(() => props.messages[props.index])

/** 当前的消息容器类名 */
const classes = computed(() => ['copilot-bubble', `copilot-bubble--${currentMessage.value.role}`])

/** 是否为 AI 消息 */
const isAssistant = computed(() => currentMessage.value.role === 'assistant')

/** 是否为用户消息 */
const isHuman = computed(() => ['human', 'user'].includes(currentMessage.value.role))

/** 消息头像 */
// const messageAvatar = computed(() => (isHuman.value ? userStore.avatar : 'https://picsum.photos/200/200'))
const messageAvatar = computed(() => (isHuman.value ? userStore.avatar : '/img/logo.png'))

/** 是否显示操作栏 */
const showActions = computed(() => !aiStore.loading && currentMessage.value.content && isAssistant.value)

/** 是否为最后一条 AI 消息 */
const isLastAssistant = computed(() => {
  if (!isAssistant.value) return false
  const lastAssistantIndex = [...props.messages].reverse().findIndex((m) => m.role === 'assistant')
  if (lastAssistantIndex === -1) return false
  const actualIndex = props.messages.length - 1 - lastAssistantIndex
  return actualIndex === props.index
})
</script>

<style lang="scss" scoped>
.copilot-bubble {
  --copilot-bubble-font-size: var(--el-font-size-base); // 消息字体大小
  --copilot-bubble-gap: 16px; // 消息容器间距
  --copilot-bubble-avatar-size: 42px; // 头像大小
  --copilot-bubble-content-bg-color: var(--el-bg-color); // 消息内容背景颜色
  --copilot-bubble-triangle-size: 8px; // 消息内容三角形大小
  --copilot-bubble-content-gap: 4px; // 消息内容与头像间距
}

.copilot-bubble {
  display: flex;
  align-items: flex-start;
  gap: calc(var(--copilot-bubble-content-gap) + var(--copilot-bubble-triangle-size));
  font-size: var(--copilot-bubble-font-size);
  .bubble-avatar {
    flex-shrink: 0;
    width: var(--copilot-bubble-avatar-size);
    height: var(--copilot-bubble-avatar-size);
    border-radius: 4px;
    overflow: hidden;
  }
  .bubble-body {
    display: flex;
    flex-direction: column;
    gap: 8px;
    width: auto;
    max-width: 64%;
    min-width: 0; /* 必须加，否则子元素无法收缩 */
  }
  .bubble-body:has(.code-block-container) {
    width: 90%;
  }
  .bubble-content {
    position: relative;
    padding: 10px 8px;
    border-radius: 4px;
    line-height: 1.5;
    word-break: break-all;
    background-color: var(--copilot-bubble-content-bg-color);
  }
  .bubble-actions {
    .svg-icon {
      font-size: 1.5em;
      transition: all var(--el-transition-duration-fast) ease-in-out;
    }
    .svg-icon:hover {
      cursor: pointer;
      color: var(--el-color-primary);
    }
  }
}

.copilot-bubble--human,
.copilot-bubble--user {
  --copilot-bubble-content-bg-color: var(--el-color-success-light-5);
  flex-direction: row-reverse;
}

.copilot-bubble + .copilot-bubble {
  margin-top: var(--copilot-bubble-gap);
}

// 消息气泡的三角形
.bubble-content::after {
  content: '';
  position: absolute;
  top: calc(var(--copilot-bubble-avatar-size) / 2 - var(--copilot-bubble-triangle-size));
  width: 0;
  height: 0;
  border-top: var(--copilot-bubble-triangle-size) solid transparent;
  border-bottom: var(--copilot-bubble-triangle-size) solid transparent;
}
.copilot-bubble--assistant .bubble-content::after {
  left: calc(-1 * var(--copilot-bubble-triangle-size));
  border-right: var(--copilot-bubble-triangle-size) solid var(--copilot-bubble-content-bg-color);
}
.copilot-bubble--human .bubble-content::after,
.copilot-bubble--user .bubble-content::after {
  right: calc(-1 * var(--copilot-bubble-triangle-size));
  border-left: var(--copilot-bubble-triangle-size) solid var(--copilot-bubble-content-bg-color);
}
</style>
