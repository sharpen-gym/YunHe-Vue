## 项目简介

YunHe-Vue（云禾管理系统）是一套面向前端开发者进阶全栈的企业级后台管理系统模板。采用 **pnpm workspace Monorepo** 架构将前后端同仓管理，前端基于 **Vue 3.5 + TypeScript + Element Plus 2 + Vite 8 + Pinia 3 + Vue Router 5** 构建，后端基于 **NestJS 11 + TypeORM + MySQL 8 + Redis 7 + BullMQ** 搭建。核心设计理念是"TypeScript 贯穿全栈"——同一门语言、同一套类型系统，配合 NestJS 与 Vue 高度相似的「模块化 + 依赖注入 + 装饰器」开发范式，让前端开发者在熟悉的生态里完成全栈能力的平滑过渡。Monorepo 同仓架构的另一大优势是：**AI 辅助编程时可直接阅读前后端关联代码**，无需在不同仓库间切换上下文，从 API 请求到接口处理再到数据库实体一气贯通，大幅提升 AI 代码生成的准确性与工程一致性。最终以 **Docker + Nginx** 多阶段构建实现一键容器化部署。

---

## 功能模块

### 🔐 RBAC 权限模型（前后端一体化）

- 用户 → 角色 → 菜单，菜单粒度为「目录 / 菜单 / 按钮」三级
- 后端 `@RequirePermissions`、`@RequireRoles` 装饰器声明权限，`@Public` 标记免鉴权接口，`@CurrentUser('userId')` 自动注入当前用户
- **JWT 签发时写入用户角色与权限集合，Guard 层统一校验；权限/角色缓存于 Redis（30 分钟 TTL）**
- **Token 双层验证** — JWT 自包含 + Redis 记录，退出登录时删除 Redis 记录即 Token 失效，无需维护黑名单；`JwtAuthGuard` 校验通过后自动对 Token / 在线状态 / 角色 / 权限 4 个 Redis Key 续期，实现"活跃用户无感续期、不活跃用户自动过期"
- 前端路由由后端动态下发，`loadView()` 通过 `import.meta.glob` 懒加载组件并自动设置 `defineOptions({ name })`
- `v-permissions` 指令控制按钮级 DOM 显隐，`v-roles` 指令按角色粗粒度控制
- 权限配置全部收敛到后台管理界面，运维与开发分离

### 📂 系统管理

- **用户管理** — 增删改查、重置密码、修改密码、角色分配、状态管理
- **角色管理** — 角色权限分配、角色编码管理
- **菜单管理** — 目录 / 菜单 / 按钮三级粒度，支持外链、内嵌 iframe
- **字典管理** — 字典类型 + 字典数据两级结构，`useDict()` Hook 全局缓存 + 并发请求去重（同一类型多个组件同时挂载只发一次请求，其余复用 Promise），后端 Redis 缓存
- **图标浏览** — SVG 图标集中预览

### 📊 系统监控

- **服务监控** — `systeminformation` 库采集 CPU（负载/核心）、内存（使用率/总量）、磁盘（分区/挂载/类型/使用率）、服务器（主机名/平台/IP/架构），`@ResponseCache` 缓存 180 秒
- **缓存监控** — Redis 实例信息（dbsize/info/commandstats），支持按 6 大命名空间（验证码/Token/字典/限流/响应缓存/防重提交）分类查看与批量清除
- **健康检查** — `@nestjs/terminus` 集成：`/live`（存活探针）、`/ready`（就绪探针：DB 连接 + 内存堆 <200MB + RSS <200MB + 磁盘 <75% + 外部网络 3s 超时），适配 K8s / Docker Swarm
- **在线用户** — Redis 批量读取在线状态，分页 + 按用户名/IP/地点过滤，支持单设备强制下线
- **定时任务** — BullMQ 动态 Cron 调度，运行时启停 / 暂停 / 恢复 / 手动执行
- **操作日志** — `@OperLog` 装饰器标记即自动记录，IP 归属地解析（`ip2region-ts`）+ 浏览器（`ua-parser-js`）/ OS 解析
- **登录日志** — `ua-parser-js` 解析 UserAgent 提取浏览器名/版本、OS 名/版本，IP 归属地解析，登录成功/失败全量记录

### 📁 大文件分片上传

