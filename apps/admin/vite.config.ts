import { defineConfig, loadEnv } from 'vite'
import { fileURLToPath, URL } from 'node:url'
import UnoCSS from 'unocss/vite' // Vite Plugins
import vue from '@vitejs/plugin-vue'
import vueJsx from '@vitejs/plugin-vue-jsx'
import AutoImport from 'unplugin-auto-import/vite'
import ElementPlus from 'unplugin-element-plus/vite'
import AutoComponents from 'unplugin-vue-components/vite'
import { createSvgIconsPlugin } from 'vite-plugin-svg-icons-ng'
import { visualizer } from 'rollup-plugin-visualizer'
import { ElementPlusResolver } from 'unplugin-vue-components/resolvers'
import viteCompression from 'vite-plugin-compression'

// https://cn.vite.dev/config/
export default defineConfig(({ mode }) => {
  // 根据当前工作目录中的 `mode` 加载 .env 文件
  // 设置第三个参数为 '' 来加载所有环境变量，而不管是否有 `VITE_` 前缀
  const viteEnv = loadEnv(mode, process.cwd(), 'VITE_') as unknown as ImportMetaEnv
  const isDev = mode === 'development'

  return {
    // 项目根目录（默认当前目录，无需修改，规范路径）
    root: process.cwd(),
    // 部署应用包时的基本 URL
    base: viteEnv.VITE_PUBLIC_PATH ?? '/',

    plugins: [
      // 提供 Vue 3 单文件组件支持
      vue(),
      /** 提供 Vue 3 JSX/TSX 支持 */
      vueJsx(),
      // 即时按需的原子化 CSS 引擎 UnoCSS
      UnoCSS({ inspector: false }),
      // Element Plus 样式自动按需导入
      ElementPlus({ useSource: true }),
      // 自动导入 vue、vue-router、Pinia 等的相关函数
      AutoImport({
        resolvers: [ElementPlusResolver({ importStyle: 'sass' })],
        imports: ['vue', 'pinia', 'vue-router', '@vueuse/core'],
        dts: 'types/auto-generate/auto-import.d.ts',
        dirs: ['src/store/modules', 'src/hooks'], // 配置其它需要导入的文件目录
      }),
      // 组件及其类型的自动化导入
      AutoComponents({
        resolvers: [ElementPlusResolver({ importStyle: 'sass' })],
        dts: 'types/auto-generate/auto-components.d.ts',
        dirs: [], // 配置其它需要导入的文件目录
      }),
      // 自动导入 SVG 图标组件
      createSvgIconsPlugin({
        iconDirs: [fileURLToPath(new URL('./src/assets/icons', import.meta.url))],
        symbolId: 'icon-[dir]-[name]',
      }),
      viteCompression({
        algorithm: 'gzip', // 使用 gzip 压缩
        ext: '.gz', // 生成的文件扩展名
        threshold: 10240, // 仅压缩大于 10KB 的文件
        deleteOriginFile: false, // 是否删除原始文件
        compressionOptions: { level: 9 }, // 压缩级别，1-9，越高压缩率越大
        filter: /\.(js|css|json|html|ico|svg)(\?.*)?$/i, // 过滤文件类型
      }),
      visualizer({
        open: true, //注意这里要设置为true，否则无效
        filename: 'stats.html', //分析图生成的文件名
        gzipSize: true, // 收集 gzip 大小并将其显示
        brotliSize: true, // 收集 brotli 大小并将其显示
      }),
    ],

    resolve: {
      alias: {
        /** 设置 `@` 指向 `src` 目录 */
        '@': fileURLToPath(new URL('./src', import.meta.url)),
      },
    },

    server: {
      // 允许外部访问（团队协作时，其他设备可通过 IP 访问本地项目）
      host: true,
      // 指定开发服务器端口。注意：如果端口已经被使用，Vite 会自动尝试下一个可用的端口，所以这可能不是开发服务器最终监听的实际端口
      // 开发环境端口（项目建议避开 80、443 等常用端口，防止冲突）
      port: parseInt(viteEnv.VITE_SERVER_PORT),
      // 是否自动打开浏览器
      open: viteEnv.VITE_AUTO_OPEN === 'true',
      /** 反向代理配置（主要是开发时用来解决跨域问题） */
      proxy: {
        [viteEnv.VITE_BASE_API]: {
          target: viteEnv.VITE_BASE_URL,
          changeOrigin: true,
          rewrite: (path) => path.replace('/dev-api', ''),
        },
      },
    },

    build: {
      // 指定打包文件的输出目录。默认值为 dist ，当 dist 被占用或公司有统一命名规范时，可进行调整
      outDir: viteEnv.VITE_OUTPUT_DIR,
      // 静态资源输出目录（规范静态资源路径，便于 CDN 部署）
      assetsDir: 'assets',
      // 取消生产环境 sourceMap（避免暴露源码，提升安全性，调试时可临时开启）
      sourcemap: false,
      // 打包时删除输出目录（避免旧产物残留，规范）
      emptyOutDir: true,
      // 设置为 false 可以禁用最小化混淆，或是用来指定使用哪种混淆器。默认使用 Oxc Minifier，它比 terser 快 30~90 倍，但压缩率仅差 0.5~2%
      minify: 'oxc',
      // 警告阈值，超过该值的 chunk 会触发警告。默认值为 2048（2MB）
      chunkSizeWarningLimit: 2048,
      // 直接自定义底层 Rolldown 包。这与从 Rolldown 配置文件导出的选项相同，并将与 Vite 的内部 Rolldown 选项合并
      rolldownOptions: {
        checks: {
          pluginTimings: false,
        },
        output: {
          // 引入文件名的名称
          chunkFileNames: 'js/[name]-[hash].js',
          // 包的入口文件名称
          entryFileNames: 'js/[name]-[hash].js',
          // 打包的文件进行拆包处理
          // codeSplitting: true,
          codeSplitting: {
            groups: [
              { name: 'shiki-langs', test: /node_modules[\\/]@shikijs[\\/]langs/, priority: 50 },
              { name: 'shiki-themes', test: /node_modules[\\/]@shikijs[\\/]themes/, priority: 49 },
              { name: 'shiki-core', test: /node_modules[\\/]@shikijs/, priority: 48 },
              { name: 'mermaid', test: /node_modules[\\/]mermaid/, priority: 35 },
              { name: 'element-plus', test: /node_modules[\\/]element-plus/, priority: 30 },
              { name: 'langium', test: /node_modules[\\/]langium/, priority: 22 },
              { name: 'codemirror', test: /node_modules[\\/](codemirror|@codemirror)/, priority: 35 },
              { name: 'echarts', test: /node_modules[\\/](echarts|zrender)/, priority: 25 },
              { name: 'cytoscape', test: /node_modules[\\/]cytoscape/, priority: 19 },
              { name: 'markdown-it', test: /node_modules[\\/]markdown-it/, priority: 18 },
              { name: 'katex', test: /node_modules[\\/]katex/, priority: 17 },
              { name: 'vue-vendor', test: /node_modules[\\/](vue|vue-router|pinia)/, priority: 15 },
              { name: 'utils', test: /node_modules[\\/](dayjs|axios|lodash-es)/, priority: 12 },
              { name: 'vendor', test: /node_modules/, priority: 10 },
            ],
          },
          minify: {
            compress: {
              // 是否移除 console 语句（环境变量不为 'false' 时启用，默认启用）
              dropConsole: viteEnv.VITE_DROP_CONSOLE !== 'false',
              // 是否移除 debugger 调试语句（环境变量不为 'false' 时启用，默认启用）
              dropDebugger: viteEnv.VITE_DROP_DEBUGGER !== 'false',
            },
          },
        },
      },
    },

    optimizeDeps: {
      // 预构建依赖（将常用第三方依赖提前构建，提升冷启动速度）
      include: [
        'element-plus/es/components/tree/style/index',
        'element-plus/es/components/tree-select/style/index',
        'element-plus/es/components/popover/style/index',
        'element-plus/es/components/radio/style/index',
        'element-plus/es/components/radio-group/style/index',
        'element-plus/es/components/checkbox/style/index',
        'element-plus/es/components/input-number/style/index',
        'element-plus/es/components/button/style/index',
        'element-plus/es/components/dialog/style/index',
        'element-plus/es/components/card/style/index',
        'element-plus/es/components/link/style/index',
        'element-plus/es/components/text/style/index',
        'element-plus/es/components/collapse/style/index',
        'element-plus/es/components/collapse-item/style/index',
        'element-plus/es/components/descriptions/style/index',
        'element-plus/es/components/descriptions-item/style/index',
        'element-plus/es/components/color-picker/style/index',
        'element-plus/es/components/slider/style/index',
        'element-plus/es/components/watermark/style/index',
        'element-plus/es/components/breadcrumb-item/style/index',
        'element-plus/es/components/breadcrumb/style/index',
        'element-plus/es/components/col/style/index',
        'element-plus/es/components/config-provider/style/index',
        'element-plus/es/components/date-picker/style/index',
        'element-plus/es/components/divider/style/index',
        'element-plus/es/components/drawer/style/index',
        'element-plus/es/components/dropdown-item/style/index',
        'element-plus/es/components/dropdown-menu/style/index',
        'element-plus/es/components/dropdown/style/index',
        'element-plus/es/components/form-item/style/index',
        'element-plus/es/components/form/style/index',
        'element-plus/es/components/input/style/index',
        'element-plus/es/components/loading/style/index',
        'element-plus/es/components/menu-item/style/index',
        'element-plus/es/components/menu/style/index',
        'element-plus/es/components/message-box/style/index',
        'element-plus/es/components/message/style/index',
        'element-plus/es/components/notification/style/index',
        'element-plus/es/components/option/style/index',
        'element-plus/es/components/pagination/style/index',
        'element-plus/es/components/row/style/index',
        'element-plus/es/components/scrollbar/style/index',
        'element-plus/es/components/select/style/index',
        'element-plus/es/components/sub-menu/style/index',
        'element-plus/es/components/switch/style/index',
        'element-plus/es/components/table-column/style/index',
        'element-plus/es/components/table/style/index',
        'element-plus/es/components/tag/style/index',
        'element-plus/es/components/tooltip/style/index',
        'element-plus/es/components/countdown/style/index',
        'element-plus/es/components/statistic/style/index',
        'element-plus/es/components/progress/style/index',
        'element-plus/es/components/upload/style/index',
      ],
      // 预构建缓存目录（Vite 8 优化缓存策略，提升二次启动速度）
      cacheDir: fileURLToPath(new URL('./node_modules/.vite/optimize-deps', import.meta.url)),
      // 强制预构建（如果依赖更新，强制重新预构建）
      force: isDev,
    },

    css: {
      /**
       * 如果启用了这个选项，那么 CSS 预处理器会尽可能在 worker 线程中运行；即通过多线程运行 CSS 预处理器，从而极大提高其处理速度
       * https://cn.vitejs.dev/config/shared-options#css-preprocessormaxworkers
       */
      preprocessorMaxWorkers: true,
      /**
       * CSS 预处理器配置（支持 SCSS/SASS，项目常用）
       * 建议只用来嵌入 SCSS 的变量声明文件，嵌入后全局可用
       * 该选项可以用来为每一段样式内容添加额外的代码。但是要注意，如果你添加的是实际的样式而不仅仅是变量，那这些样式在最终的产物中会重复。
       * https://cn.vitejs.dev/config/shared-options.html#css-preprocessoroptions-extension-additionaldata
       */
      preprocessorOptions: {
        scss: {
          additionalData: `
            @use "@/styles/element-plus/el-theme-light.scss";
            @use "@/styles/element-plus/el-theme-dark.scss";`,
        },
      },
      lightningcss: {},
    },
  }
})
