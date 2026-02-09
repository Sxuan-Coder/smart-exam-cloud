<template>
  <el-dialog
    :title="activeStep === 1 ? 'AI 智能组卷配置' : (activeStep === 2 ? '试卷预览与调整' : '发布考试')"
    :visible.sync="dialogVisible"
    width="60%"
    top="5vh"
    :close-on-click-modal="false"
    @close="handleClose"
  >
    <!-- 步骤条 -->
    <el-steps :active="activeStep" finish-status="success" align-center style="margin-bottom: 30px">
      <el-step title="配置组卷参数" />
      <el-step title="预览生成结果" />
      <el-step title="确认发布" />
    </el-steps>

    <!-- 第一步：配置参数 -->
    <div v-if="activeStep === 1">
      <el-form :model="composeForm" :rules="rules" ref="composeForm" label-width="120px">
        <el-form-item label="试卷标题" prop="title">
          <el-input v-model="composeForm.title" placeholder="请输入试卷标题" />
        </el-form-item>

        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="目标题库" prop="repoId">
              <el-select v-model="composeForm.repoId" placeholder="请选择题库" style="width: 100%">
                <el-option v-for="item in repoList" :key="item.id" :label="item.title" :value="item.id" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="总分上限" prop="totalScore">
              <el-input-number v-model="composeForm.totalScore" :min="1" style="width: 100%" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-form-item label="考察知识点" prop="knowledgePoints">
          <el-input
            v-model="composeForm.knowledgePoints"
            type="textarea"
            :rows="2"
            placeholder="请输入考察知识点，多个用空格或逗号分隔"
            style="width: 100%"
          />
        </el-form-item>

        <el-divider>难度分布 (%)</el-divider>
        <el-row :gutter="20">
          <el-col :span="8">
            <el-form-item label="简单" prop="easyPercent" label-width="60px">
              <el-input-number v-model="composeForm.easyPercent" :min="0" :max="100" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="中等" prop="mediumPercent" label-width="60px">
              <el-input-number v-model="composeForm.mediumPercent" :min="0" :max="100" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="困难" prop="hardPercent" label-width="60px">
              <el-input-number v-model="composeForm.hardPercent" :min="0" :max="100" style="width: 100%" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-divider>题目数量与分值</el-divider>
        <el-row :gutter="10">
          <el-col :span="6">
            <el-form-item label="单选" label-width="50px">
              <el-input-number v-model="composeForm.radioCount" :min="0" label="数量" style="width: 100%" />
              <div style="margin-top: 5px">
                <el-input-number v-model="composeForm.radioScore" :min="0" label="分值" size="mini" style="width: 100%" />
              </div>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="多选" label-width="50px">
              <el-input-number v-model="composeForm.multiCount" :min="0" style="width: 100%" />
              <div style="margin-top: 5px">
                <el-input-number v-model="composeForm.multiScore" :min="0" size="mini" style="width: 100%" />
              </div>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="判断" label-width="50px">
              <el-input-number v-model="composeForm.judgeCount" :min="0" style="width: 100%" />
              <div style="margin-top: 5px">
                <el-input-number v-model="composeForm.judgeScore" :min="0" size="mini" style="width: 100%" />
              </div>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="简答" label-width="50px">
              <el-input-number v-model="composeForm.saqCount" :min="0" style="width: 100%" />
              <div style="margin-top: 5px">
                <el-input-number v-model="composeForm.saqScore" :min="0" size="mini" style="width: 100%" />
              </div>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
    </div>

    <!-- 第二步：预览结果 -->
    <div v-if="activeStep === 2" class="preview-container">
      <el-alert
        title="试卷预览生成成功。标记为 REPO 的题目来自题库，标记为 AI 的题目由生成式 AI 补充。"
        type="info"
        :closable="false"
        show-icon
        style="margin-bottom: 20px"
      />
      
      <div v-for="(group, typeName) in questionGroups" :key="typeName" class="qu-group">
        <h3 v-if="group.questions && group.questions.length > 0">{{ typeName }} ({{ group.questions.length }}题)</h3>
        <el-card v-for="(qu, index) in group.questions" :key="index" shadow="never" class="qu-card">
          <div slot="header" class="clearfix">
            <el-tag :type="qu.source === 'REPO' ? 'success' : 'warning'" size="mini">{{ qu.source }}</el-tag>
            <span style="margin-left: 10px; font-weight: 500">第 {{ index + 1 }} 题</span>
            <el-tag size="mini" effect="plain" style="margin-left: 10px">{{ getLevelExp(qu.quLevel) }}</el-tag>
          </div>
          <div class="qu-content">{{ qu.content }}</div>
          <div v-if="qu.quType !== 4" class="qu-options">
            <div v-for="(op, idx) in parseOptions(qu.options)" :key="idx" class="op-item">
              <span class="op-label">{{ getLetter(idx) }}.</span> {{ op.content }}
              <i v-if="op.isRight" class="el-icon-check" style="color: green; margin-left: 10px"></i>
            </div>
          </div>
          <div class="qu-answer">
            <strong>标准答案：</strong> {{ qu.answer }}
          </div>
        </el-card>
      </div>
    </div>

    <!-- 第三步：确认发布 -->
    <div v-if="activeStep === 3">
      <el-form label-width="120px">
        <el-form-item label="试卷标题">
          <el-input v-model="previewData.title" disabled />
        </el-form-item>
        <el-form-item label="考试班级">
          <el-select v-model="finalForm.gradeIds" multiple placeholder="请选择发布班级" style="width: 100%">
            <el-option v-for="item in classList" :key="item.id" :label="item.name" :value="item.id" />
          </el-select>
        </el-form-item>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="考试时长(分)">
              <el-input-number v-model="finalForm.examDuration" :min="1" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="及格分数">
              <el-input-number v-model="finalForm.passedScore" :min="0" :max="previewData.totalScore" style="width: 100%" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="总分">
          <el-tag type="primary">{{ previewData.totalScore }} 分</el-tag>
        </el-form-item>
      </el-form>
    </div>

    <div slot="footer" class="dialog-footer">
      <el-button @click="handleClose">取 消</el-button>
      <el-button v-if="activeStep > 1" @click="activeStep--">上一步</el-button>
      <el-button v-if="activeStep === 1" type="primary" :loading="loading" @click="handleGenerate">生成预览</el-button>
      <el-button v-if="activeStep === 2" type="primary" @click="activeStep++">下一步</el-button>
      <el-button v-if="activeStep === 3" type="success" :loading="loading" @click="handleConfirm">确认发布</el-button>
    </div>
  </el-dialog>
