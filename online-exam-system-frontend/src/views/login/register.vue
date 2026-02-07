<template>
  <div class="login-page">
    <!-- 动态背景装饰（保持与登录页一致） -->
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
          <h2 class="hero-text">开启您的<br/>智慧学术之旅</h2>
          <p class="hero-desc">立即注册账号，享受智能化题库管理、极速阅卷以及多维度的学情分析报告。</p>
          
          <div class="step-guide">
            <div class="step-item active">
              <span class="step-num">01</span>
              <span class="step-label">填写信息</span>
            </div>
            <div class="step-item">
              <span class="step-num">02</span>
              <span class="step-label">安全验证</span>
            </div>
            <div class="step-item">
              <span class="step-num">03</span>
              <span class="step-label">注册完成</span>
            </div>
          </div>
        </div>
      </div>

      <!-- 右侧注册表单 -->
      <div class="form-side">
        <div class="form-container">
          <div class="form-header">
            <h3>创建新账号</h3>
            <p>请填写以下信息完成注册</p>
          </div>

          <el-form
            ref="registerForm"
            :model="registerForm"
            :rules="loginRules"
            class="classic-form"
            auto-complete="on"
          >
            <el-form-item prop="userName">
              <div class="input-wrapper">
                <span class="prefix-icon"><i class="el-icon-user"></i></span>
                <el-input
                  ref="username"
                  v-model="registerForm.userName"
                  placeholder="设置用户名"
                  name="username"
                  type="text"
                  tabindex="1"
                  auto-complete="on"
                />
              </div>
            </el-form-item>

            <el-form-item prop="realName">
              <div class="input-wrapper">
                <span class="prefix-icon"><i class="el-icon-postcard"></i></span>
                <el-input
                  ref="realName"
                  v-model="registerForm.realName"
                  placeholder="真实姓名"
                  name="realName"
                  type="text"
                  tabindex="2"
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
                  v-model="registerForm.password"
                  :type="passwordType"
                  placeholder="设置登录密码"
                  name="password"
                  tabindex="3"
                  auto-complete="on"
                />
                <span class="suffix-btn" @click="showPwd">
                  <i :class="passwordType === 'password' ? 'el-icon-view' : 'el-icon-circle-check'"></i>
                </span>
              </div>
            </el-form-item>

            <el-form-item prop="checkedPassword">
              <div class="input-wrapper">
                <span class="prefix-icon"><i class="el-icon-circle-check"></i></span>
                <el-input
                  :key="checkedPasswordType"
                  ref="checkedPassword"
                  v-model="registerForm.checkedPassword"
                  :type="checkedPasswordType"
                  placeholder="确认您的密码"
                  name="checkedPassword"
                  tabindex="4"
                  auto-complete="on"
                />
                <span class="suffix-btn" @click="showPwd2">
                  <i :class="checkedPasswordType === 'password' ? 'el-icon-view' : 'el-icon-circle-check'"></i>
                </span>
              </div>
            </el-form-item>

            <div class="captcha-row">
              <el-form-item prop="code" style="flex: 1; margin-bottom: 0;">
                <div class="input-wrapper">
                  <span class="prefix-icon"><i class="el-icon-key"></i></span>
                  <el-input
                    ref="code"
                    v-model="registerForm.code"
                    placeholder="输入验证码"
                    name="code"
                    type="text"
                    tabindex="5"
                    auto-complete="off"
                    @keyup.enter.native="registerFn"
                  />
                </div>
              </el-form-item>
              <div class="captcha-box">
                <img
                  ref="captchaImg"
                  src="/api/auths/captcha"
                  alt="点击刷新"
                  @click="getVerify"
                >
              </div>
            </div>

            <el-button
              :loading="loading"
              type="primary"
              class="primary-submit-btn"
              @click.native.prevent="registerFn"
            >
              立 即 注 册
            </el-button>

            <div class="form-footer">
              <span>已有账号？</span>
              <router-link class="login-link" to="/login">返回登录</router-link>
            </div>
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
import { verifyCode, register } from '@/api/user'
import { Message } from 'element-ui'
import { Encrypt } from '@/utils/Secret'

