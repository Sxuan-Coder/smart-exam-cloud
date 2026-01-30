import Vue from 'vue'
import SvgIcon from '@/components/SvgIcon'// svg component

// register globally
Vue.component('svg-icon', SvgIcon)

// 使用 vite-plugin-svg-icons 插件，SVG 图标在 main.js 中通过 virtual:svg-icons-register 自动注册