- **单文件上传** — ≤10MB 直接上传，>10MB 自动拒绝并提示改用分片
- **Web Worker 离线哈希** — `crypto.subtle.digest('SHA-256')` 硬件加速计算文件与分片哈希
- **并发上传** — 5MB 固定分片，3 路并发 Promise.race 协程池
- **秒传** — `checkFile` 接口查询文件哈希，已存在则跳过上传
- **断点续传** — `checkFile` 返回已上传分片索引，前端只传缺失分片
- **流式合并** — 后端 Node.js Stream 管道边读边写，不占内存

### ⏱ 动态定时任务调度

- 基于 **BullMQ + Redis** 实现运行时动态调度，`onModuleInit` 阶段自动从数据库加载任务并注册到队列
- 业务 Service 通过 NestJS `DiscoveryService` 自动扫描注册到 `serviceMap`
- 后台界面填写「类名.方法名(参数)」即可新增任务，`analysisInvokeTarget` 格式校验（正则 + `ModuleRef.get()` 反射验证方法存在性）
- `JobProcessor` 通过 `@Processor` + `WorkerHost` 消费队列，`concurrent` 标志控制并行/串行执行；`@OnWorkerEvent` 自动监听 completed / failed 事件并写入任务日志
- Cron 表达式启停 / 修改 / 手动执行一次 / 暂停 / 恢复全部通过 API 操作，编辑任务自动先停旧再启新，无需重启服务

### 🤖 AI 流式对话

- 集成 **LangChain + OpenAI**，SSE 流式输出，支持 `AbortController` 中止
- **上下文压缩摘要** — 消息量达 12 条触发阈值，自动调用 LLM 将历史对话压缩为摘要存入数据库；每次请求仅携带「摘要 + 最近 6 条消息」，大幅降低 Token 消耗
- **全链路 Token 统计** — `TokenCounterHandler` 回调自动统计 `promptTokens` / `completionTokens` 并入库
- **Agent 工具** — 内置联网天气查询 Tool，架构支持扩展
- 前端 Markdown 渲染 — `markstream-vue` 流式 Markdown 渲染（代码高亮 + Mermaid 流程图 + KaTeX 数学公式 + 自定义 CodeBlockNode），支持流式输出逐字符展示
- 会话管理：新建 / 切换 / 删除 / 重命名 / 导出 JSON

### 📝 提示词管理

- 资源模块（`resource`）下的独立 CRUD 模块，管理 AI 对话中使用的提示词模板
- 字段：提示词标题 / 提示词类型 / 状态 / 备注 / 提示词内容，支持字典回显
- 列表页支持按标题 / 类型 / 状态筛选，内容支持一键复制
- 后端 `@RequirePermissions` 精细化权限控制（`resource:prompt:query / create / update / delete`），操作日志自动记录
- 提示词类型通过 `res_prompt_type` 字典维护，适配多种 AI 对话场景

### 🛡 请求安全体系

- **前后端双闭环请求去重**
  - 前端：Axios 拦截器基于 `Set` 内存去重，仅拦截 POST / PUT / DELETE
  - 后端：`@RepeatSubmit()` 装饰器 + `RepeatSubmitGuard`，基于 Redis 分布式去重
  - 两者共享同一套稳定序列化算法（对象键排序 / FormData / File 元数据 / 循环引用检测）
- **接口限流** — `ThrottlerLimitGuard` 基于 Redis 原子自增，IP + 路径维度限流（10 次 / 10 秒），超限自动拉黑 30 分钟；`@SkipThrottle()` 可豁免
- **接口响应缓存** — `@ResponseCache({ ttl, key })` 装饰器标记即自动 Redis 缓存，TTL 引入 20% 随机抖动防缓存雪崩
- **演示环境保护** — `DemoEnvironmentGuard` 开关式拦截非 GET 操作（登录 / 登出白名单除外）
- **客户端真实 IP** — 兼容 Nginx / Caddy / K8s 多层反向代理，优先级 `x-forwarded-for → x-real-ip → remoteAddress`
- **Helmet 安全头** + Winston 按日滚动日志

### 📋 统一响应与异常体系

