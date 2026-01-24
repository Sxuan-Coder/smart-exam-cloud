import { defineConfig, loadEnv } from 'vite'
import vue from '@vitejs/plugin-vue2'
import vueJsx from '@vitejs/plugin-vue2-jsx'
import { createSvgIconsPlugin } from 'vite-plugin-svg-icons'
import path from 'path'

export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, process.cwd(), '')

  return {
    plugins: [
      vue(),
      vueJsx(),
      createSvgIconsPlugin({
        iconDirs: [path.resolve(process.cwd(), 'src/icons/svg')],
        symbolId: 'icon-[name]'
      })
    ],

    resolve: {
      alias: {
        '@': path.resolve(__dirname, 'src')
      },
      extensions: ['.mjs', '.js', '.ts', '.jsx', '.tsx', '.json', '.vue']
    },

    server: {
      port: 9527,
      open: true,
      proxy: {
        '/api': {
          target: 'http://localhost:8080',
          changeOrigin: true,
          rewrite: (path) => path.replace(/^\/api/, '/api')
        }
      }
    },

    css: {
      preprocessorOptions: {
        scss: {
          charset: false,
          // 添加别名解析，支持 ~@/ 路径
          importer: (url) => {
            if (url.startsWith('~@/')) {
              return { file: path.resolve(__dirname, 'src', url.substring(3)) }
            }
            return null
          }
        }
      }
    },

    build: {
      outDir: 'dist',
      assetsDir: 'static',
      sourcemap: false,
      chunkSizeWarningLimit: 1500,
      rollupOptions: {
        output: {
          manualChunks: {
            'vendor': ['vue', 'vue-router', 'vuex'],
            'element-ui': ['element-ui'],
            'echarts': ['echarts']
          }
        }
      }
    },

    define: {
      'process.env': env
    }
  }
})
