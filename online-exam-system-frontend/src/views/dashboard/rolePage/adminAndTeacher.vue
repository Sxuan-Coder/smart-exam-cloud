<template>
  <div class="dashboard-container">
    <!-- 顶部数据概览 -->
    <el-row :gutter="24" class="stats-row">
      <el-col :sm="8" :xs="24" class="stat-col">
        <div class="stat-card blue">
          <div class="icon-wrapper">
            <i class="el-icon-school"></i>
          </div>
          <div class="stat-content">
            <span class="label">班级总数</span>
            <span class="value">{{ classCount }}</span>
          </div>
        </div>
      </el-col>
      
      <el-col :sm="8" :xs="24" class="stat-col">
        <div class="stat-card purple">
          <div class="icon-wrapper">
            <i class="el-icon-document-copy"></i>
          </div>
          <div class="stat-content">
            <span class="label">试题总数</span>
            <span class="value">{{ quCount }}</span>
          </div>
        </div>
      </el-col>

      <el-col :sm="8" :xs="24" class="stat-col">
        <div class="stat-card green">
          <div class="icon-wrapper">
            <i class="el-icon-notebook-2"></i>
          </div>
          <div class="stat-content">
            <span class="label">试卷总数</span>
            <span class="value">{{ examCount }}</span>
          </div>
        </div>
      </el-col>
    </el-row>

    <!-- 中间图表区域 -->
    <el-row :gutter="24" class="chart-section" v-if="!loading && !error">
      <el-col :md="16" :xs="24">
        <el-card class="main-chart-card">
          <div slot="header" class="card-header">
            <span class="title">班级人数分布</span>
            <div class="legend">数据周期：实时</div>
          </div>
          <div ref="classChart" class="chart-container" />
        </el-card>
      </el-col>
      
      <el-col :md="8" :xs="24">
        <el-card class="main-chart-card">
          <div slot="header" class="card-header">
            <span class="title">试卷类型分布</span>
          </div>
          <div ref="examChart" class="chart-container" />
        </el-card>
      </el-col>
    </el-row>

    <!-- 加载与错误状态 -->
    <div v-if="loading" class="loading-wrap">
      <div class="spinner"></div>
      <p>正在同步业务数据...</p>
    </div>
    <div v-if="error" class="error-wrap">
      <i class="el-icon-error"></i>
      <p>{{ errorMessage }}</p>
    </div>
  </div>
</template>

<script>
import echarts from 'echarts'
import { classCount, classExamCount, classAllCounts } from '@/api/stat'