- **Request ID 全链路追踪** — `BeforeEachMiddleware` 为每个请求生成 UUID，写入请求上下文 + 响应头 + 所有日志 + AjaxResult + 操作/登录日志记录，可从前端响应一路追溯到数据库日志
- 全局 `AllExceptionsFilter`：区分开发 / 生产日志，异常语义化翻译（外键约束→"当前数据关联其它资源"）
- `ReponseTransformInterceptor`：统一包装为 `AjaxResult` 格式（code / success / message / requestId / timestamp），`@Raw()` 可跳过包装
- `class-validator` DTO 管道校验（`whitelist + transform + stopAtFirstError`）
- `PaginationPipe` 统一分页参数处理

### 📑 Excel 导入导出

- `@Excel()` 装饰器声明式配置字段映射（列名 / 顺序 / 宽度 / 日期格式 / 字典翻译）
- ExcelJS 引擎驱动，一键导出含字典回显的标准化 Excel
- 支持仅导出 / 仅导入 / 双向三种模式

### 📧 邮件 + 图形验证码

- `@nestjs-modules/mailer` + Handlebars 模板引擎，内置验证码 / 告警 / 通知三套模板
- SMTP 配置化，`EmailService.sendCaptcha()` 一行发送
- `svg-captcha` 数学表达式验证码，Redis 缓存答案 60 秒过期

### 🖼 前端示例页面

- **ECharts 图表** — 折线 / 柱状 / 饼图 / 雷达 / K 线 / 散点图演示
- **分片上传 Demo** — 完整上传流程可视化（计算哈希 → 检查 → 上传 → 合并）
- **水印** — 文本水印 / 多行水印 / 图片水印 / 表格保护四场景
- **倒计时** — `el-countdown` + `@vueuse/core useTransition` 数值动画
- **手写签名板** — Canvas 原生实现，画笔颜色 / 粗细可调，支持撤销 / 保存为图片
- **Markdown 编辑器** — md-editor-v3 封装，支持导出 .md 文件
- **图片懒加载** — 原生 `IntersectionObserver` 实现，图片进入视口才加载，首屏速度提升显著
- **定价模板** — 纯 CSS 定价卡片页，多套餐对比 + 选中高亮
- **太极动效** — 纯 CSS 实现的太极图旋转动画，CSS 变量控制尺寸与速度

### 📱 布局与导航

- **Navbar 顶栏** — 侧栏折叠（Hamburger）、面包屑导航（Breadcrumb）、全屏切换（Screenfull）、暗黑主题切换（ThemeSwitch）、组件尺寸切换（SizeSelect）、用户下拉菜单（UserDropDown：个人中心 / 系统设置 / 清空缓存 / 退出登录）
- **Sidebar 侧栏** — `SidebarItem` 递归渲染多级菜单，`uniqueOpened` 手风琴模式，折叠动画，`hidden` 字段控制显隐
- **TagsView 多标签页** — 类浏览器 Tab 交互，支持刷新 / 关闭当前 / 关闭其它 / 关闭所有 / 右键菜单，固定标签页（affix）不可关闭，左右箭头滚动，`keepAlive` 组件缓存 + `watchEffect` 自动持久化到 localStorage
- **SettingPanel 布局设置** — `el-drawer` 侧边面板，动态标题 / Logo / 手风琴菜单 / 面包屑 / 标签页 / 标签页图标 / 页面转场动效（6 种）均可可视化开关，支持重置与持久化保存

### 🏠 首页与登录

- **Dashboard 首页** — 项目简介 + 技术栈分类展示（通用 / 前端 / 后端，带官方链接卡片）
- **Login 登录页** — 图形验证码（点击刷新）、记住密码、回车登录，`getTimeGreeting()` 根据时段展示问候语，登录后自动跳转回跳地址
- **登录校验链路** — 验证码校验 → 账号存在性 + 状态检查 → Argon2 密码验证 → JWT 签发 + Redis 缓存 → 登录日志（成功含 requestId / 失败含错误原因），全链路可追溯
- **用户个人中心** — 个人信息展示、修改密码
- **Argon2 密码加密** — 内存硬化算法抗 GPU 暴力破解，自动生成随机盐值无需额外存储，写入前自动检测是否已加密避免重复哈希

### 📦 共享工具包

- `@yunhe-vue/utils` 独立 npm 包，前后端 `workspace:*` 直接引用，5 个工具函数复用
  - `formatTime()` — dayjs 时间格式化，支持时间戳/Date/字符串，默认 `YYYY-MM-DD HH:mm:ss`
  - `getTimeGreeting()` — 根据时段返回中文问候语（凌晨好/上午好/中午好/下午好/晚上好）
  - `isExternal()` — 校验是否为外部链接（http/https/ftp/mailto/tel/file）
  - `isStringNumber()` — 运行时判断字符串是否为有效数字（整数/浮点数/负数）
  - `isJsonString()` — 运行时判断字符串是否为有效 JSON（首字符预校验 + tryParse）

