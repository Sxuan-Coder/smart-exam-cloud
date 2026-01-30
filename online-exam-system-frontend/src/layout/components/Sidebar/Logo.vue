<template>
  <div class="sidebar-logo-container" :class="{'collapse':collapse}">
    <transition name="sidebarLogoFade">
      <router-link v-if="collapse" key="collapse" class="sidebar-logo-link" to="/">
        <img v-if="logo" :src="logo" class="sidebar-logo">
        <h1 v-else class="sidebar-title">{{ title }} </h1>
      </router-link>
      <router-link v-else key="expand" class="sidebar-logo-link" to="/">
        <img v-if="logo" :src="logo" class="sidebar-logo">
        <h1 class="sidebar-title">{{ title }} </h1>
      </router-link>
    </transition>
  </div>
</template>

<script>
export default {
  name: 'SidebarLogo',
  props: {
    collapse: {
      type: Boolean,
      required: true
    }
  },
  data() {
    return {
      title: '智慧考试云平台',
      logo: 'https://cdn-icons-png.flaticon.com/512/3407/3407024.png' // 采用扁平化的考试图标
    }
  }
}
</script>

<style lang="scss" scoped>
.sidebarLogoFade-enter-active {
  transition: opacity 1.5s;
}

.sidebarLogoFade-enter,
.sidebarLogoFade-leave-to {
  opacity: 0;
}

.sidebar-logo-container {
  position: relative;
  width: 100%;
  height: 64px;
  line-height: 64px;
  background: #ffffff;
  padding-left: 20px;
  text-align: left;
  overflow: hidden;
  border-bottom: 1px solid #f1f5f9;

  & .sidebar-logo-link {
    height: 100%;
    width: 100%;

    & .sidebar-logo {
      width: 28px;
      height: 28px;
      vertical-align: middle;
      margin-right: 12px;
    }

    & .sidebar-title {
      display: inline-block;
      margin: 0;
      color: #0066FF;
      font-weight: 800;
      line-height: 64px;
      font-size: 18px;
      font-family: 'Inter', 'Segoe UI', sans-serif;
      vertical-align: middle;
      letter-spacing: -0.5px;
    }
  }

  &.collapse {
    padding-left: 0;
    text-align: center;
    .sidebar-logo {
      margin-right: 0px;
    }
  }
}
</style>
