# Change: 增强AI考试功能 (AI自动组卷 + AI智能判卷优化)

## Why
当前系统已具备AI出题和基础AI评分功能，但尚不支持**AI自动组卷**（根据知识点、难度、题型分布自动生成完整试卷），且现有**AI判卷**仅返回基础评分，缺乏详细的评分维度、逐点扣分明细和改进建议。本提案旨在补齐这两项核心AI能力，提升教师出卷效率和学生考后学习体验。

## What Changes

### 功能一：AI 自动组卷
- 新增 `AiComposePaperDTO` 接收组卷参数（知识点范围、难度分布、各题型数量、总分）
- 新增 `AiComposePaperVO` 返回预览试卷结构
- 在 `IExamService` 新增 `aiComposePaper()` 方法，调用AI生成试卷结构
- 在 `ExamController` 新增 `/exam/ai-compose` 接口（POST）
- 前端在试卷管理页新增"AI组卷"入口，支持参数配置、预览和确认生成

### 功能二：AI 智能判卷优化
- 优化 `AutoScoringServiceImpl` 中的评分 Prompt，增加评分维度（知识点覆盖、逻辑性、表达准确性）
- 新增 `AiGradingDetailVO` 包含逐点扣分明细和改进建议
- 修改现有评分返回结构，支持详细评分报告
- 前端优化成绩详情页，展示AI逐点扣分和学习建议
- 支持教师复核和分数调整

## Impact
- Affected capabilities: `ai-auto-compose`（新增）, `ai-grading`（新增）
- Affected code:
  - **后端**: `ExamController`, `IExamService`, `ExamServiceImpl`, `AutoScoringServiceImpl`, `Constants.java`（Prompt）
  - **新增DTO/VO**: `AiComposePaperDTO`, `AiComposePaperVO`, `AiGradingDetailVO`
  - **前端**: `exam.js` (API), 试卷管理页组件, 成绩详情页组件
