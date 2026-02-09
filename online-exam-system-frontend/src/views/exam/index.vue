<template>
  <div class="exam-container" style="padding: 24px 0">
    <el-row :gutter="24" style="margin: 0 24px">
      <!-- Header区域 -->
      <el-col :span="24">
        <el-card class="header-card">
          <div class="header-content">
            <div class="timer-box">
              <i class="el-icon-time" style="font-size: 20px; color: #1e40af"></i>
              <span style="font-weight: 500">剩余时间：</span>
              <exam-timer v-model="paperData.leftSeconds" @timeout="doHandler(true)" />
            </div>
            <el-button
              :loading="loading"
              type="primary"
              round
              icon="el-icon-s-promotion"
              @click="handHandExamPre()"
            >
              {{ handleText }}
            </el-button>
          </div>
        </el-card>
      </el-col>

      <!-- 答题卡区域 -->
      <el-col :span="6" :xs="24" style="margin-bottom: 20px">
        <el-card class="content-h" body-style="padding: 20px">
          <p class="card-title">答题状态</p>
          <div class="card-line" style="justify-content: center; margin-bottom: 30px">
            <el-tag type="info" size="small" effect="plain">未作答</el-tag>
            <el-tag type="success" size="small" effect="dark">已作答</el-tag>
            <el-tag type="warning" size="small" effect="dark">正在答题</el-tag>
          </div>

          <div style="padding-top: 10px">
            <!-- 单选题答题卡 -->
            <question-card-section
              v-if="hasQuestions(paperData.radioList)"
              title="单选题"
              :questions="paperData.radioList"
              :current-item="cardItem"
              @select-question="handSave"
            />

            <!-- 多选题答题卡 -->
            <question-card-section
              v-if="hasQuestions(paperData.multiList)"
              title="多选题"
              :questions="paperData.multiList"
              :current-item="cardItem"
              @select-question="handSave"
            />

            <!-- 判断题答题卡 -->
            <question-card-section
              v-if="hasQuestions(paperData.judgeList)"
              title="判断题"
              :questions="paperData.judgeList"
              :current-item="cardItem"
              @select-question="handSave"
            />

            <!-- 简答题答题卡 -->
            <question-card-section
              v-if="hasQuestions(paperData.saqList)"
              title="简答题"
              :questions="paperData.saqList"
              :current-item="cardItem"
              @select-question="handSave"
            />
          </div>
        </el-card>
      </el-col>

      <!-- 答题区域 -->
      <el-col :span="18" :xs="24">
        <el-card class="qu-content content-h">
          <!-- 题干显示 -->
          <div class="qu-header" style="margin-bottom: 32px">
            <el-tag type="primary" effect="plain" style="margin-right: 12px; border-radius: 4px">
              第 {{ (cardItem.sort || 0) + 1 }} 题
            </el-tag>
            <span v-if="quData.content" style="font-size: 20px; font-weight: 600; vertical-align: middle">
              {{ quData.content }}
            </span>
          </div>
          
          <div v-if="quData.image" style="margin-bottom: 24px">
            <el-image 
              :src="quData.image"
              :preview-src-list="[quData.image]" 
              style="max-width: 400px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.08)" 
            />
          </div>

          <!-- 选项选择区域 -->
          <div class="options-container" style="min-height: 300px">
            <!-- 单选题 & 判断题 -->
            <div v-if="quData.quType === 1 || quData.quType === 3">
              <el-radio-group v-model="radioValue" style="width: 100%">
                <el-radio
                  v-for="item in quData.answerList"
                  :key="item.id"
                  :label="item.id"
                >
                  <span style="font-weight: bold; margin-right: 12px">{{ numberToLetter(item.sort) }}.</span>
                  <span>{{ item.content }}</span>
                  <div v-if="item.image" style="margin-top: 12px">
                    <el-image :src="item.image" :preview-src-list="[item.image]" style="max-width: 260px; border-radius: 8px" />
                  </div>
                </el-radio>
              </el-radio-group>
            </div>

            <!-- 多选题 -->
            <div v-if="quData.quType === 2">
              <el-checkbox-group v-model="multiValue" style="width: 100%">
                <el-checkbox
                  v-for="item in quData.answerList"
                  :key="item.id"
                  :label="item.id"
                >
                  <span style="font-weight: bold; margin-right: 12px">{{ numberToLetter(item.sort) }}.</span>
                  <span>{{ item.content }}</span>
                  <div v-if="item.image" style="margin-top: 12px">
                    <el-image :src="item.image" :preview-src-list="[item.image]" style="max-width: 260px; border-radius: 8px" />
                  </div>
                </el-checkbox>
              </el-checkbox-group>
            </div>

            <!-- 简答题 -->
            <div v-if="quData.quType === 4">
              <el-input
                v-model="saqTextarea"
                type="textarea"
                :rows="8"
                placeholder="在此输入您的答案..."
                resize="none"
              />
            </div>
          </div>

          <!-- 操作导航 -->
          <div style="margin-top: 48px; display: flex; gap: 16px; justify-content: flex-start; border-top: 1px solid #f1f5f9; padding-top: 32px">
            <el-button
              v-if="showPrevious"
              plain
              icon="el-icon-arrow-left"
              @click="handPrevious()"
            >
              上一题
            </el-button>

            <el-button
              v-if="showNext && cardItem.sort != allItem.length - 1"
              type="primary"
              icon="el-icon-arrow-right"
              @click="handNext()"
            >
              下一题
            </el-button>

            <el-button
              v-if="cardItem.sort === allItem.length - 1"
              type="success"
              icon="el-icon-upload2"
              @click="submitLastAnswer()"
            >
              提交本题
            </el-button>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 弹窗组件 -->
    <exam-summary-dialog
      :visible.sync="examPreVisible"
      :record-data="recordData"
      @close="handleClose"
      @confirm="doHandler"
    />

    <el-dialog
      title="监控提醒"
      :visible.sync="tipsFlag"
      width="400px"
      center
      :close-on-click-modal="false"
      custom-class="cheat-dialog"
    >
      <div style="text-align: center; padding: 20px 0">
        <i class="el-icon-warning" style="font-size: 48px; color: #dc2626; margin-bottom: 16px"></i>
        <p style="font-size: 16px; color: #1e293b; font-weight: 500">{{ examMeg }}</p>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {
  quDetail,
  handExam,
  fillAnswer,
  examCollect,
  examCheat,
  examQuList
} from '@/api/exam'
import { Loading } from 'element-ui'
import ExamTimer from '@/components/ExamTimer'
import QuestionCardSection from './components/QuestionCardSection'
import ExamSummaryDialog from './components/ExamSummaryDialog'