</template>

<script>
import { fetchPaging } from '@/api/repo'
import { fetchClasses } from '@/api/class_'
import { aiComposePaper, confirmAiPaper } from '@/api/exam'

export default {
  name: 'AiComposeDialog',
  props: {
    visible: {
      type: Boolean,
      default: false
    }
  },
  data() {
    const validatePercent = (rule, value, callback) => {
      const sum = this.composeForm.easyPercent + this.composeForm.mediumPercent + this.composeForm.hardPercent
      if (sum !== 100) {
        callback(new Error('难度比例之和必须为100%'))
      } else {
        callback()
      }
    }
    return {
      activeStep: 1,
      loading: false,
      repoList: [],
      classList: [],
      composeForm: {
        title: '',
        repoId: '',
        knowledgePoints: '',
        easyPercent: 40,
        mediumPercent: 40,
        hardPercent: 20,
        radioCount: 5,
        radioScore: 2,
        multiCount: 2,
        multiScore: 5,
        judgeCount: 3,
        judgeScore: 2,
        saqCount: 1,
        saqScore: 10,
        totalScore: 100
      },
      previewData: {},
      finalForm: {
        gradeIds: [],
        examDuration: 60,
        passedScore: 60
      },
      rules: {
        title: [{ required: true, message: '请输入标题', trigger: 'blur' }],
        repoId: [{ required: true, message: '请选择题库', trigger: 'change' }],
        knowledgePoints: [{ required: true, message: '请至少添加一个知识点', trigger: 'change' }],
        easyPercent: [{ validator: validatePercent, trigger: 'blur' }]
      }
    }
  },
  computed: {
    dialogVisible: {
      get() { return this.visible },
      set(val) { this.$emit('update:visible', val) }
    },
    questionGroups() {
      if (!this.previewData) return {}
      return {
        '单选题': { questions: this.previewData.radioQuestions || [] },
        '多选题': { questions: this.previewData.multiQuestions || [] },
        '判断题': { questions: this.previewData.judgeQuestions || [] },
        '简答题': { questions: this.previewData.saqQuestions || [] }
      }
    }
  },
  watch: {
    visible(val) {
      if (val) {
        this.fetchBaseData()
        this.activeStep = 1
      }
    }
  },
  methods: {
    async fetchBaseData() {
      const repoRes = await fetchPaging()
      this.repoList = repoRes.data
      const classRes = await fetchClasses()
      this.classList = classRes.data
    },
    handleClose() {
      this.dialogVisible = false
    },
    handleGenerate() {
      this.$refs.composeForm.validate(async(valid) => {
        if (!valid) return
        this.loading = true
        try {
          // 处理知识点：将字符串转换为数组
          const params = {
            ...this.composeForm,
            knowledgePoints: this.composeForm.knowledgePoints
              .split(/[\s,，]+/)
              .filter(item => item && item.trim())
          }
          if (params.knowledgePoints.length === 0) {
            this.$message.warning('请至少输入一个知识点')
            return
          }
          const res = await aiComposePaper(params)
          if (res.code) {
            this.previewData = res.data
            this.activeStep = 2
            this.finalForm.passedScore = Math.floor(this.previewData.totalScore * 0.6)
          } else {
            this.$message.error(res.msg)
          }
        } finally {
          this.loading = false
        }
      })
    },
    async handleConfirm() {
      if (this.finalForm.gradeIds.length === 0) {
        return this.$message.warning('请选择发布班级')
      }
      this.loading = true
      try {
        const params = {
          previewId: this.previewData.previewId,
          gradeIds: this.finalForm.gradeIds.join(','),
          examDuration: this.finalForm.examDuration,
          passedScore: this.finalForm.passedScore
        }
        const res = await confirmAiPaper(params)
        if (res.code) {
          this.$message.success('试卷发布成功！')
          this.handleClose()
          this.$emit('success')
        } else {
          this.$message.error(res.msg)
        }
      } finally {
        this.loading = false
      }
    },
    parseOptions(optStr) {
      try {
        return JSON.parse(optStr)
      } catch (e) {
        return []
      }
    },
    getLetter(index) {
      return String.fromCharCode(65 + index)
    },
    getLevelExp(level) {
      const maps = { 1: '简单', 2: '中等', 3: '困难' }
      return maps[level] || '未知'
    }
  }
}
</script>

<style scoped>
.preview-container {
  max-height: 500px;
  overflow-y: auto;
  padding: 10px;
}
.qu-group h3 {
  border-left: 4px solid #409EFF;
  padding-left: 10px;
  margin: 20px 0 10px 0;
}
.qu-card {
  margin-bottom: 15px;
}
.qu-content {
  font-size: 16px;
  margin-bottom: 15px;
  line-height: 1.5;
}
.op-item {
  margin-bottom: 8px;
}
.op-label {
  font-weight: bold;
  margin-right: 10px;
}
.qu-answer {
  margin-top: 15px;
  padding: 10px;
  background-color: #f8f9fa;
  border-radius: 4px;
}
</style>
