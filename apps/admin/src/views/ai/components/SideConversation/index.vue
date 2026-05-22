<template>
  <el-aside>
    <header>
      <el-button @click="aiStore.createConversation">
        <template #icon> <SvgIcon name="Plus" /> </template>
        <span>新增会话</span>
      </el-button>
    </header>
    <Conversations
      row-key="id"
      labelKey="title"
      showBuiltInMenu
      v-model:active="aiStore.conversationId"
      :items="aiStore.conversations"
      @menuCommand="aiStore.handleMenuCommand"
      @change="aiStore.handleConversationChange"
    />
  </el-aside>
</template>

<script setup lang="ts">
defineOptions({ name: 'SideConversation' })
import { Conversations } from 'vue-element-plus-x'

const aiStore = useAiStore()
</script>

<style lang="scss" scoped>
.el-aside {
  --el-conversations-width: 240px;
  --el-conversations-text-color: var(--el-text-color-regular);
  --el-conversations-bg-color: var(--el-bg-color);
  --el-conversations-item-hover-bg-color: var(--el-fill-color);
  --el-conversations-item-active-bg-color: var(--el-fill-color);
}

.el-aside {
  width: var(--el-conversations-width);
  color: var(--el-conversations-text-color);
  background-color: var(--el-conversations-bg-color);
  overflow: hidden;

  header {
    display: flex;
    justify-content: center;
    align-items: center;
    padding-top: 8px;
  }
}

:deep() .elx-conversations {
  width: 100%;
  box-shadow: none;
  .elx-conversations__list {
    width: 100% !important; // 原组件全是 style 内联。这里需要加权
    padding: 8px !important;
    border-radius: 0 !important;
    background-color: transparent !important;
  }
  .elx-conversations-item {
    margin-right: 0;
    &__label {
      color: var(--el-conversations-text-color);
    }
    &--active {
      background-color: var(--el-conversations-item-active-bg-color);
    }
    &:hover {
      background-color: var(--el-conversations-item-hover-bg-color);
    }
  }
  .elx-conversations-dropdown-more-icon:hover {
    background-color: rgba(0, 0, 0, 0.32);
  }
}
</style>