export default {
  name: 'ExamProcess',
  components: {
    ExamTimer,
    QuestionCardSection,
    ExamSummaryDialog
  },
  data() {
    return {
      examId: '',
      receivedRow: null,
      // 全屏/不全屏
      isFullscreen: false,
      showPrevious: false,
      showNext: true,
      loading: false,
      handleText: '交卷',
      saqTextarea: '',
      pageLoading: false,
      // 试卷ID
      paperId: '',
      // 当前答题卡
      cardItem: {},
      allItem: [],
      tipsFlag: false,
      examPreVisible: false,
      // 当前题目内容
      quData: {
        answerList: []
      },
      testData: {},
      pkExam: null,
      examMeg: '',
      // 试卷信息
      paperData: {
        leftSeconds: 99999,
        radioList: [],
        multiList: [],
        judgeList: [],
        saqList: []
      },
      // 单选选定值
      radioValue: '',
      // 多选选定值
      multiValue: [],
      // 已答ID
      answeredIds: [],
      recordData: null,
      //
      submittedAnswers: {}
    }
  },
  created() {
    this.examId = localStorage.getItem('examId')
    this.paperId = this.examId
    this.startExam(this.examId)
    this.fetchData(this.examId)
  },
  mounted() {
    // 基础防作弊监听
    document.addEventListener('visibilitychange', this.pageHidden)
    document.addEventListener('fullscreenchange', this.handleFullscreenChange)
    window.addEventListener('blur', this.handleWindowBlur)
    window.addEventListener('keydown', this.handleKeyDown)
    window.addEventListener('contextmenu', this.handleContextMenu)
    
    // 自动尝试进入全屏
    this.enterFullscreen()

    this.$nextTick(() => {
      const body = document.querySelector('body')
      body.style.overflow = 'auto'
    })
  },
  beforeDestroy() {
    document.removeEventListener('visibilitychange', this.pageHidden)
    document.removeEventListener('fullscreenchange', this.handleFullscreenChange)
    window.removeEventListener('blur', this.handleWindowBlur)
    window.removeEventListener('keydown', this.handleKeyDown)
    window.removeEventListener('contextmenu', this.handleContextMenu)
    this.exitFullscreen()
    clearInterval(this.countdownTime)
  },
  methods: {
    // 检查问题列表是否存在
    hasQuestions(list) {
      return list && list.length > 0
    },

    // 检查选项是否被选中
    isCheck(myOption, sort) {
      if (!myOption) return false
      const arr = myOption.split(',').map(Number)
      return arr.includes(sort)
    },

    // 处理对话框关闭
    handleClose() {
      this.examPreVisible = false
    },
    // 将0-5转换为A-F
    numberToLetter(input) {
      if (input === null || input === undefined) return ''

      const numberToCharMap = {
        0: 'A',
        1: 'B',
        2: 'C',
        3: 'D',
        4: 'E',
        5: 'F'
      }

      // 处理单个数字
      if (typeof input === 'number' || /^\d+$/.test(input)) {
        return numberToCharMap[parseInt(input, 10)] || ''
      }

      // 处理逗号分隔的数字
      if (/^\d+(,\d+)*$/.test(input)) {
        return input.split(',')
          .map(num => numberToCharMap[parseInt(num.trim(), 10)] || '')
          .join(',')
      }

      return ''
    },

    // 交卷前预览
    handHandExamPre() {
      this.handSave(this.cardItem)
      examCollect(this.examId).then((res) => {
        // 按答题卡排序
        this.recordData = this.allItem.map(item =>
          res.data.find(d => d.id === item.questionId)
        )

        this.examPreVisible = true
      })
    },
    // 切换页面检测 (VisibilityChange)
    pageHidden(e = null) {
      if (document.visibilityState === 'hidden') {
        this.reportCheat('切换浏览器页签')
      }
    },

    // 窗口失去焦点检测 (Blur)
    handleWindowBlur() {
      // 延迟一小段时间，避免点击页面内某些元素时误触
      setTimeout(() => {
        if (!document.hasFocus()) {
          this.reportCheat('窗口失去焦点（可能在切换程序）')
        }
      }, 500)
    },

    // 键盘按键屏蔽
    handleKeyDown(e) {
      // 屏蔽 F12, Ctrl+C, Ctrl+V, Ctrl+U, Ctrl+S
      const forbiddenKeys = [123] // F12
      if (forbiddenKeys.includes(e.keyCode) || 
          (e.ctrlKey && ['c', 'v', 'u', 's', 'a'].includes(e.key.toLowerCase())) ||
          (e.metaKey && ['c', 'v', 'u', 's', 'a'].includes(e.key.toLowerCase()))) {
        e.preventDefault()
        this.$message({
          message: '系统已禁用此快捷键，请专心答题！',
          type: 'warning'
        })
        return false
      }
    },

    // 屏蔽右键菜单
    handleContextMenu(e) {
      e.preventDefault()
      this.$message({
        message: '右键菜单已禁用',
        type: 'warning'
      })
      return false
    },

    // 统一处理作弊上报逻辑
    reportCheat(reason) {
      console.warn(`检测到异常行为: ${reason}`)
      examCheat(this.examId).then((res) => {
        if (res.code) {
          this.examMeg = res.msg
          this.tipsFlag = true
          // 如果后端返回 data 为 true，说明已强制交卷/踢出
          if (res.data) {
            setTimeout(() => {
              this.$router.push({
                name: 'text-center',
                params: { id: this.paperId }
              })
            }, 3000)
          }
        }
      })
    },

    // 全屏状态改变监听
    handleFullscreenChange() {
      if (!document.fullscreenElement) {
        this.reportCheat('退出了全屏模式')
      }
    },

    // 全屏操作
    enterFullscreen() {
      const docElm = document.documentElement
      if (docElm.requestFullscreen) {
        docElm.requestFullscreen().catch(() => {
          console.warn('全屏请求被拒绝')
        })
      }
    },

    exitFullscreen() {
      if (document.exitFullscreen && document.fullscreenElement) {
        document.exitFullscreen()
      }
    },

    // 开始考试
    startExam(examId) {
      examQuList(examId).then((res) => {
        this.paperData = res.data
      })
    },
    /**
     * 统计有多少题没答的
     * @returns {number}
     */
    countNotAnswered() {
      let notAnswered = 0
      const checkList = (list) => {
        if (list) {
          list.forEach(item => {
            if (!item.checkout) {
              notAnswered += 1
            }
          })
        }
      }

      checkList(this.paperData.radioList)
      checkList(this.paperData.multiList)
      checkList(this.paperData.judgeList)
      checkList(this.paperData.saqList)

      return notAnswered
    },

    /**
     * 下一题
     */
    handNext() {
      const index = this.cardItem.sort + 1
      if (index < this.allItem.length) {
        this.handSave(this.allItem[index])
      }
    },

    /**
     * 上一题
     */
    handPrevious() {
      const index = this.cardItem.sort - 1
      if (index >= 0) {
        this.handSave(this.allItem[index])
      }
    },
    // 清空Session
    // 使用函数清除以 "exam_" 开头的所有键值对
    clearSessionStorageByPrefix(prefix) {
      Object.keys(sessionStorage)
        .filter(key => key.startsWith(prefix))
        .forEach(key => sessionStorage.removeItem(key))
    },

    // 交卷
    doHandler(isAutomatic = false) {
      const performSubmit = () => {
        this.handleText = isAutomatic ? '时间到，正在自动交卷...' : '正在交卷，请等待...'
        this.loading = true
        // 删除当前标签页
        this.$store.commit('menu/REMOVE_TAG', {
          title: this.$route.meta.title,
          path: this.$route.path,
          name: this.$route.name
        })
        handExam(this.examId).then(() => {
          this.$message({
            message: isAutomatic ? '考试时间到，试卷已自动提交！' : '试卷提交成功！',
            type: 'success'
          })
          this.clearSessionStorageByPrefix('exam_')
          this.$router.push({ name: 'text-center', params: { id: this.paperId }})
        }).catch((error) => {
          this.loading = false
          this.handleText = '交卷'
          this.$message({
            type: 'error',
            message: (isAutomatic ? '自动' : '') + '交卷失败，请联系管理员！'
          })
          console.error((isAutomatic ? '自动' : '') + '交卷失败:', error);
        })
      }

      if (isAutomatic) {
        // 如果是自动触发（时间到），直接执行提交
        performSubmit()
      } else {
        // 如果是手动触发（点击按钮或确认预览），显示确认框
        const notAnswered = this.countNotAnswered()
        const msg = notAnswered > 0
          ? `您还有 ${notAnswered} 题未作答，确认要交卷吗?`
          : '确认要交卷吗？'

        this.$confirm(msg, '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        })
          .then(() => {
            // 用户在确认框中点击“确定”后执行提交
            performSubmit()
          })
          .catch(() => {
            // 用户点击“取消”
            this.$message({
              type: 'info',
              message: '交卷已取消，您可以继续作答！'
            })
          })
      }
    },

    // 保存答案
    handSave(item, callback) {
      // 更新上一题/下一题按钮状态
      this.showPrevious = item.sort > 0
      this.showNext = item.sort < this.allItem.length - 1

      // 保存当前题目的引用，以便在回调中更新其状态
      const currentItem = this.cardItem

      // 获取题目ID
      const questionId = currentItem.questionId
      // 判断题目类型
      const currentQuType = this.quData.quType

      // 准备答案数据
      let answerContent = ''
      if (currentQuType === 4) {
        ('简答题');
        // 简答题答案
        answerContent = this.saqTextarea.trim() // 去除首尾空格
      } else {
        ('单选、多选、判断题')
        // 单选、多选、判断题答案
        const answers = [] // 使用空数组初始化
        if (currentQuType === 2) { // 多选
          answers.push(...this.multiValue)
        } else if (currentQuType === 1 || currentQuType === 3) { // 单选或判断
          // 确保 radioValue 不是空字符串、null 或 undefined
          if (this.radioValue !== '' && this.radioValue !== null && this.radioValue !== undefined) {
            answers.push(this.radioValue)
          }
        }
        answerContent = answers.join(',')
      }

      const hasAnswer = !!answerContent // 检查是否有实际答案内容
      // 获取上次成功保存的答案
      const lastSavedAnswer = this.submittedAnswers[questionId]
      // 决定是否需要调用API保存
      // 条件：1. 有答案内容 且 (上次未保存过 或 当前答案与上次保存的不同)
      //       2. 或者是一个强制保存的回调 (如交卷前预览)
      const shouldCallApi = (hasAnswer && (lastSavedAnswer === undefined || answerContent !== lastSavedAnswer)) || callback

      // 如果答案已提交且未更改，且不是强制提交（callback不存在），则跳过提交
      // --- 不需要调用 API 的情况 ---
      if (!shouldCallApi) {
        console.log(`Question ${questionId}: No change or no answer, skipping API call.`)
        // 如果用户清空了答案 (从有答案变为空)
        if (!hasAnswer && lastSavedAnswer !== undefined) {
           console.log(`Question ${questionId}: Answer cleared by user.`)
           this.updateQuestionStatus(questionId, 0) // 更新UI为未作答
           delete this.submittedAnswers[questionId] // 从已提交记录中移除
           sessionStorage.removeItem('exam_' + questionId) // 清理sessionStorage标记
        }
        // 无论是否需要API调用，如果不是强制回调，都需要加载下一题
        if (!callback) {
           this.fetchQuData(item) // 加载目标题目数据
        } else {
           // 如果是强制回调（预览），直接执行回调
           callback()
        }
        return // 结束 handSave
      }

      // --- 需要调用 API 的情况 ---
      console.log(`Question ${questionId}: Answer changed or forced save, calling API.`)
      const params = {
        examId: this.paperId,
        quId: questionId,
        answer: answerContent
      }

       // 对多选题答案进行排序 (如果需要)
       if (currentQuType === 2 && hasAnswer) {
        const sortedAnswers = answerContent.split(',')
          .map(id => parseInt(id))
          .sort((a, b) => {
            const itemA = this.quData.answerList.find(opt => opt.id === a)
            const itemB = this.quData.answerList.find(opt => opt.id === b)
            // 按选项的 sort 字段排序
            return (itemA?.sort ?? 0) - (itemB?.sort ?? 0)
          })
          .join(',')
        params.answer = sortedAnswers
      }
      // 添加 loading 状态提示用户正在保存
      const saveLoading = Loading.service({
          target: this.$el.querySelector('.qu-content'), // 只覆盖题目区域
          text: '正在保存答案...',
          background: 'rgba(255, 255, 255, 0.7)'
      });
      fillAnswer(params).then((res) => {
        saveLoading.close() // 关闭 loading
        if (res.code) { // 保存成功
          console.log(`Question ${questionId}: Save successful.`)
          // 更新已提交答案记录
          this.submittedAnswers[questionId] = answerContent
          // 更新 sessionStorage 标记
          sessionStorage.setItem('exam_' + questionId, '1')
          // 更新答题卡状态
          this.updateQuestionStatus(questionId, 1)

          // 如果是简答题，并且保存成功了，现在可以清空输入框了
          // if (currentQuType === 4) {
          //   this.saqTextarea = '' // 考虑是否真的需要清空，或者保留以便用户修改？暂时不清空，让用户看到自己提交的内容
          // }

          // 执行回调（如果存在）
          if (callback) {
            callback()
          }
          // 保存成功后，加载下一个题目
          this.fetchQuData(item)

        } else { // 保存失败 (API 返回 code 为 false)
          console.error(`Question ${questionId}: Save failed (API response error):`, res.msg)
          this.$message({
            message: `答案保存失败: ${res.msg || '未知错误'}`,
            type: 'error',
            duration: 3000 // 显示时间长一点
          })
          // 保存失败，**不** 清空输入框，**不** 更新状态，**不** 加载下一题
          // 用户停留在当前页面，可以尝试重新提交
        }
      }).catch((error) => { // 保存异常 (网络错误等)
        saveLoading.close() // 关闭 loading
        console.error(`Question ${questionId}: Save failed (Network/request error):`, error)
        this.$message({
          message: '答案保存时发生网络错误，请稍后重试！',
          type: 'error',
          duration: 3000
        })
        // 保存异常，**不** 清空输入框，**不** 更新状态，**不** 加载下一题
      })
    },

    // 更新题目状态
    updateQuestionStatus(questionId, status) {
      // 在所有题型列表中查找并更新状态
      const updateListStatus = (list) => {
        if (list && list.length > 0) {
          const question = list.find(q => q.questionId === questionId)
          if (question) {
            question.checkout = status
          }
        }
      }

      updateListStatus(this.paperData.radioList)
      updateListStatus(this.paperData.multiList)
      updateListStatus(this.paperData.judgeList)
      updateListStatus(this.paperData.saqList)
    },

    // 提交最后一题答案
    submitLastAnswer() {
      const currentItem = this.cardItem
      // 获取题目ID
      const questionId = currentItem.questionId
      // 判断题目类型
      const currentQuType = this.quData.quType

      // 准备答案数据
      let answerContent = ''
      if (currentQuType === 4) {
        // 简答题答案
        answerContent = this.saqTextarea.trim()
      } else {
        // 单选、多选、判断题答案
        const answers = []
        if (currentQuType === 2) {
          answers.push(...this.multiValue)
        }else if (currentQuType === 1 || currentQuType === 3) {
          if (this.radioValue !== '' && this.radioValue !== null && this.radioValue !== undefined) {
            answers.push(this.radioValue)
          }
        }
        // 显式处理空数组情况，避免join出空字符串
        if (answers.length > 0) {
             answerContent = answers.join(',')
        } else {
             answerContent = '' // 确保空答案是空字符串
        }
      }

      // 检查是否有答案
      const hasAnswer = !!answerContent

      if (!hasAnswer) {
        this.$message({
          message: '请先填写答案再提交！',
          type: 'warning'
        })
        return
      }

      const lastSavedAnswer = this.submittedAnswers[questionId]
      const shouldCallApi = hasAnswer && (lastSavedAnswer === undefined || answerContent !== lastSavedAnswer)

      if (!shouldCallApi) {
         this.$message({
            message: '答案未更改，无需重复提交。',
            type: 'info'
         })
         return
      }

      const params = {
        examId: this.paperId,
        quId: questionId,
        answer: answerContent
      }

      if (currentQuType === 2 && hasAnswer) {
         const sortedAnswers = answerContent.split(',')
           .map(id => parseInt(id))
           .sort((a, b) => {
             const itemA = this.quData.answerList.find(opt => opt.id === a)
             const itemB = this.quData.answerList.find(opt => opt.id === b)
             return (itemA?.sort ?? 0) - (itemB?.sort ?? 0)
           })
           .join(',')
         params.answer = sortedAnswers
      }

      const saveLoading = Loading.service({ /* ... loading config ... */ });

      fillAnswer(params).then((res) => {
        saveLoading.close();
        if (res.code) {
          this.submittedAnswers[questionId] = answerContent
          sessionStorage.setItem('exam_' + questionId, '1')
          this.updateQuestionStatus(questionId, 1)
          this.$message({
            message: '最后一题答案提交成功！',
            type: 'success'
          })
          // 用户可以选择交卷了
        } else {
          this.$message({
            message: `最后一题答案提交失败: ${res.msg || '未知错误'}`,
            type: 'error'
          })
        }
      }).catch((error) => {
        saveLoading.close();
        console.error(`Question ${questionId}: Submit last answer failed:`, error)
        this.$message({
          message: '最后一题答案提交时发生网络错误！',
          type: 'error'
        })
      })
    },


    // 试卷详情
    fetchQuData(item) {
      if (!item || !item.questionId) {
        console.warn('Invalid question item:', item)
        return
      }

      // 打开
      const loading = Loading.service({
        text: '拼命加载中',
        background: 'rgba(0, 0, 0, 0.7)'
      })

      // 获得详情
      this.cardItem = item
      const examId = localStorage.getItem('examId')
      // 查找下个详情
      const params = { examId: examId, questionId: item.questionId }

      // 在请求新数据前，清空上一题的答案状态，避免显示残留
      this.radioValue = ''
      this.multiValue = []
      // 简答题不清空，因为 fetchQuData 会覆盖它

      quDetail(params).then((response) => {
        loading.close()
        if (!response.code || !response.data) {
          this.$message.error(response.msg || '加载题目失败')
          return
        }

        this.quData = response.data
        // 根据新加载的题目数据，恢复用户已选的答案 (如果之前保存过)
        if (response.data.quType === 4) {
           this.saqTextarea = response.data.answerList?.[0]?.content || ''
        } else if (response.data.quType === 1 || response.data.quType === 3) {
           const checkedOption = response.data.answerList?.find(opt => opt.checkout)
           this.radioValue = checkedOption ? checkedOption.id : ''
        } else if (response.data.quType === 2) {
           this.multiValue = response.data.answerList?.filter(opt => opt.checkout).map(opt => opt.id) || []
        }
      }).catch((error) => {
        loading.close()
        console.error('Failed to fetch question detail:', error)
        this.$message.error('网络错误，加载题目详情失败！')
      })
    },

    // 试卷详情
    fetchData(examId) {
      examQuList(examId).then((response) => {
        if (!response.code || !response.data) {
          this.$message.error(response.msg || '获取题目列表失败')
          // 如果未处于考试状态，跳转回试卷中心
          if (response.msg === '未处于考试进行中状态') {
             this.$router.push({ name: 'text-center' })
          }
          return
        }

        // 试卷内容
        this.paperData = response.data
        this.allItem = []

        // 统计总题数，判断是否为空
        const totalCount = (this.paperData.radioList?.length || 0) + 
                          (this.paperData.multiList?.length || 0) + 
                          (this.paperData.judgeList?.length || 0) + 
                          (this.paperData.saqList?.length || 0)
        
        if (totalCount === 0) {
          this.$message.warning('该试卷没有题目，请联系老师处理！')
          return
        }

        // 获得第一题内容
        this.setFirstQuestion()

        // 合并所有题目到allItem数组
        this.mergeAllQuestions()

        // 当前选定
        if (this.cardItem) {
          this.fetchQuData(this.cardItem)
        }
      }).catch(err => {
        console.error('Fetch data failed:', err)
        this.$message.error('获取试卷数据发生系统错误')
      })
    },

    // 设置第一个题目
    setFirstQuestion() {
      if (this.paperData.radioList && this.paperData.radioList.length > 0) {
        this.cardItem = this.paperData.radioList[0]
      } else if (this.paperData.multiList && this.paperData.multiList.length > 0) {
        this.cardItem = this.paperData.multiList[0]
      } else if (this.paperData.judgeList && this.paperData.judgeList.length > 0) {
        this.cardItem = this.paperData.judgeList[0]
      } else if (this.paperData.saqList && this.paperData.saqList.length > 0) {
        this.cardItem = this.paperData.saqList[0]
      }
    },

    // 合并所有题目
    mergeAllQuestions() {
      const addQuestionsToAllItems = (questionList) => {
        if (questionList && questionList.length > 0) {
          questionList.forEach(item => this.allItem.push(item))
        }
      }

      addQuestionsToAllItems(this.paperData.radioList)
      addQuestionsToAllItems(this.paperData.multiList)
      addQuestionsToAllItems(this.paperData.judgeList)
      addQuestionsToAllItems(this.paperData.saqList)
    },

    // 处理滚动事件
    handleScroll() {
      // 实现滚动逻辑
    },

    // 获取左侧距离
    getLfetDistance() {
      const body = document.querySelector('body')
      this.flexLeft = (body.offsetWidth - 1200) / 2
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/styles/variables.module.scss";

.exam-container {
  min-height: 100vh;
  background-color: #f9fafb;
}

.content-h {
  height: calc(100vh - 120px);
  overflow-y: auto;
  border-radius: 16px;
  background: #fff;
}

/* // 答题卡样式优化 */
.card-title {
  background: #f8fafc;
  line-height: 48px;
  text-align: center;
  font-size: 16px;
  font-weight: 600;
  color: #1e293b;
  border-bottom: 1px solid #f1f5f9;
  margin: -20px -20px 20px -20px;
}

.card-line {
  padding: 0 10px;
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-bottom: 24px;
  
  .el-tag {
    border-radius: 6px;
    border: none;
    font-weight: 500;
  }
}

/* // 题目内容区域 */
.qu-content {
  padding: 32px !important;
  
  p {
    font-size: 18px;
    line-height: 1.6;
    color: #1e293b;
    font-weight: 500;
    margin-bottom: 24px;
  }
}

/* // 选项样式重塑 */
::v-deep {
  .el-radio, .el-checkbox {
    padding: 16px 20px;
    border-radius: 12px;
    border: 1px solid #e2e8f0;
    margin-bottom: 16px;
    width: 100%;
    transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
    background: #fff;
    white-space: normal;
    display: flex;
    align-items: flex-start;

    &.is-checked {
      border-color: #1e40af;
      background-color: #f0f4ff;
      box-shadow: 0 4px 6px -1px rgba(30, 64, 175, 0.1);
      
      .el-radio__label, .el-checkbox__label {
        color: #1e40af !important;
        font-weight: 600;
      }
    }

    &:hover:not(.is-checked) {
      border-color: #cbd5e1;
      background: #f8fafc;
    }

    .el-radio__inner, .el-checkbox__inner {
      display: none;
    }

    .el-radio__label, .el-checkbox__label {
      padding-left: 0;
      font-size: 15px;
      line-height: 1.5;
      color: #475569;
    }
  }
}

/* // 计时器与操作栏卡片 */
.el-card.header-card {
  border-radius: 16px;
  margin-bottom: 20px;
  background: #fff;
  border: none;
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
  
  .header-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 0;
    
    .timer-box {
      font-size: 15px;
      color: #64748b;
      display: flex;
      align-items: center;
      gap: 8px;
    }
  }
}

/* // 简答题文本框 */
::v-deep .el-textarea__inner {
  border-radius: 12px;
  padding: 16px;
  border: 1px solid #e2e8f0;
  font-size: 15px;
  background-color: #f8fafc;
  
  &:focus {
    border-color: #1e40af;
    background-color: #fff;
  }
}

/* // 响应式适配 */
@media (max-width: 768px) {
  .content-h {
    height: auto;
    margin-bottom: 20px;
  }
  .qu-content {
    padding: 20px !important;
  }
}
</style>
