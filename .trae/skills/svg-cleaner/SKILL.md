---
name: svg-cleaner
description: 清理 SVG 图标冗余属性（fill/class/version/width/height 等），减小体积并统一风格。当用户说"清理 SVG""优化 SVG 图标""svg 去冗余""svg clean"时自动调用。
---

# SVG 图标清理器

调用 `scripts/svg-clean.ts` 脚本，批量移除项目中 SVG 图标文件的冗余属性与多余空白。

## 清理规则

移除以下冗余属性：

- `fill` — 统一由 CSS 控制颜色，避免硬编码
- `class` — 移除内联 class
- `version` — SVG 版本声明，非必要
- `t` / `p-id` — 设计工具（如 Adobe Illustrator）残留属性
- `width` / `height` — 统一由外部容器控制尺寸

同时压缩标签内多余空白（多个空格 → 单个空格，` />` → `/>`）。

## 扫描范围

默认扫描 `apps/admin/src/assets/icons` 目录下所有 `.svg` 文件（含子目录）。

## 执行方式

直接运行清理脚本：

```bash
pnpm svg:clean
```

## 安全说明

- 仅在内容发生变化时才覆写原文件，无变化的 SVG 直接跳过
- 建议清理前确保 SVG 源文件已纳入版本控制，以便回滚
