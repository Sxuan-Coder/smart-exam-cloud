## ADDED Requirements

### Requirement: AI Question Generation
系统 SHALL 允许管理员/教师通过输入参考文本的方式，利用 AI 自动生成多种类型的试题。

#### Scenario: Generate multiple-choice questions from text
- **WHEN** 用户在“AI 出题”对话框中输入一段教学文本，并选择题目类型为“单选题”，数量为 3。
- **THEN** 系统发起 AI 请求，解析返回结果，并向用户展示生成的 3 道单选题及其选项、答案。

#### Scenario: Save AI-generated questions to repository
- **WHEN** 用户预览 AI 生成的题目并点击“确认导入”。
- **THEN** 系统将选中的题目批量保存到指定的题库中，并刷新题目列表。