export default {
  name: 'Register',
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
    const validateRealName = (rule, value, callback) => {
      if (!value) {
        callback(new Error('请输入真实姓名'))
      } else {
        callback()
      }
    }
    const validateCheckedPassword = (rule, value, callback) => {
      if (value != this.registerForm.password) {
        callback(new Error('两次输入密码不一致'))
      } else {
        callback()
      }
    }
    const validateCode = (rule, value, callback) => {
      if (!value) {
        callback(new Error('请输入验证码'))
      } else {
        callback()
      }
    }
    return {
      icpNumber: process.env.VUE_APP_ICP_NUMBER,
      icpLink: process.env.VUE_APP_ICP_LINK,
      registerForm: {
        userName: '',
        password: '',
        realName: '',
        checkedPassword: '',
        code: ''
      },
      loginRules: {
        userName: [{ required: true, trigger: 'blur', validator: validateUsername }],
        password: [{ required: true, trigger: 'blur', validator: validatePassword }],
        realName: [{ required: true, trigger: 'blur', validator: validateRealName }],
        checkedPassword: [{ required: true, trigger: 'blur', validator: validateCheckedPassword }],
        code: [{ required: true, trigger: 'blur', validator: validateCode }]
      },
      loading: false,
      passwordType: 'password',
      checkedPasswordType: 'password'
    }
  },
  methods: {
    registerFn() {
      this.$refs.registerForm.validate(valid => {
        if (valid) {
          this.loading = true
          verifyCode(this.registerForm.code).then((res) => {
            if (res.code) {
              const registerData = {
                userName: this.registerForm.userName,
                realName: this.registerForm.realName,
                password: Encrypt(this.registerForm.password),
                checkedPassword: Encrypt(this.registerForm.checkedPassword)
              }
              register(registerData).then((res2) => {
                this.loading = false
                if (res2.code) {
                  Message.success(res2.msg)
                  this.$router.push({ path: '/login' })
                } else {
                  this.getVerify()
                  Message.error(res2.msg)
                }
              }).catch(() => {
                this.loading = false
                this.getVerify()
                Message.error('注册失败，请重试')
              })
            } else {
              this.loading = false
              this.getVerify()
              Message.error(res.msg || '验证码验证失败')
            }
          }).catch(() => {
            this.loading = false
            this.getVerify()
            Message.error('验证码验证失败')
          })
        }
      })
    },
    getVerify() {
      this.$refs.captchaImg.src = `/api/auths/captcha?${Math.random()}`
    },
    showPwd() {
      this.passwordType = this.passwordType === 'password' ? '' : 'password'
      this.$nextTick(() => { this.$refs.password.focus() })
    },
    showPwd2() {
      this.checkedPasswordType = this.checkedPasswordType === 'password' ? '' : 'password'
      this.$nextTick(() => { this.$refs.checkedPassword.focus() })
    }
  }
}
</script>

<style lang="scss" scoped>
/* 调色盘定义 - 与登录页保持高度统一 */
$primary: #1e40af;
$primary-hover: #1e3a8a;
$accent: #D4AF37;
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

/* 动态背景装饰 */
.glass-bg {
  position: absolute;
  top: 0; left: 0; right: 0; bottom: 0;
  z-index: 0;
  .blob {
    position: absolute;
    filter: blur(80px);
    opacity: 0.15;
    z-index: -1;
    animation: float 20s infinite alternate;
  }
  .blob-1 { width: 600px; height: 600px; background: $primary; top: -100px; left: -100px; }
  .blob-2 { width: 500px; height: 500px; background: #059669; bottom: -100px; right: -100px; animation-delay: -5s; }
  .blob-3 { width: 400px; height: 400px; background: $accent; top: 50%; right: 20%; animation-delay: -10s; }
}

@keyframes float {
  from { transform: translate(0, 0) scale(1); }
  to { transform: translate(100px, 50px) scale(1.1); }
}

.login-box {
  position: relative;
  z-index: 10;
  width: 1050px;
  min-height: 650px;
  display: flex;
  background: #ffffff;
  border-radius: 24px;
  box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.1);
  overflow: hidden;
  
  &:hover {
    transform: translateY(-5px);
    transition: transform 0.3s ease;
  }
}

