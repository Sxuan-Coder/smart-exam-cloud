<template>
  <div class="login-page">
    <!-- 动态背景装饰 -->
    <div class="glass-bg">
      <div class="blob blob-1"></div>
      <div class="blob blob-2"></div>
      <div class="blob blob-3"></div>
    </div>

    <div class="login-box">
      <!-- 左侧品牌展示 -->
      <div class="brand-side">
        <div class="brand-content">
          <div class="logo-wrapper">
            <div class="app-logo">
              <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M12 2L2 7L12 12L22 7L12 2Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M2 17L12 22L22 17" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M2 12L12 17L22 12" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
              </svg>
            </div>
            <h1 class="brand-name">ZHIHUI EXAM</h1>
          </div>
          <h2 class="hero-text">智绘蓝图，考就未来</h2>
          <p class="hero-desc">专业的一站式在线考试管理系统，为教育与能力评估提供精准、安全、高效的数字化解决方案。</p>
          
          <div class="feature-grid">
            <div class="feature-item">
              <div class="icon-dot"></div>
              <span>智能组卷</span>
            </div>
            <div class="feature-item">
              <div class="icon-dot"></div>
              <span>实时监控</span>
            </div>
            <div class="feature-item">
              <div class="icon-dot"></div>
              <span>自动阅卷</span>
            </div>
            <div class="feature-item">
              <div class="icon-dot"></div>
              <span>多维分析</span>
            </div>
          </div>
        </div>
      </div>

      <!-- 右侧登录表单 -->
      <div class="form-side">
        <div class="form-container">
          <div class="form-header">
            <h3>欢迎回来</h3>
            <p>请输入您的凭据以访问系统</p>
          </div>

          <el-form
            ref="loginForm"
            :model="loginForm"
            :rules="loginRules"
            class="classic-form"
            auto-complete="on"
          >
            <el-form-item prop="username">
              <div class="input-wrapper">
                <span class="prefix-icon"><i class="el-icon-user"></i></span>
                <el-input
                  ref="username"
                  v-model="loginForm.username"
                  placeholder="用户名 / 手机号"
                  name="username"
                  type="text"
                  tabindex="1"
                  auto-complete="on"
                />
              </div>
            </el-form-item>

            <el-form-item prop="password">
              <div class="input-wrapper">
                <span class="prefix-icon"><i class="el-icon-lock"></i></span>
                <el-input
                  :key="passwordType"
                  ref="password"
                  v-model="loginForm.password"
                  :type="passwordType"
                  placeholder="请输入密码"
                  name="password"
                  tabindex="2"
                  auto-complete="on"
                  @keyup.enter.native="handleLogin"
                />
                <span class="suffix-btn" @click="showPwd">
                  <i :class="passwordType === 'password' ? 'el-icon-view' : 'el-icon-circle-check'"></i>
                </span>
              </div>
            </el-form-item>

            <div class="captcha-row">
              <el-form-item prop="code" style="flex: 1; margin-bottom: 0;">
                <div class="input-wrapper">
                  <span class="prefix-icon"><i class="el-icon-key"></i></span>
                  <el-input
                    ref="codeInput"
                    v-model="loginForm.code"
                    placeholder="验证码"
                    name="code"
                    type="text"
                    tabindex="3"
                    auto-complete="off"
                    @keyup.enter.native="handleLogin"
                  />
                </div>
              </el-form-item>
              <div class="captcha-box">
                <img
                  ref="captchaImg"
                  src="/api/auths/captcha"
                  alt="点击刷新"
                  title="点击刷新验证码"
                  @click="getVerify"
                >
              </div>
            </div>

            <div class="form-options">
              <el-checkbox v-model="rememberMe" class="remember-me">记住我</el-checkbox>
              <router-link v-if="enableRegister" class="reg-link" to="/register">
                账户注册
              </router-link>
            </div>

            <el-button
              :loading="loading"
              type="primary"
              class="primary-submit-btn"
              @click.native.prevent="handleLogin"
            >
              登 录
            </el-button>
          </el-form>
          
          <div v-if="icpNumber" class="footer-icp">
            <a :href="icpLink" target="_blank">{{ icpNumber }}</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { validUsername } from '@/utils/validate'
import { getTokenInfo } from '@/utils/jwtUtils'
import { verifyCode } from '@/api/user'
import { Message } from 'element-ui'
import { Encrypt } from '@/utils/Secret'

