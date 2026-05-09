<template>
  <div class="conversation-container">
    <div class="conversation__header">
      <el-button type="primary" plain @click="createConversation">
        <template #icon> <SvgIcon name="Plus" /> </template>
        <span>开启新对话</span>
      </el-button>
    </div>

    <div class="conversation__content">
      <div class="conversation-item" v-for="item in conversations" :key="item.id" :class="{ 'is-active': item.id === aiStore.conversationId }" @click="changeConversation(item.id)">
        <span class="conversation-title">{{ item.title }}</span>
        <div class="action-group">
          <SvgIcon name="Delete" @click.stop="deleteConversation(item)" class="delete-icon" />
          <SvgIcon name="Edit" @click.stop="updateConversation(item)" class="edit-icon" />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
defineOptions({ name: 'Conversation' })
import { TipModal } from '@/utils'
import { AiRequest } from '@/api/ai.request'
import type { Conversation } from '@/types'

const emits = defineEmits<{
  scrollToBottom: []
}>()

const aiStore = useAiStore()

const conversations = computed(() => aiStore.conversations)

/** 创建新会话 */
function createConversation() {
  if (!aiStore.conversationId && !conversations.value.length) return TipModal.msgWarning('当前处于新会话状态，请直接对话即可')
  aiStore.messages = []
  aiStore.conversationId = undefined
  TipModal.msgSuccess('已创建新会话，请开始对话')
}

/** 切换会话 */
async function changeConversation(conversationId: string) {
  await aiStore.changeConversation(conversationId)
  emits('scrollToBottom')
}

/** 删除会话 */
async function deleteConversation(item: Conversation) {
  const { cancel } = await TipModal.confirm(`确定删除会话 "${item.title}" 吗？`)
  if (cancel) return TipModal.msg('操作已取消')
  await AiRequest.deleteConversation({ conversationId: item.id })
  aiStore.conversationId = undefined
  await aiStore.getConversations()
  emits('scrollToBottom')
}

/** 更新会话 */
async function updateConversation(item: Conversation) {
  const { cancel, value: title } = await TipModal.prompt('请输入新会话标题', { inputValue: item.title })
  if (cancel) return TipModal.msg('操作已取消')
  await AiRequest.updateConversationTitle({ conversationId: item.id, title })
  await aiStore.getConversations()
  TipModal.msgSuccess('操作成功')
  // emits('scrollToBottom')
}
</script>

<style lang="scss" scoped>
.conversation-container {
  flex-shrink: 0;
  width: var(--ai-conversation-width);
  height: 100%;
  border: 1px solid var(--el-border-color);
  border-radius: 8px;
  background-color: var(--el-bg-color);

  .conversation__header {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 8px 0;
  }
  .conversation__content {
    padding: 0 8px;
  }

  .conversation-item {
    --action-group-display: none;
    display: flex;
    align-items: center;
    padding: 0 12px;
    height: 32px;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color var(--el-transition-duration-fast) ease-in-out;
    &:hover {
      --action-group-display: flex;
      background-color: var(--el-fill-color-darker);
    }
    .conversation-title {
      color: var(--el-text-color-regular);
      font-size: var(--el-font-size-base);
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }
    .action-group {
      margin-left: auto;
      display: var(--action-group-display);
      gap: 8px;
    }
  }
  .conversation-item.is-active {
    // color: var(--el-sidebar-active-text-color);
    background-color: var(--el-color-primary-light-9);
  }
}

.delete-icon:hover {
  color: var(--el-color-danger);
}
.edit-icon:hover {
  color: var(--el-color-warning);
}
</style>