.brand-side {
  flex: 1;
  background-color: #1a202c;
  padding: 60px;
  color: #ffffff;
  display: flex;
  flex-direction: column;
  justify-content: center;
  
  .logo-wrapper {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 40px;
    .app-logo { width: 36px; height: 36px; color: $accent; }
    .brand-name { font-size: 18px; font-weight: 800; letter-spacing: 2px; }
  }
  
  .hero-text {
    font-size: 42px;
    font-weight: 800;
    line-height: 1.1;
    margin-bottom: 24px;
    background: linear-gradient(to right, #fff, #9ca3af);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
  }
  
  .hero-desc {
    font-size: 15px;
    color: #9ca3af;
    line-height: 1.6;
    margin-bottom: 60px;
    max-width: 320px;
  }
  
  .step-guide {
    display: flex;
    flex-direction: column;
    gap: 30px;
    
    .step-item {
      display: flex;
      align-items: center;
      gap: 20px;
      opacity: 0.4;
      transition: all 0.3s;
      
      &.active {
        opacity: 1;
        .step-num { color: $accent; border-color: $accent; }
      }
      
      .step-num {
        width: 32px;
        height: 32px;
        border: 2px solid #4b5563;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 12px;
        font-weight: 700;
      }
      
      .step-label { font-size: 14px; font-weight: 600; letter-spacing: 1px; }
    }
  }
}

.form-side {
  flex: 1.3;
  padding: 60px 80px;
  background: white;
  display: flex;
  align-items: center;
  
  .form-container { width: 100%; max-width: 420px; margin: 0 auto; }
  
  .form-header {
    margin-bottom: 40px;
    h3 { font-size: 32px; font-weight: 800; color: $text-main; margin: 0 0 8px 0; }
    p { font-size: 14px; color: $text-secondary; }
  }
}

.input-wrapper {
  position: relative;
  display: flex;
  align-items: center;
  border: 1px solid #e5e7eb;
  border-radius: 12px;
  background: #f9fafb;
  transition: all 0.3s;
  
  &:focus-within {
    border-color: $primary;
    background: white;
    box-shadow: 0 0 0 4px rgba(30, 64, 175, 0.08);
  }
  
  .prefix-icon { padding: 0 16px; color: #9ca3af; font-size: 18px; }
  .suffix-btn { padding-right: 16px; color: #9ca3af; cursor: pointer; &:hover { color: $primary; } }
  
  ::v-deep .el-input {
    .el-input__inner {
      height: 50px;
      border: none;
      background: transparent;
      padding: 0;
      font-size: 15px;
      color: $text-main;
      &::placeholder { color: #9ca3af; font-weight: 400; }
    }
  }
}

.captcha-row {
  display: flex;
  gap: 16px;
  margin: 20px 0 30px;
  .captcha-box {
    width: 120px;
    height: 52px;
    border-radius: 12px;
    border: 1px solid #e5e7eb;
    overflow: hidden;
    cursor: pointer;
    img { width: 100%; height: 100%; object-fit: cover; }
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
  box-shadow: 0 4px 6px -1px rgba(30, 64, 175, 0.2);
  transition: all 0.3s;
  
  &:hover {
    background-color: $primary-hover;
    transform: translateY(-2px);
    box-shadow: 0 10px 15px -3px rgba(30, 64, 175, 0.3);
  }
}

.form-footer {
  margin-top: 24px;
  text-align: center;
  font-size: 14px;
  color: $text-secondary;
  .login-link { color: $primary; font-weight: 700; text-decoration: none; margin-left: 8px; &:hover { text-decoration: underline; } }
}

.footer-icp { margin-top: 40px; text-align: center; a { font-size: 12px; color: #9ca3af; text-decoration: none; } }

@media (max-width: 1024px) {
  .login-box { width: 95%; flex-direction: column; }
  .brand-side { display: none; }
  .form-side { padding: 40px 20px; }
}
</style>