export default {
  name: 'Login',
  data() {
    const validateUsername = (rule, value, callback) => {
      if (!validUsername(value)) {
        callback(new Error('请输入正确的用户名'))
      } else {
        callback()
      }
    }
    const validatePassword = (rule, value, callback) => {
      if (value.length < 6) {
        callback(new Error('密码不能少于6位'))
      } else {
        callback()
      }
    }
    return {
      loginForm: {
        username: '',
        password: '',
        code: ''
      },
      rememberMe: false,
      enableRegister: process.env.VUE_APP_ENABLE_REGISTER === 'true',
      icpNumber: process.env.VUE_APP_ICP_NUMBER,
      icpLink: process.env.VUE_APP_ICP_LINK,
      loginRules: {
        username: [{ required: true, trigger: 'blur', validator: validateUsername }],
        password: [{ required: true, trigger: 'blur', validator: validatePassword }],
        code: [{ required: true, trigger: 'blur', message: '请输入验证码' }]
      },
      loading: false,
      passwordType: 'password'
    }
  },
  computed: {
    redirect() {
      return this.$route.query.redirect || '/index'
    }
  },
  mounted() {
    this.$nextTick(() => {
      this.$refs.username.focus()
    })
  },
  methods: {
    getVerify() {
      this.$refs.captchaImg.src = `/api/auths/captcha?${Math.random()}`
    },
    showPwd() {
      this.passwordType = this.passwordType === 'password' ? '' : 'password'
      this.$nextTick(() => {
        this.$refs.password.focus()
      })
    },
    handleLogin() {
      verifyCode(this.loginForm.code).then((res) => {
        if (res.code) {
          this.$refs.loginForm.validate((valid) => {
            if (valid) {
              this.loading = true
              const loginData = {
                username: this.loginForm.username,
                password: Encrypt(this.loginForm.password)
              }
              this.$store
                .dispatch('user/login', loginData)
                .then(() => {
                  this.$store.commit('menu/CLOSE_SIDEBAR')
                  const userInfo = getTokenInfo()
                  this.$store.dispatch('loginUser', { id: userInfo.id })
                  this.$router.push(this.redirect || '/index')
                  this.loading = false
                })
                .catch((error) => {
                  this.getVerify()
                  Message.error(error.msg)
                  this.loading = false
                })
            }
          })
        } else {
          this.loginForm.code = ''
          this.getVerify()
          this.$message.info(res.msg)
        }
      })
    }
  }
}
</script>

<style lang="scss" scoped>
/* 调色盘定义 - 商务沉稳蓝 */
$primary: #1e40af;
$primary-hover: #1e3a8a;
$accent: #D4AF37; // 商务金
$text-main: #111827;
$text-secondary: #4b5563;
$bg-light: #f3f4f6;

.login-page {
  min-height: 100vh;
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: $bg-light;
  position: relative;
  overflow: hidden;
  font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
}

/* 动态玻璃背景效果 */
.glass-bg {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 0;
  
  .blob {
    position: absolute;
    filter: blur(80px);
    opacity: 0.15;
    z-index: -1;
    animation: float 20s infinite alternate;
  }
  
  .blob-1 {
    width: 600px;
    height: 600px;
    background: #1e40af;
    top: -100px;
    left: -100px;
  }
  
  .blob-2 {
    width: 500px;
    height: 500px;
    background: #059669; // 商务绿
    bottom: -100px;
    right: -100px;
    animation-delay: -5s;
  }
  
  .blob-3 {
    width: 400px;
    height: 400px;
    background: #d4af37;
    top: 50%;
    right: 20%;
    animation-delay: -10s;
  }
}

@keyframes float {
  from { transform: translate(0, 0) scale(1); }
  to { transform: translate(100px, 50px) scale(1.1); }
}

.login-box {
  position: relative;
  z-index: 10;
  width: 1000px;
  height: 600px;
  display: flex;
  background: #ffffff;
  border-radius: 24px;
  box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.1);
  overflow: hidden;
  transition: transform 0.3s ease;
  
  &:hover {
    transform: translateY(-5px);
  }
}

