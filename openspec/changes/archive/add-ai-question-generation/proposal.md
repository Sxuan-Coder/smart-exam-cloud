# Change: Add AI-assisted Question Generation

## Why
目前用户手动录入题目效率较低。通过引入 AI 辅助出题功能，用户只需提供一段文本（如教学大纲、课程摘要等），系统即可自动生成符合要求的试题，大大提升出题效率和质量。

## What Changes
- **前端 (Frontend)**:
  - 在“题目管理”页面新增“AI 出题”按钮。
  - 实现 AI 出题对话框，支持输入参考文本、选择题目类型及题目数量。
  - 实现生成结果的预览与批量导入功能。
- **后端 (Backend)**:
  - 在 `QuestionController` 新增 AI 出题接口。
  - 在 `IQuestionService` 实现 AI 出题逻辑，利用 `LLMUtil` 调用大模型。
  - 定义专门的 Prompt 模板，确保 AI 返回结构化的 JSON 数据（题干、选项、答案、解析）。

## Impact
- Affected specs: `question-management`
- Affected code:
  - Backend: `QuestionController`, `IQuestionService`, `QuestionServiceImpl`, `LLMUtil`
  - Frontend: `src/views/question/index.vue`, `src/api/question.js`