### 🧱 前端组件体系

- **ProTable** — el-table 封装，动态列配置、slot 插槽、加载状态、代理暴露原生方法
- **ProSearch** — 表单搜索，input / select / date 类型，展开 / 收起，24 格自适应布局
- **ProPagination** — 分页封装，移动端自适应简化布局
- **ProChart** — ECharts 封装，暗黑主题自动切换、ResizeObserver 自适应、自动销毁防内存泄漏；底层 `echarts.ts` 树摇按需导入（LineChart / BarChart / PieChart / RadarChart / GaugeChart / CandlestickChart / ScatterChart + CanvasRenderer + 8 个组件），打包体积最小化
- **DictTag** — 字典值回显组件，自动匹配标签样式
- **Markdown** — md-editor-v3 封装，暗黑模式适配
- **SvgIcon** — SVG sprite 图标组件
- **IconSelect** — 图标选择器

### 🏗 前端工程化

- **路由守卫** — `beforeGuard` 统一鉴权流程（白名单放行 → Token 校验 → 拉取用户信息 → 动态注册路由 → 重定向回跳），`afterGuard` 收尾进度条与动态标题；路由模式 hash / history 环境变量切换，`scrollBehavior` 切换页面自动回顶；`meta.keepAlive` 标记的页面自动加入 `<keep-alive>` 缓存
- **SCSS + BEM** 为主方案，**UnoCSS** 原子化为辅
- **暗黑模式** — CSS 变量 + Element Plus SCSS 主题变量（el-card / el-dialog / el-dropdown / el-table 浅深两套独立主题文件），`ThemeSwitch` 基于 `document.startViewTransition()` 实现**点击处圆形扩散过渡动画**（Apple 风格），全局 `isDark` 联动 ECharts / Markdown 编辑器等所有组件；Sidebar / Navbar / TagsView 三区域独立 CSS 设计令牌（宽度/高度/背景色/阴影），light / dark 分别定义
- **响应式布局** — PC / Pad / Mobile 三端适配，侧边栏自动折叠，移动端 `html[data-device='mobile']`
- **Pinia Store** — 6 个模块分层管理：`user`（用户/角色/权限）、`app`（设备/侧栏/组件尺寸）、`permission`（动态路由）、`setting`（布局配置持久化）、`tagsView`（标签页状态）、`ai`（AI 会话）
- **自动导入** — `unplugin-auto-import`（ref / computed / onMounted 等）+ `unplugin-vue-components`（Element Plus 组件按需）
- **TipModal 工具类** — 统一封装 ElMessage / ElMessageBox / ElNotification / ElLoading 四大反馈组件（msg / alert / notify / loading，各含 info / success / warning / error 分级），全局单例 loading 防堆叠
- **copyText / linkDownload** — 剪切板复制（Clipboard API 优先 + `execCommand` 回退）+ Blob 文件下载（`URL.createObjectURL`），AI 代码块复制/下载与 Markdown 导出均基于此
- **CacheUtil** — localStorage 封装，支持 TTL 过期、通配符 key 匹配，`CacheConstant` 以 `package.json name` 大写作命名空间前缀防冲突，5 个缓存子模块（Token / 侧栏状态 / 布局配置 / 标签页 / 组件尺寸）统一管理
- **CSS 过渡动效** — `fade-transform`（倾斜平移淡入淡出）等自定义 `<transition>` 动画，支持 6 种页面切换效果（SettingPanel 可视化选择）
- Vite 8 + Rolldown 构建，Oxc 压缩（比 Terser 快 30~90 倍）、`codeSplitting` 细粒度拆包（shiki / mermaid / element-plus / echarts / katex / vue-vendor 等 11 个独立 chunk）
- **gzip 预压缩** — `vite-plugin-compression` 构建时生成 .gz 文件（压缩级别 9），Nginx `gzip_static on` 直接读取，无需实时压缩
- **NProgress** 路由切换 + 请求加载双进度条，可通过环境变量独立开关
- **SVG 图标工具链** — `vite-plugin-svg-icons-ng` 自动生成 SVG sprite；`scripts/svg-clean.ts` 脚本批量移除冗余属性（fill / class / version / width / height），产物最小化
- **Vite Dev 代理** — 开发环境自动 proxy `/dev-api` 到后端地址，`changeOrigin` 解决跨域，路径重写剥离前缀