/* 左侧品牌侧边栏 */
.brand-side {
  flex: 1.1;
  background-color: #1a202c; // 深灰黑背景
  padding: 60px;
  color: #ffffff;
  display: flex;
  flex-direction: column;
  justify-content: center;
  position: relative;
  
  &::before {
    content: '';
    position: absolute;
    top: 0; left: 0; width: 100%; height: 100%;
    background-image: radial-gradient(circle at 10% 10%, rgba(30, 64, 175, 0.1) 0%, transparent 50%);
    pointer-events: none;
  }
  
  .logo-wrapper {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 40px;
    
    .app-logo {
      width: 40px;
      height: 40px;
      color: $accent;
    }
    
    .brand-name {
      font-size: 20px;
      font-weight: 800;
      letter-spacing: 2px;
      color: #fff;
      margin: 0;
    }
  }
  
  .hero-text {
    font-size: 36px;
    font-weight: 800;
    line-height: 1.2;
    margin-bottom: 24px;
    background: linear-gradient(to right, #fff, #9ca3af);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
  }
  
  .hero-desc {
    font-size: 16px;
    color: #9ca3af;
    line-height: 1.6;
    margin-bottom: 48px;
    max-width: 340px;
  }
  
  .feature-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
    
    .feature-item {
      display: flex;
      align-items: center;
      gap: 10px;
      font-size: 14px;
      color: #d1d5db;
      
      .icon-dot {
        width: 6px;
        height: 6px;
        background-color: $accent;
        border-radius: 50%;
      }
    }
  }
}

/* 右侧表单部分 */
.form-side {
  flex: 1;
  padding: 60px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  background: #fff;
  
  .form-container {
    width: 100%;
    max-width: 360px;
    margin: 0 auto;
  }
  
  .form-header {
    margin-bottom: 36px;
    
    h3 {
      font-size: 28px;
      font-weight: 800;
      color: $text-main;
      margin: 0 0 8px 0;
    }
    
    p {
      font-size: 14px;
      color: $text-secondary;
      margin: 0;
    }
  }
}

/* 输入框统一风格 */
.input-wrapper {
  position: relative;
  display: flex;
  align-items: center;
  border: 1px solid #e5e7eb;
  border-radius: 12px;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  background: #f9fafb;
  
  &:focus-within {
    border-color: $primary;
    background: #fff;
    box-shadow: 0 0 0 4px rgba(30, 64, 175, 0.08);
  }
  
  .prefix-icon {
    padding: 0 16px;
    color: #9ca3af;
    font-size: 18px;
  }
  
  .suffix-btn {
    padding-right: 16px;
    color: #9ca3af;
    cursor: pointer;
    font-size: 18px;
    &:hover { color: $primary; }
  }
  
  ::v-deep .el-input {
    border: none;
    .el-input__inner {
      height: 52px;
      line-height: 52px;
      padding: 0;
      border: none;
      background: transparent;
      color: $text-main;
      font-size: 15px;
      font-weight: 500;
      
      &::placeholder {
        color: #9ca3af;
        font-weight: 400;
      }
    }
  }
}

.captcha-row {
  display: flex;
  gap: 16px;
  margin-top: 24px;
  margin-bottom: 24px;
  
  .captcha-box {
    width: 110px;
    height: 54px;
    border-radius: 12px;
    overflow: hidden;
    border: 1px solid #e5e7eb;
    cursor: pointer;
    background: #fff;
    transition: all 0.3s;
    
    &:hover { border-color: $primary; }
    
    img { width: 100%; height: 100%; object-fit: cover; }
  }
}

.form-options {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 32px;
  
  .remember-me {
    ::v-deep .el-checkbox__label {
      color: $text-secondary;
      font-size: 14px;
    }
    ::v-deep .el-checkbox__inner {
      border-radius: 4px;
    }
  }
  
  .reg-link {
    font-size: 14px;
    color: $primary;
    text-decoration: none;
    font-weight: 600;
    &:hover { text-decoration: underline; }
  }
}

.primary-submit-btn {
  width: 100%;
  height: 54px;
  border-radius: 12px;
  background-color: $primary;
  border: none;
  font-size: 16px;
  font-weight: 700;
  letter-spacing: 2px;
  transition: all 0.3s;
  box-shadow: 0 4px 6px -1px rgba(30, 64, 175, 0.2);
  
  &:hover {
    background-color: $primary-hover;
    transform: translateY(-2px);
    box-shadow: 0 10px 15px -3px rgba(30, 64, 175, 0.3);
  }
  
  &:active {
    transform: translateY(0);
  }
}

.footer-icp {
  margin-top: 40px;
  text-align: center;
  a {
    font-size: 12px;
    color: #9ca3af;
    text-decoration: none;
    &:hover { color: $text-secondary; }
  }
}

/* 响应式适配 */
@media (max-width: 1024px) {
  .login-box { width: 90%; height: auto; flex-direction: column; }
  .brand-side { padding: 40px; order: 2; }
  .form-side { padding: 40px; order: 1; }
  .hero-text { font-size: 28px; }
}
</style>
