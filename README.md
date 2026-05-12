<p align="center">
  <img src="https://camo.githubusercontent.com/f73616a67b67a049ba47a95a44e489abf7eac3e5ba5508c4107b3a71443cc78e/68747470733a2f2f692e696d6775722e636f6d2f5236706d6d746f2e6a706567" width="120" alt="云禾管理系统" />
</p>

<h1 align="center">云禾管理系统</h1>

<p align="center">
  云在青天，禾在土；管理在心，事在术。<br />
  不争云端之名，只守禾下之实；不炫繁复之术，但求至简之理。
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Vue-3.5-brightgreen?logo=vuedotjs" alt="Vue" />
  <img src="https://img.shields.io/badge/NestJS-11-red?logo=nestjs" alt="NestJS" />
  <img src="https://img.shields.io/badge/TypeScript-6.0-blue?logo=typescript" alt="TypeScript" />
  <img src="https://img.shields.io/badge/Vite-8.0-purple?logo=vite" alt="Vite" />
  <img src="https://img.shields.io/badge/pnpm-10.33-orange?logo=pnpm" alt="pnpm" />
  <img src="https://img.shields.io/badge/license-MIT-green" alt="License" />
</p>

---

## 📖 简介

**云禾** 是一套面向前端开发者进阶全栈的企业级后台管理系统模板。前端基于 **Vue 3 + TypeScript + Element Plus + Vite 8** 构建，后端采用 **NestJS 11 + TypeORM + MySQL + Redis + BullMQ** 搭建，并以 **pnpm workspace** 的 Monorepo 方式组织全栈代码，让你在一个仓库中同时编写前端与后端，真正打通"前端 → 全栈"的最后一公里。

> 🎯 为什么前端应该关注这个项目？
>
> 你不需要从零学习 Java、Go 或者全新生态。**TypeScript 一把梭**——前端你已经会 Vue 3 和 TS，后端用同一个语言、同一套类型系统，配合 NestJS 和前端框架极其相似的**模块化 / 依赖注入 / 装饰器**开发模式，学完这个项目，你就有了独立交付一个完整后台系统的能力。

---

