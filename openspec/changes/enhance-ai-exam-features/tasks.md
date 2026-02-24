# 实施任务清单: 增强AI考试功能

## 1. AI自动组卷 - 后端
- [x] 1.1 创建 `AiComposePaperForm` 接收组卷参数
- [x] 1.2 创建 `AiComposePaperVO` 返回试卷预览结构
- [x] 1.3 在 `IExamService` 新增 `aiComposePaper()` 方法签名
- [x] 1.4 在 `ExamServiceImpl` 实现组卷逻辑（题库筛选 + AI补充）
- [x] 1.5 设计并测试组卷 Prompt，存入 `Constants.java`
- [x] 1.6 在 `ExamController` 新增 `POST /exam/ai-compose` 接口
- [x] 1.7 新增 `POST /exam/ai-compose/confirm` 确认生成接口

## 2. AI自动组卷 - 前端
- [x] 2.1 在 `exam.js` 新增 `aiComposePaper()` 和 `confirmAiPaper()` API
- [x] 2.2 在试卷管理页新增"AI组卷"按钮入口
- [x] 2.3 创建 AI 组卷配置对话框组件 (`AiComposeDialog.vue`)
- [x] 2.4 创建试卷预览页面内容，支持调整和确认
- [x] 2.5 集成异步状态提示（生成中/完成/失败）

## 3. AI智能判卷优化 - 后端
- [x] 3.1 创建 `AiGradingDetailVO` 包含多维度评分结构
- [x] 3.2 修改 `t_exam_qu_answer` 表，新增 `ai_grading_detail` 字段 (已更新 Entity 和数据库预期)
- [x] 3.3 优化评分 Prompt，增加维度和改进建议
- [x] 3.4 修改 `AutoScoringServiceImpl` 解析新格式评分结果
- [x] 3.5 完善详情接口返回详细评分信息 (`ExamRecordDetailVO`, `UserAnswerDetailVO`)

## 4. AI智能判卷优化 - 前端
- [x] 4.1 确保 API 接口能够接收新的评分字段
- [x] 4.2 优化考试记录详情页 (`newk.vue`)，展示多维度评分
- [x] 4.3 添加"改进建议"展示区域
- [x] 4.4 支持教师批改时查看 AI 评分详情 (`makeTest.vue`)

## 5. 验证与测试
- [ ] 5.1 进行完整业务流测试：组卷 -> 考试 -> AI自动评分 -> 教师复核
- [ ] 5.2 验证 AI 补充题目的质量与知识点契合度
- [ ] 5.3 验证多维度评分的展示效果与性能
