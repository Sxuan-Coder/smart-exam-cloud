<template>
  <div class="dashboard-container">
    <!-- 顶部状态概览 -->
    <el-row :gutter="24" class="stat-overview">
      <el-col :span="24">
        <div class="welcome-banner">
          <div class="welcome-text">
            <h2>下午好，同学</h2>
            <p>今天也是充满进步的一天，加油！</p>
          </div>
          <div class="banner-actions">
            <el-button type="primary" round icon="el-icon-edit" @click="$router.push('/exercise/center')">开始刷题</el-button>
          </div>
        </div>
      </el-col>
    </el-row>

    <el-row :gutter="24">
      <el-col :md="14" :xs="24">
        <!-- 登录活跃度图表 -->
        <el-card class="chart-card">
          <div slot="header" class="card-header">
            <span class="title">学习旅程 · 近15日活跃度</span>
          </div>
          <div ref="charts" class="chart-div" />
        </el-card>

        <!-- 进行中的考试清单 (新增组件) -->
        <el-card class="exam-list-card">
          <div slot="header" class="card-header">
            <span class="title">进行中的考试</span>
            <span class="count-tag">{{ pendingExams.length }} 门待参加</span>
          </div>
          <div class="mini-exam-list">
            <div v-for="exam in pendingExams" :key="exam.id" class="mini-exam-item">
              <div class="exam-main-info">
                <div class="exam-tag">进行中</div>
                <h4 class="name">{{ exam.title }}</h4>
                <div class="time-range">
                  <i class="el-icon-time"></i>
                  {{ exam.startTime }} ~ {{ exam.endTime }}
                </div>
              </div>
              <el-button type="primary" size="medium" @click="goToExam(exam)">进入考试</el-button>
            </div>
            <div v-if="pendingExams.length === 0" class="empty-exams">
              <i class="el-icon-finished"></i>
              <p>暂无进行中的考试，休息一下吧</p>
            </div>
          </div>
        </el-card>
      </el-col>

      <el-col :md="10" :xs="24">
        <el-card class="notice-card">
          <div slot="header" class="card-header">
            <span class="title">智慧校园 · 动态公告</span>
          </div>
          <div class="notice-list">
            <el-collapse accordion>
              <div v-for="(item, index) in noticePage.records" :key="index">
                <el-collapse-item
                  v-if="item != null"
                  :name="index"
                >
                  <template slot="title">
                    <div class="notice-title-wrap">
                      <span class="dot"></span>
                      <span class="text">{{ item.title }}</span>
                    </div>
                  </template>
                  <div class="notice-content-body" v-html="item.content" />
                  <div class="notice-meta">
                    <span class="author"><i class="el-icon-user"></i> {{ item.realName }}</span>
                    <span class="time"><i class="el-icon-time"></i> {{ item.createTime }}</span>
                  </div>
                </el-collapse-item>
              </div>
              <div v-if="noticePage.records.length === 0" class="empty-notice">
                <i class="el-icon-document-remove"></i>
                <p>暂无公告消息</p>
              </div>
            </el-collapse>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 考试提醒弹窗 -->
    <el-dialog
      title="考试提醒"
      :visible.sync="showExamReminder"
      width="500px"
      :close-on-click-modal="false"
    >
      <div class="exam-reminder-content">
        <div class="reminder-header">
          <i class="el-icon-bell reminder-icon"></i>
          <p class="reminder-title">您有 {{ pendingExams.length }} 门考试正在进行中,请及时参加！</p>
        </div>
        <div class="exam-list">
          <div
            v-for="exam in pendingExams"
            :key="exam.id"
            class="exam-card"
          >
            <div class="exam-info">
              <h4 class="exam-title">{{ exam.title }}</h4>
              <p class="exam-time">
                <i class="el-icon-time"></i>
                {{ exam.startTime }} ~ {{ exam.endTime }}
              </p>
              <p class="exam-remaining">
                剩余时间: <span class="time-highlight">{{ exam.remainingMinutes }} 分钟</span>
              </p>
            </div>
            <el-button
              type="primary"
              size="small"
              @click="goToExam(exam)"
            >立即考试</el-button>
          </div>
        </div>
        <div class="reminder-footer">
          <el-checkbox v-model="noRemindToday">今日不再提醒</el-checkbox>
        </div>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button @click="closeReminder">稍后提醒</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { noticeGetNew } from '@/api/notice'
