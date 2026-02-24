# Change: 学生端考试提醒功能

## Why
当前学生登录后需要主动进入"考试中心"才能查看可参加的考试,容易错过考试时间。为了提升用户体验,避免学生错过重要考试,需要在登录后主动检测并提醒学生当前正在进行中且未参加的考试。

## What Changes

### 后端改动
- 在 `IExamService` 新增 `getPendingExams(Integer userId)` 方法,返回当前时间在考试时间范围内且该学生未参加的考试列表
- 在 `ExamController` 新增 `/exam/pending` 接口（GET）,返回待考试卷列表
- 新增或复用 `PendingExamVO` 包含考试ID、标题、开始时间、结束时间、剩余时间等信息

### 前端改动
- 在学生首页（Dashboard）的 `created()` 或 `mounted()` 钩子中调用待考试卷接口
- 当检测到有待考试卷时,使用 `el-dialog` 弹窗展示待考列表
- 弹窗内容包括:
  - 考试数量提示（如"您有 3 门考试正在进行中"）
  - 考试列表（名称、剩余时间）
  - 操作按钮（"立即考试"、"稍后提醒"）
- 提供"今日不再提醒"选项（使用 localStorage 存储）

## Impact
- Affected capabilities: `student-exam-reminder`（新增）
- Affected code:
  - **后端**: `ExamController`, `IExamService`, `ExamServiceImpl`
  - **新增VO**: `PendingExamVO` 或复用现有 VO
  - **前端**: `exam.js` (API), `src/views/dashboard/rolePage/StudentPage.vue`

## Success Criteria
- 学生登录后,系统能正确检测当前时间在考试范围内且未参加的考试
- 有待考试卷时自动弹窗提醒,无则不弹窗
- 弹窗内容准确显示考试信息和剩余时间
- "今日不再提醒"功能正常工作
- 用户可以从弹窗直接跳转到考试页面
