<template>
  <div class="app-content h-full copilot-container">
    <!-- 对话记录 -->
    <Conversation ref="conversationRef" @scrollToBottom="scrollToBottom" />

    <main class="copilot-main">
      <!-- 消息列表 -->
      <el-scrollbar ref="scrollbarRef">
        <CopilotBubble v-for="(_, index) in messages" :key="index" :messages="messages" :index="index" @regenerate="reGenerate(index)" />
      </el-scrollbar>

      <!-- 底部的输入框 -->
      <div class="chat-input flex flex-col flex-shrink-0">
        <el-input type="textarea" :autosize="{ minRows: 2, maxRows: 6 }" v-model.trim="prompt" placeholder="请输入问题" @keyup.enter.exact="handleSubmit"></el-input>
        <div class="flex items-center gap-8px">
          <el-tag type="primary" disabled>深度思考</el-tag>
          <el-tag type="primary" :effect="enableInternetSearch ? 'dark' : 'light'" @click="toggleInternetSearch">联网搜索</el-tag>
          <div class="ml-auto flex-center gap-8px">
            <el-link type="danger" @click="clearInput" :disabled="!prompt">清空</el-link>
            <el-link type="primary" @click="handleSubmit" :disabled="loading || !prompt">发送</el-link>
            <el-link type="danger" v-if="loading" @click="stopGenerate">停止</el-link>
            <el-link type="primary" @click="handleExport">导出</el-link>
          </div>
        </div>
      </div>

      <!-- 提示信息 -->
      <div class="tip">AI 生成内容仅供参考，请注意甄别</div>
    </main>
  </div>
</template>

<script setup lang="ts">
import type { Message } from '@/types'
import { linkDownload, sleep, TipModal } from '@/utils'
import Conversation from './components/Conversation/index.vue'
import CopilotBubble from './components/CopilotBubble/index.vue'
import { AiRequest } from '@/api/ai.request'

/** 用户输入的问题 */
const prompt = ref<string>()
/** 滚动条组件实例 */
const scrollbarRef = useTemplateRef('scrollbarRef')
/** 停止生成控制器 */
let abortController: AbortController | null = null
const aiStore = useAiStore()
const messages = computed(() => aiStore.messages)
/** AI 是否正在回复中 */
const loading = computed(() => aiStore.loading)
const enableInternetSearch = computed(() => aiStore.enableInternetSearch)

async function scrollToBottom() {
  await nextTick()
  if (!scrollbarRef.value?.wrapRef) return
  const top = scrollbarRef.value.wrapRef.scrollHeight
  scrollbarRef.value.wrapRef.scrollTo({ top: top, behavior: 'smooth' })
}

async function init() {
  await aiStore.getConversations()
  await sleep(16)
  scrollToBottom()
}

// 抽离公共流式处理函数（发送/重新生成通用）
async function handleStreamResponse(content: string, onUpdate: (content: string) => void) {
  try {
    abortController = new AbortController()
    const signal = abortController.signal
    const data = { message: content, enableInternetSearch: enableInternetSearch.value, conversationId: aiStore.conversationId }
    const stream = await AiRequest.sendMessage(data, { signal })
    const reader = stream.getReader()
    const decoder = new TextDecoder()
    while (true) {
      if (signal.aborted) break
      const { done, value } = await reader.read()
      if (done) break
      const chunk = decoder.decode(value, { stream: true })
      const lines = chunk.split('\n').filter((i) => i.startsWith('data: '))
      for (const line of lines) {
        const data = JSON.parse(line.replace('data: ', ''))
        if (data.status === 'DONE') break
        onUpdate(data.content)
        scrollToBottom()
      }
    }
  } catch (error: unknown) {
    if (error instanceof Error && error?.name === 'AbortError') return
    const errMsg = error instanceof Error ? error.message : '流式处理未知错误'
    onUpdate(errMsg)
  }
}