### 🐳 后端工程化与部署

- **配置管理** — YAML 文件加载 + 环境变量覆盖（Docker 环境自动注入数据库 / Redis / JWT / 邮箱 / OpenAI 配置）
- **TypeORM** — 自动加载实体 + 慢查询日志（>3s）+ 自动重连（10 次）+ 东八区时区，开发期 `synchronize` 可开关，`ormconfig.ts` 独立 Migration DataSource（自定义迁移表名 `sys_migrations`）
- **实体基类** — `CommonEntity` 自动管理 `createTime` / `updateTime`（`toJSON()` 序列化时格式化为 `YYYY-MM-DD HH:mm:ss`）；`BaseEntity` 继承 + `@BeforeInsert` / `@BeforeUpdate` 钩子通过 `AsyncLocalStorage`（`UserContext`）自动注入 `createBy` / `updateBy`，无需手动传参
- **日志** — Winston 按日滚动文件日志，生产环境自动压缩（zippedArchive）+ 单文件 10MB 上限 + 14 天自动清理，info / error 分级分目录，开发环境仅控制台 nest-like 彩色输出，生产环境不输出敏感信息；请求日志自动打印 method / url / requestId / query / body / user-agent
- **Docker Compose 编排** — 四容器（server × 2 副本 + admin + mysql:8.0 + redis:7.2-alpine），**健康探针链**：MySQL Service healthy → server 启动、server Service healthy → admin 启动，自定义 `healthcheck.js` 探针 10s 间隔 / 3 次重试 / 40s 冷启动宽限期，MySQL 挂载 `/docker-entrypoint-initdb.d` 自动初始化
- **Nginx** — 多阶段构建（前端 Nginx + 后端 Node），反向代理 + `gzip_static` 直接读预压缩文件 + 安全头（X-Frame-Options / XSS-Protection / X-Content-Type-Options）+ `least_conn` 最少连接负载均衡 + History 模式 `try_files` 支持 + 隐藏版本号
- **Docker** — server 镜像 `pnpm deploy --prod` 精确提取生产依赖（不含 devDependencies），`nobody` 非 root 运行；admin 镜像 Nginx Alpine 静态服务
- **数据库备份** — `backup_db.sh` Shell 脚本，从 `.env` 安全读取配置，支持压缩 / 非压缩模式，自动清理 7 天前旧备份
- **Monorepo 脚本** — `pnpm dev:admin` / `dev:server` / `docker:up` / `docker:down` / `docker:reset`（含数据卷重置）/ `svg:clean`（SVG 冗余属性批量移除）统一编排
- **前后端共享算法** — `listToTree` / `treeToList` 树结构互转（Map 索引 O(n) 复杂度），`isJsonString` / `isStringNumber` 运行时类型判断，前后端各一份、逻辑一致
- **ElConfigProvider 全局配置** — `zh-cn` 国际化 + `size` 组件尺寸全局注入，`useResize()` / `useDynamicTitle()` 二合一 Hook 驱动响应式适配与动态标题

### 🤖 AI 辅助编程规则体系

- `.trae/rules/admin-code-convention.md` — Vue3 代码规范（TipModal 封装、SvgIcon 统一、ProTable 优先、BEM 命名、路由组件 name 限制）
- `.trae/rules/git-commit-message.md` — 中文 Conventional Commits 规范（单行 ≤ 50 字、中英空格隔离、单一职责）
- `.trae/rules/karpathy-guidelines.md` — LLM 编码行为准则（先思考后编码、简洁优先、外科手术式修改、目标驱动执行）
- `.trae/skills/crud-generator/SKILL.md` — 全栈 CRUD 代码生成器，根据字段描述一键生成 Entity / DTO / Service / Controller / Module + Vue3 列表页 / Types / API，严格遵循项目规范，支持标准 / 树形 / 主从三种模式
- `.trae/skills/karpathy-guidelines/SKILL.md` — 自动化 Skill 质量评估（8 维度评分 + 爬山算法迭代优化 + Git 版本控制）
