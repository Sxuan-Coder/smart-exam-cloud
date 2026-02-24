## 1. Backend Implementation
- [x] 1.1 在 `QuestionController` 中新增 `/ai-generate` 接口
- [x] 1.2 在 `QuestionServiceImpl` 中实现 AI 生成逻辑
- [x] 1.3 编写 Prompt 模板，实现对 AI 返回 JSON 的解析
- [x] 1.4 新增批量添加接口 `/batch`
- [x] 1.5 修复 OkHttp 版本冲突问题

## 2. Frontend Implementation
- [x] 2.1 在 `views/question/index.vue` 中添加"AI 出题"按钮
- [x] 2.2 开发 AI 出题对话框，集成文本输入与参数选择
- [x] 2.3 在 `api/question.js` 中封装 AI 生成请求接口
- [x] 2.4 实现预览生成题目并支持批量导入逻辑
- [x] 2.5 修复 RepoSelect 组件 Number 类型兼容问题

## 3. Database Changes (需手动执行)
```sql
ALTER TABLE t_question ADD COLUMN qu_level INT COMMENT '难度等级 (1-简单, 2-中等, 3-困难)';
ALTER TABLE t_question ADD COLUMN knowledge_point VARCHAR(255) COMMENT '知识点';
```

## 完成时间
2026-01-01