async function handleSubmit() {
  const question = prompt.value?.trim()
  if (!question) return TipModal.msgError('请先输入问题')

  // 推送用户消息
  aiStore.messages.push({ role: 'user', content: question } as Message)
  aiStore.loading = true
  prompt.value = ''
  // 推送空AI消息
  aiStore.messages.push({ role: 'assistant', content: '' } as Message)
  scrollToBottom()
  const lastIndex = aiStore.messages.length - 1
  try {
    await handleStreamResponse(question, (content) => (aiStore.messages[lastIndex].content += content))
    // 新会话：流式结束刷新会话列表
    if (!aiStore.conversationId) await aiStore.getConversations()
  } catch (error: unknown) {
    const errMsg = error instanceof Error ? error.message : '未知错误'
    aiStore.messages[lastIndex].content = `❌ ${errMsg}`
  } finally {
    aiStore.loading = false
    scrollToBottom()
  }
}

async function reGenerate(aiMessageIndex: number) {
  // 1. 防重：加载中禁止重新生成
  if (aiStore.loading) return TipModal.msgWarning('正在生成中，请稍后')
  // 2. 校验索引合法性
  if (aiMessageIndex < 0 || aiMessageIndex >= messages.value.length) return
  aiStore.loading = true
  try {
    // 3. 截断消息：保留到当前AI消息之前的所有内容（删除旧的AI回复）
    aiStore.messages = aiStore.messages.slice(0, aiMessageIndex)

    // 4. 获取需要重新生成的用户问题（最后一条消息就是用户提问）
    const userQuestion = aiStore.messages.at(-1)?.content
    if (!userQuestion) return TipModal.msgError('未找到用户问题')

    // 5. 新增空的AI消息，用于流式拼接
    const newAiMsg: Message = { role: 'assistant', content: '' } as Message
    aiStore.messages.push(newAiMsg)
    const lastIndex = aiStore.messages.length - 1
    scrollToBottom()

    // 6. 重新请求流式回复
    await handleStreamResponse(userQuestion, (content) => (aiStore.messages[lastIndex].content += content))
  } catch (error: unknown) {
    const errMsg = error instanceof Error ? error.message : '重新生成失败'
    TipModal.msgError(errMsg)
    // 兜底：给最后一条消息赋值错误提示
    if (aiStore.messages.length) aiStore.messages.at(-1)!.content = `❌ ${errMsg}`
  } finally {
    aiStore.loading = false
    scrollToBottom()
  }
}

function clearInput() {
  prompt.value = ''
  TipModal.msgSuccess('清空成功')
}

function handleExport() {
  if (!messages.value.length) return TipModal.msgError('请先发送问题')
  if (aiStore.loading) return TipModal.msgError('请稍后再导出')
  const data = JSON.stringify(messages.value, null, 2)
  const blob = new Blob([data], { type: 'application/json' })
  linkDownload(blob, `${Date.now()}.json`)
}

// 切换联网搜索
function toggleInternetSearch() {
  aiStore.enableInternetSearch = !aiStore.enableInternetSearch
}

/** 停止生成 */
function stopGenerate() {
  if (abortController && !abortController.signal.aborted) abortController.abort()
  aiStore.loading = false
}

init()
</script>

<style lang="scss" scoped>
@use './markdown-render.scss';
.copilot-container {
  // 会话列表宽度
  --ai-conversation-width: 240px;
  position: relative;
  display: flex;
  gap: 16px;
  width: 100%;
}

.copilot-main {
  flex-grow: 1;
  display: flex;
  flex-direction: column;
  gap: 16px;
  min-width: 0; // 保证 flex 右侧宽度不溢出
  height: 100%;
}

.chat-input {
  background-color: var(--el-bg-color);
  border: 1px solid var(--el-border-color);
  border-radius: 8px;
  padding: 12px 16px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  :deep(.el-textarea) {
    margin-bottom: 8px;
  }
  :deep(.el-textarea__inner) {
    box-shadow: none;
    border: none;
    resize: none;
    padding: 0;
  }
  .el-tag {
    user-select: none;
    cursor: pointer;
  }
  .el-button {
    border-radius: 50%;
    width: 36px;
    height: 36px;
    display: flex;
    align-items: center;
    justify-content: center;
  }
}

.tip {
  text-align: center;
  font-size: var(--el-font-size-small);
  color: var(--el-color-info);
}
</style>