export default {
  name: 'AdminDashboard',
  data() {
    return {
      classCount: 0,
      quCount: 0,
      examCount: 0,
      loading: true,
      error: false,
      errorMessage: '',
      chartData: [],
      chartDataTitle: [],
      chartData2: [],
      chartDataTitle2: [],
      classChartInstance: null,
      examChartInstance: null
    }
  },
  async created() {
    await this.fetchAllData()
  },
  mounted() {
    window.addEventListener('resize', this.handleResize)
  },
  watch: {
    // 当loading变为false且没有错误时，初始化图表
    loading(newVal) {
      if (!newVal && !this.error) {
        this.$nextTick(() => {
          this.initCharts()
        })
      }
    }
  },
  beforeDestroy() {
    if (this.classChartInstance) this.classChartInstance.dispose()
    if (this.examChartInstance) this.examChartInstance.dispose()
    window.removeEventListener('resize', this.handleResize)
  },
  methods: {
    async fetchAllData() {
      this.loading = true
      try {
        const res0 = await classAllCounts()
        if (res0.data) {
          this.classCount = res0.data.classCount
          this.quCount = res0.data.questionCount
          this.examCount = res0.data.examCount
        }

        const res1 = await classCount()
        if (res1.data) {
          this.chartData = res1.data.map(item => ({ name: item.gradeName, value: item.totalStudent }))
          this.chartDataTitle = this.chartData.map(item => item.name)
        }

        const res2 = await classExamCount()
        if (res2.data) {
          this.chartData2 = res2.data.map(item => ({ name: item.gradeName, value: item.total }))
          this.chartDataTitle2 = this.chartData2.map(item => item.name)
        }

        this.loading = false
      } catch (error) {
        this.error = true
        this.errorMessage = `数据加载失败: ${error.message || '未知错误'}`
        this.loading = false
      }
    },
    initCharts() {
      this.classChartInstance = echarts.init(this.$refs.classChart)
      this.examChartInstance = echarts.init(this.$refs.examChart)
      this.updateCharts()
    },
    updateCharts() {
      const commonPieEffect = {
        itemStyle: {
          borderRadius: 8,
          borderColor: '#fff',
          borderWidth: 2
        },
        label: { show: false },
        emphasis: {
          label: { show: true, fontSize: 14, fontWeight: 'bold' }
        }
      }

      this.classChartInstance.setOption({
        tooltip: { trigger: 'item' },
        color: ['#0066FF', '#10B981', '#F59E0B', '#EF4444', '#8B5CF6'],
        series: [{
          type: 'pie',
          radius: ['50%', '80%'],
          avoidLabelOverlap: false,
          data: this.chartData,
          ...commonPieEffect
        }]
      })

      this.examChartInstance.setOption({
        tooltip: { trigger: 'item' },
        color: ['#0066FF', '#6366F1', '#EC4899', '#14B8A6'],
        series: [{
          type: 'pie',
          radius: '75%',
          data: this.chartData2,
          emphasis: {
            itemStyle: {
              shadowBlur: 10,
              shadowOffsetX: 0,
              shadowColor: 'rgba(0, 0, 0, 0.5)'
            }
          }
        }]
      })
    },
    handleResize() {
      this.classChartInstance?.resize()
      this.examChartInstance?.resize()
    }
  }
}
</script>

<style lang="scss" scoped>
.dashboard-container {
  padding: 32px;
  background-color: #f9fafb;
}

.stats-row {
  margin-bottom: 32px;
}

.stat-card {
  background: #ffffff;
  padding: 24px;
  border-radius: 20px;
  display: flex;
  align-items: center;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
  transition: transform 0.2s;
  
  &:hover {
    transform: translateY(-4px);
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
  }

  .icon-wrapper {
    width: 64px;
    height: 64px;
    border-radius: 16px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 28px;
    margin-right: 20px;
  }

  .stat-content {
    display: flex;
    flex-direction: column;
    
    .label {
      font-size: 15px;
      color: #64748b;
      margin-bottom: 4px;
    }
    
    .value {
      font-size: 28px;
      font-weight: 800;
      color: #1e293b;
    }
  }

  /* 颜色变体 */
  &.blue { 
    .icon-wrapper { background: #eff6ff; color: #3b82f6; } 
  }
  &.purple { 
    .icon-wrapper { background: #f5f3ff; color: #8b5cf6; } 
  }
  &.green { 
    .icon-wrapper { background: #ecfdf5; color: #10b981; } 
  }
}

.main-chart-card {
  border-radius: 20px;
  border: none;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05) !important;
  
  .card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    
    .title {
      font-size: 18px;
      font-weight: 700;
      color: #1e293b;
    }
    
    .legend {
      font-size: 13px;
      color: #94a3b8;
    }
  }
}

.chart-container {
  height: 380px;
  padding: 20px 0;
}

.loading-wrap, .error-wrap {
  height: 400px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: #64748b;
  
  .spinner {
    width: 40px;
    height: 40px;
    border: 4px solid #f3f3f3;
    border-top: 4px solid #0066FF;
    border-radius: 50%;
    animation: spin 1s linear infinite;
    margin-bottom: 16px;
  }
}

.error-wrap {
  i { font-size: 48px; color: #ef4444; margin-bottom: 16px; }
  p { color: #ef4444; }
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

@media (max-width: 768px) {
  .stat-col { margin-bottom: 16px; }
}
</style>