import { getDaily } from '@/api/stat'
import { getPendingExams } from '@/api/exam'
import echarts from 'echarts'

export default {
  data() {
    return {
      noticePage: { records: [] },
      dateArray: [],
      formattedData: [],
      myChart: null,
      // 考试提醒相关
      showExamReminder: false,
      pendingExams: [],
      noRemindToday: false,
      option: {
        tooltip: {
          trigger: 'axis',
          axisPointer: { type: 'shadow' }
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          containLabel: true
        },
        xAxis: {
          type: 'category',
          data: [],
          axisLine: { lineStyle: { color: '#e2e8f0' } },
          axisLabel: { color: '#64748b' }
        },
        yAxis: {
          type: 'value',
          splitLine: { lineStyle: { type: 'dashed', color: '#f1f5f9' } },
          axisLabel: { color: '#64748b' }
        },
        series: [{
          name: '登录时长(分钟)',
          type: 'bar',
          barWidth: '40%',
          itemStyle: {
            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
              { offset: 0, color: '#60a5fa' },
              { offset: 1, color: '#0066FF' }
            ]),
            borderRadius: [4, 4, 0, 0]
          },
          data: []
        }]
      }
    }
  },
  created() {
    this.getDailyFun()
    this.getNotice(1, 10)
    this.checkPendingExams()
  },
  mounted() {
    window.addEventListener('resize', this.resizeChart)
  },
  beforeDestroy() {
    window.removeEventListener('resize', this.resizeChart)
    if (this.myChart) this.myChart.dispose()
  },
  methods: {
    getDailyFun() {
      getDaily().then((res) => {
        if (res.code === 1) {
          const currentDate = new Date()
          this.dateArray = []
          for (let i = 0; i <= 14; i++) {
            const date = new Date(currentDate.getTime() - i * 24 * 60 * 60 * 1000)
            this.dateArray.push(date.toISOString().split('T')[0])
          }
          this.dateArray.reverse()

          const dataMap = res.data.reduce((acc, item) => {
            acc[item.loginDate] = item.totalSeconds
            return acc
          }, {})

          this.formattedData = this.dateArray.map(date => Math.floor((dataMap[date] || 0) / 60))
          
          this.option.xAxis.data = this.dateArray
          this.option.series[0].data = this.formattedData
          this.$nextTick(() => this.initCharts())
        }
      })
    },
    async getNotice(pageNum, pageSize) {
      const res = await noticeGetNew({ pageNum, pageSize })
      this.noticePage = res?.data || { records: [] }
    },
    initCharts() {
      if (!this.$refs.charts) return
      this.myChart = echarts.init(this.$refs.charts)
      this.myChart.setOption(this.option)
    },
    resizeChart() {
      this.myChart?.resize()
    },
    // 检查待考试卷
    async checkPendingExams() {
      // 检查今日是否已禁用提醒
      const today = new Date().toISOString().split('T')[0]
      const disabledDate = localStorage.getItem('exam-reminder-disabled')
      
      if (disabledDate === today) {
        return // 今日不再提醒
      }
      
      try {
        const res = await getPendingExams()
        if (res.code === 1 && res.data && res.data.length > 0) {
          this.pendingExams = res.data
          // 延迟500ms显示弹窗,避免阻塞页面加载
          setTimeout(() => {
            this.showExamReminder = true
          }, 500)
        }
      } catch (error) {
        console.error('获取待考试卷失败:', error)
      }
    },
    // 跳转到考试
    goToExam(exam) {
      localStorage.setItem('examInfo_examId', exam.id)
      this.$router.push({ name: 'prepare-exam', query: { zhi: exam } })
      this.showExamReminder = false
    },
    // 关闭提醒
    closeReminder() {
      if (this.noRemindToday) {
        // 存储今日不再提醒
        const today = new Date().toISOString().split('T')[0]
        localStorage.setItem('exam-reminder-disabled', today)
      }
      this.showExamReminder = false
    }
  }
}
</script>

<style lang="scss" scoped>
.dashboard-container {
  padding: 24px;
  background-color: #f8fafc;
}

.welcome-banner {
  background: #ffffff;
  padding: 30px 40px;
  border-radius: 20px;
  margin-bottom: 24px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
  border: 1px solid #f1f5f9;

  .welcome-text {
    h2 {
      margin: 0 0 8px 0;
      font-size: 24px;
      color: #1e293b;
      font-weight: 800;
    }
    p {
      margin: 0;
      color: #64748b;
      font-size: 15px;
    }
  }
}

