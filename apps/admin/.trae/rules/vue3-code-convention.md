---
alwaysApply: true
scene: vue3_code
---

AI 生成的 Vue3 代码必须遵循以下规则：

# HTML

- SvgIcon 的 name 必须是 assets/icons 下的文件名，没有需要提醒我补充
- 能用 ElementPlus 组件的，优先使用 ElementPus 组件

## CSS

- 色彩优先使用 Element Plus CSS 变量，方便深色主题自动适配
- 优先使用 BEM 风格写，而非原子化样式类
- 布局需要适配桌面端和移动端，html[data-device='mobile'] 代表处于移动端环境
- 路由页面统一挂载 class="app-content"，保持基础样式一致性

## JavaScript

- 函数优先使用 function 而非箭头函数