- 在线预览：[https://cnbox.online](https://cnbox.online)
- 文档地址：[https://ace627.github.io](https://ace627.github.io)
<!-- - 项目概览：[SUMMARY.md](./SUMMARY.md) -->

---

## 🚀 技术选型

| 层级          | 技术栈                  | 说明                                           |
| ------------- | ----------------------- | ---------------------------------------------- |
| **前端框架**  | Vue 3 + Composition API | 最新 Vue 生态，`<script setup lang="ts">` 语法 |
| **前端路由**  | Vue Router 5            | 动态路由 + 权限过滤，从后端实时拉取菜单        |
| **状态管理**  | Pinia 3                 | 轻量级、类型友好的状态管理                     |
| **UI 组件库** | Element Plus 2          | 全套企业级 UI 组件，按需导入                   |
| **构建工具**  | Vite 8 + Rolldown       | 秒级冷启动，Oxc 压缩                           |
| **CSS 方案**  | SCSS + BEM 命名         | 语义化样式，Dark Mode 支持                     |
| **图表库**    | ECharts 6               | 服务监控可视化大屏                             |
| **后端框架**  | NestJS 11               | 行业标准的 Node.js 企业级框架                  |
| **ORM**       | TypeORM                 | 数据库实体映射，支持 Migration                 |
| **数据库**    | MySQL 8                 | 核心业务数据存储                               |
| **缓存**      | Redis 7                 | Token 缓存、接口缓存、BullMQ 队列              |
| **消息队列**  | BullMQ                  | 定时任务调度执行                               |
| **认证**      | JWT + 图片验证码        | Argon2 密码加密，安全可靠                      |
| **日志**      | Winston                 | 按日滚动文件日志                               |
| **容器化**    | Docker + Nginx          | 多阶段构建 + 健康探针 + Nginx 反向代理         |

---

## ✨ 核心功能

### 🧩 系统管理

- **用户管理** — 增删改查、重置密码、修改密码、角色分配、头像设置
- **角色管理** — 角色权限分配、数据权限、角色编码管理
- **菜单管理** — 目录 / 菜单 / 按钮三级粒度，支持外链、内嵌 iframe
- **字典管理** — 字典类型 + 字典数据两级结构，全局 `useDict()` Hook 封装

### 📊 系统监控

- **服务监控** — 实时 CPU 使用率、内存占用、磁盘空间、服务器运行信息
- **缓存监控** — Redis 实例信息、内存使用量、Key 数量、在线可视化管理
- **健康检查** — `/live` `/ready` 双探针，适配 K8s / Docker Swarm 编排
- **在线用户** — 实时查看活跃会话，支持强制下线
- **定时任务** — BullMQ 动态调度，支持手动执行 / 暂停 / 恢复
- **操作日志** — 全接口自动记录，IP 归属地解析
- **登录日志** — 登录成功 / 失败全量记录

### 📁 文件上传

- **单文件上传** — 常规小文件直接上传，10MB 以下
- **分片上传** — 大文件自动切分，并发上传
- **断点续传** — 网络中断后恢复，不浪费已传分片
- **秒传机制** — 已存在文件秒传，零等待

### 🎨 视觉体验

- **暗黑模式** — 一键切换明暗主题，CSS 变量全局控制
- **多标签页** — 类浏览器 Tab 交互，支持刷新 / 关闭 / 右键菜单
- **响应式布局** — 适配 PC / Pad / Mobile，侧边栏自动折叠
- **布局设置** — 侧边栏 Logo、面包屑、标签页、动态标题均可自定义开关

---

## 🏗️ 项目结构

```
YunHe-Vue/
├── apps/
│   ├── admin/                  # 前端 Vue3 应用
│   │   ├── src/
│   │   │   ├── api/            # 接口请求层（按模块划分）
│   │   │   ├── assets/         # 图标（SVG）、图片等静态资源
│   │   │   ├── common/         # 公共常量、公共库（如 ECharts）
│   │   │   ├── components/     # 全局公共组件
│   │   │   │   ├── ProTable/   #   → 企业级表格（二次封装 ElTable）
│   │   │   │   ├── ProChart/   #   → 图表组件
│   │   │   │   ├── SvgIcon/    #   → 全局 SVG 图标组件
│   │   │   │   └── ...
│   │   │   ├── directives/     # 自定义指令（权限指令）
│   │   │   ├── hooks/          # 组合式函数（useDict、useProgress 等）
│   │   │   ├── layout/         # 全局布局（侧边栏 / 导航栏 / 标签页）
│   │   │   ├── router/         # 路由体系（静态路由 + 动态路由守卫）
│   │   │   ├── store/          # Pinia 状态管理
│   │   │   ├── styles/         # 全局样式 + Element Plus 主题覆写
│   │   │   ├── types/          # 类型声明（接口响应类型定义）
│   │   │   ├── utils/          # 工具函数（请求封装、Token 缓存等）
│   │   │   └── views/          # 页面视图（按模块划分）
│   │   ├── .env                # 通用环境变量
│   │   ├── .env.development    # 开发环境变量
│   │   ├── .env.production     # 生产环境变量
│   │   └── vite.config.ts      # Vite 构建配置
│   │
│   └── server/                 # 后端 NestJS 应用
│       ├── config/
│       │   └── config.yaml     # 后端配置文件（数据库 / Redis / JWT / 邮箱）
│       ├── src/
│       │   ├── common/         # 通用层（守卫 / 拦截器 / 过滤器 / 装饰器 / Entity）
│       │   ├── modules/        # 业务模块
│       │   │   ├── auth/       #   → 认证模块（登录 / 验证码 / 路由）
│       │   │   ├── system/     #   → 系统模块（用户 / 角色 / 菜单 / 字典）
│       │   │   ├── monitor/    #   → 监控模块（服务 / 缓存 / 定时任务 / 日志）
│       │   │   └── common/     #   → 公共模块（上传 / 邮件 / Excel）
│       │   ├── shared/         # 共享服务（Redis / 验证码）
│       │   └── utils/          # 工具函数
│       └── ormconfig.ts        # TypeORM 配置
│
├── database/                   # 数据库初始化 SQL
├── scripts/                    # 工具脚本（健康检查 / SVG 清理 / 数据库备份）
├── docker-compose.yaml         # 一键容器化启动编排文件
├── Dockerfile.server           # 后端多阶段构建镜像
├── Dockerfile.admin            # 前端 Nginx 静态文件镜像
├── nginx.conf                  # Nginx 反向代理 + 前端静态资源配置
├── .env.example                # 环境变量示例（复制为 .env 使用）
├── package.json                # 根 monorepo 的 scripts 入口
└── pnpm-workspace.yaml         # pnpm workspace 配置
```

---

## ⚡ 快速开始

### 环境要求

| 工具        | 最低版本  | 说明                                 |
| ----------- | --------- | ------------------------------------ |
| **Node.js** | ≥ 22.x    | JavaScript 运行时                    |
| **pnpm**    | ≥ 10.33.x | 高效的包管理器（项目使用 workspace） |
| **Docker**  | ≥ 29.x    | 容器化运行（可选，推荐）             |
| **MySQL**   | ≥ 8.0     | 数据库（Docker 模式自动提供）        |
| **Redis**   | ≥ 7.x     | 缓存服务（Docker 模式自动提供）      |

---

#### 方式一：Docker 一键启动（推荐新手）

这种方式你不需要手动安装 MySQL、Redis、Nginx 等，一切由 Docker Compose 自动编排。

```bash
# 1. 克隆项目
git clone <your-repo-url>
cd YunHe-Vue

# 2. 创建环境变量文件（复制示例文件）
cp .env.example .env

# 3. 编辑 .env 中的数据库密码、Redis 密码等（安全起见）
# 至少修改 MYSQL_PASSWORD 和 REDIS_PASSWORD

# 4. 一键启动（首次构建约 3-5 分钟）
pnpm docker:up

# 5. 打开浏览器
# 前端 → http://localhost:80
# 后端接口 → http://localhost:80/api
```

**排查常见问题：**

```bash
# 查看服务运行状态
docker compose ps

# 查看后端日志（server 启动失败时使用）
docker compose logs server -f

# 重启所有服务
pnpm docker:restart

# 完全重置（清除数据库和 Redis 数据）
pnpm docker:reset
```

---

### 方式二：独立开发模式（前后端分开跑）

适用于需要热更新、频繁修改代码的开发场景。

#### 2.1 后端启动

```bash
# 1. 进入 server 目录
cd apps/server

# 2. 创建本地配置文件（复制 config.yaml，不要直接修改原配置）
cp config/config.yaml config/config.local.yaml

# 3. 编辑 config.local.yaml
#    把 database.host 改为 127.0.0.1（或你的 MySQL IP）
#    把 redis.host 改为 127.0.0.1（或你的 Redis IP）
#    修改 database.password、redis.password 为实际密码
#    ⚠️ 注意：database.synchronize 保持 false，生产不要改

# 4. 启动后端（带热更新 watch 模式）
cd ../../
pnpm dev:server

# 后端默认端口：3000
# 接口前缀：/api
# 完整地址：http://localhost:3000/api
```

#### 2.2 前端启动

```bash
# 1. 在根目录执行
pnpm dev:admin

# 前端默认端口：5173
# 访问地址：http://localhost:5173
# Vite 已配置 /dev-api/api → http://localhost:3000 的反向代理
```

> 💡 **前端开发者视角**：`.env.development` 中的 `VITE_BASE_URL=http://localhost:3000` 和 `VITE_BASE_API=/dev-api/api` 组合起来，实现了开发时前端的 API 请求自动转发到后端，你不需要改任何代码，也不用担心 CORS。

---

## 📋 根目录 scripts 说明

| 命令                  | 用途                           | 适用场景              |
| --------------------- | ------------------------------ | --------------------- |
| `pnpm dev:server`     | 启动后端开发服务器（热更新）   | 独立开发模式          |
| `pnpm build:server`   | 构建后端生产包                 | 手动部署              |
| `pnpm dev:admin`      | 启动前端开发服务器（HMR）      | 独立开发模式          |
| `pnpm build:admin`    | 构建前端生产包                 | 手动部署              |
| `pnpm docker:up`      | Docker 一键启动所有服务        | 容器化部署 / 快速体验 |
| `pnpm docker:down`    | 停止并移除所有容器             | 停止服务              |
| `pnpm docker:restart` | 重启所有服务                   | 更新代码后重启        |
| `pnpm docker:reset`   | 重置所有数据并重启（删数据卷） | 完全重置环境          |
| `pnpm svg:clean`      | 清理 SVG 图标中的冗余属性      | 图标维护              |

---

## 🔐 默认账号

| 角色       | 用户名  | 密码          |
| ---------- | ------- | ------------- |
| 超级管理员 | `admin` | `admin123456` |

> ⚠️ 生产环境请第一时间修改默认密码。

---

## 🧠 从前端到全栈：架构详解

### 1. 前端如何接收后端路由？

这是云禾最核心的设计之一——**动态路由**。传统前端项目，路由是在 `router/index.ts` 里写死的（静态路由列表）。但在云禾中：

```
用户登录 → 后端查角色 → 查菜单权限 → 拼接成路由 JSON → 返回前端
           → 前端 router.addRoute() 动态注册 → 侧边栏实时渲染
```

前端静态路由（[router.database.ts](./apps/admin/src/router/router.database.ts)）只包含**登录页**、**首页**等不需要权限的页面。登录成功后调用 [AuthRequest.getRoutes](./apps/admin/src/api/auth.request.ts#L21-L23)，后端返回该用户有权访问的完整菜单树，前端解析后 `addRoute` 注册。

> 🎓 **全栈思维**：理解这个流程后，你会发现前后端不是割裂的——后端的菜单表结构直接决定了前端的侧边栏形态。修改菜单只需在"菜单管理"页面操作，无需改代码。

### 2. 后端 RBAC 权限模型

云禾后端采用经典的 **RBAC（基于角色的访问控制）** 五表设计：

```
用户(User) ←→ 角色(Role) ←→ 菜单(Menu)
```

- 一个用户可以有多个角色
- 一个角色可以有多个菜单（目录 / 菜单 / 按钮三种粒度）
- 菜单表存储了路由路径（`path`）、组件路径（`component`）、权限标识（`permission`）

权限校验时，[PermissionAuthGuard](./apps/server/src/common/guard/permission-auth.guard.ts) 会检查当前用户角色是否拥有对应接口的权限标识，配合 `@RequirePermissions(['system:user:list'])` 装饰器使用。

### 3. 文件上传架构

云禾的文件上传模块是工程化的范例，参考了"网盘"产品的思路：

```
客户端：计算文件 MD5 → 请求 checkFile（检查是否秒传）
         → 已存在 → 秒传（零等待）
         → 不存在 → 切片 → 并发上传分片
         → 全部上传完 → 请求 mergeChunk（服务端合并）

服务端：接收分片 → 写入临时目录
         → 收到合并请求 → 流式合并所有分片 → 生成最终文件
         → 返回可访问的文件路径
```

核心技术点：[UploadService](./apps/server/src/modules/common/upload/upload.service.ts) 使用 Node.js Stream `pipeline` 进行流式合并，内存占用极低，适合大文件场景。

### 4. 定时任务调度

基于 **BullMQ** 消息队列实现的动态定时任务：

- 后台通过"定时任务管理"页面创建任务
- 配置 Cron 表达式或固定间隔
- 支持手动执行、暂停、恢复
- 每次执行自动记录日志，异常可追溯

后端 [JobService](./apps/server/src/modules/monitor/job/job.service.ts) 在 `onModuleInit` 时扫描数据库中所有启用的任务，注册到 BullMQ 调度。

---

## 🛠️ 开发规范

本项目已内置严格的代码规范体系，确保团队协作时代码风格统一：

- **ESLint** — TypeScript 代码检查
- **Prettier** — 代码格式化
- **Vue 3 组合式 API** — 强制 `<script setup lang="ts">`
- **BEM 命名** — 样式类名语义化
- **Import 排序** — 自动按长度排序
- **SvgIcon 组件** — 统一图标使用方式
- **TipModal 封装** — 统一消息提示入口

具体规范文件参见 `.trae/rules/` 目录。

---

## 🎯 前端进阶全栈学习路线

如果你是前端，想通过云禾系统平滑过渡到全栈，建议按以下顺序：

1. **跑起来** → 用 Docker 模式一键启动，先看看系统长什么样
2. **理解数据流** → 从登录开始，追踪 `login.vue` → `auth.request.ts` → 后端 `auth.controller.ts` → `auth.service.ts` → 数据库
3. **搞懂路由** → 理解动态路由机制，知道菜单表怎么变成侧边栏
4. **学会 CRUD** → 以"字典管理"为范例，看懂前后端完整增删改查链路
5. **掌握部署** → 看懂 `Dockerfile` 和 `docker-compose.yaml`，理解多阶段构建
6. **深入原理** → 学 JWT 鉴权、Redis 缓存策略、BullMQ 消息队列、流式文件合并

## 📄 许可证

本项目基于 **MIT** 协议开源，详见 [LICENSE](./LICENSE)。

## ⭐ 写在最后

> 云在青天，禾在土。管理在心，事在术。

云禾不追求花哨的技术堆砌，而专注于**让前端开发者真正看懂、学会、用上**。每一个模块都经过精心设计，代码注释完整，类型定义清晰，拒绝"源码即天书"。

如果你觉得这个项目有帮助：

- **给个 Star ⭐** 就是最大的支持
- **提个 Issue** 帮助我们改进
- **分享给同事** 让更多人受益

愿你脚踏实地，稳步向前，从"前端工程师"成长为"全栈工程师"。

## 📈 星标趋势

<p align="center">
  <a href="https://www.star-history.com/#Ace627/YunHe-Vue&amp;Date" rel="nofollow">
    <img src="https://api.star-history.com/svg?repos=Ace627/YunHe-Vue&amp;type=Date" alt="Star History Chart" style="max-width: 100%;" />
  </a>
</p>