.chart-card, .notice-card, .exam-list-card {
  border-radius: 20px;
  border: none;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05) !important;
  margin-bottom: 24px;
  background: #ffffff;
}

.count-tag {
  background: #eff6ff;
  color: #1e40af;
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 13px;
  font-weight: 600;
}

.mini-exam-list {
  padding: 4px 0;
  
  .mini-exam-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px;
    border-radius: 16px;
    background: #f8fafc;
    margin-bottom: 16px;
    transition: all 0.2s;
    border: 1px solid #f1f5f9;
    
    &:hover {
      transform: scale(1.01);
      border-color: #1e40af;
      background: #ffffff;
      box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05);
    }
    
    &:last-child {
      margin-bottom: 0;
    }
    
    .exam-main-info {
      .exam-tag {
        display: inline-block;
        padding: 2px 8px;
        background: #059669;
        color: white;
        border-radius: 6px;
        font-size: 11px;
        font-weight: 700;
        margin-bottom: 8px;
        text-transform: uppercase;
      }
      .name {
        margin: 0 0 6px 0;
        font-size: 17px;
        font-weight: 700;
        color: #1e293b;
      }
      .time-range {
        font-size: 13px;
        color: #94a3b8;
        display: flex;
        align-items: center;
        gap: 6px;
      }
    }
  }
}

.empty-exams {
  text-align: center;
  padding: 40px 0;
  color: #94a3b8;
  i { font-size: 32px; margin-bottom: 12px; }
  p { font-size: 14px; margin: 0; }
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  
  .title {
    font-size: 17px;
    font-weight: 800;
    color: #1e293b;
    position: relative;
    padding-left: 12px;
    
    &::before {
      content: '';
      position: absolute;
      left: 0;
      top: 50%;
      transform: translateY(-50%);
      width: 4px;
      height: 18px;
      background: #1e40af;
      border-radius: 2px;
    }
  }
}

.chart-div {
  height: 380px;
  width: 100%;
}

.notice-list {
  height: auto;
  min-height: 400px;
  padding-right: 0;
}

.notice-title-wrap {
  display: flex;
  align-items: center;
  gap: 12px;
  
  .dot {
    width: 6px;
    height: 6px;
    background: #1e40af;
    border-radius: 50%;
  }
  
  .text {
    font-weight: 700;
    color: #334155;
    font-size: 15px;
  }
}

.notice-content-body {
  padding: 16px;
  color: #475569;
  line-height: 1.6;
  font-size: 14px;
  background: #f8fafc;
  border-radius: 12px;
  margin: 8px 0;
}

.notice-meta {
  margin-top: 12px;
  display: flex;
  justify-content: flex-end;
  gap: 16px;
  font-size: 12px;
  color: #94a3b8;
  
  i { margin-right: 4px; }
}

.empty-notice {
  text-align: center;
  padding: 80px 0;
  color: #94a3b8;
  
  i { font-size: 40px; margin-bottom: 12px; }
}

::v-deep .el-collapse {
  border: none;
  .el-collapse-item__header {
    border-bottom: 1px solid #f1f5f9;
    height: 64px;
    background: transparent;
  }
  .el-collapse-item__wrap {
    border-bottom: none;
    background: transparent;
  }
}

/* 弹窗及其他保持不变... */
.exam-reminder-content {
  .reminder-header {
    text-align: center;
    margin-bottom: 24px;
    .reminder-icon { font-size: 48px; color: #1e40af; margin-bottom: 12px; }
    .reminder-title { font-size: 17px; font-weight: 700; color: #1e293b; margin: 0; }
  }
  .exam-list {
    max-height: 300px;
    overflow-y: auto;
    margin-bottom: 16px;
  }
  .exam-card {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 16px;
    border: 1px solid #f1f5f9;
    border-radius: 12px;
    margin-bottom: 12px;
    background: #f8fafc;
    .exam-info {
      flex: 1;
      .exam-title { font-size: 16px; font-weight: 700; color: #1e293b; margin: 0 0 8px 0; }
      .exam-time, .exam-remaining { font-size: 13px; color: #64748b; margin: 4px 0; }
      .time-highlight { color: #d97706; font-weight: 700; }
    }
  }
  .reminder-footer {
    padding-top: 16px;
    border-top: 1px solid #e2e8f0;
  }
}
</style>
