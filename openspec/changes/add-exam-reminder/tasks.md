# Tasks: 学生端考试提醒功能

## Task Breakdown

### Phase 1: 后端实现 (Backend)
1. **定义数据结构**
   - [ ] 创建或复用 `PendingExamVO` (包含 id, title, startTime, endTime, remainingMinutes)
   - 验证: VO 字段完整,符合前端展示需求

2. **实现业务逻辑**
   - [ ] 在 `IExamService` 添加方法签名 `Result<List<PendingExamVO>> getPendingExams(Integer userId)`
   - [ ] 在 `ExamServiceImpl` 实现方法:
     - 查询当前用户所在班级的所有考试
     - 过滤条件: `startTime <= now <= endTime` 且该用户未参加过
     - 计算剩余时间(分钟)
     - 按开始时间升序排序
   - 验证: 使用 Postman/单元测试验证返回数据正确性

3. **添加 Controller 接口**
   - [ ] 在 `ExamController` 添加 `@GetMapping("/pending")` 方法
   - [ ] 添加权限控制 `@PreAuthorize("hasAnyAuthority('role_student')")`
   - [ ] 添加 Swagger 文档注解
   - 验证: 接口文档正确显示,权限控制生效

### Phase 2: 前端实现 (Frontend)
4. **添加 API 封装**
   - [ ] 在 `src/api/exam.js` 添加 `getPendingExams()` 方法
   - 验证: 方法返回 Promise,URL 正确

5. **实现学生首页弹窗**
   - [ ] 在 `StudentPage.vue` 的 `created()` 钩子中调用 API
   - [ ] 添加 `el-dialog` 弹窗组件,绑定 `showExamReminder` 数据
   - [ ] 弹窗内容:
     - 标题: "考试提醒"
     - 提示文本: "您有 X 门考试正在进行中"
     - 考试列表: 展示名称、剩余时间
     - 操作按钮: "立即考试"(跳转到考试准备页)、"稍后提醒"(关闭弹窗)
   - 验证: UI 样式符合设计规范(无 Emoji,商务配色)

6. **实现"今日不再提醒"功能**
   - [ ] 添加复选框 `el-checkbox v-model="noRemindToday"`
   - [ ] 关闭弹窗时,如果勾选则存储到 `localStorage.setItem('exam-reminder-disabled', todayDate)`
   - [ ] 调用 API 前检查是否已禁用提醒
   - 验证: 勾选后今日不再弹窗,明日恢复提醒

### Phase 3: 测试与优化 (Testing)
7. **集成测试**
   - [ ] 测试场景1: 无待考试卷时不弹窗
   - [ ] 测试场景2: 有1门待考试卷时正确弹窗
   - [ ] 测试场景3: 有多门待考试卷时显示数量和列表
   - [ ] 测试场景4: 已参加的考试不在提醒列表中
   - [ ] 测试场景5: "今日不再提醒"功能正常

8. **性能优化**
   - [ ] 确保 API 响应时间 < 500ms
   - [ ] 添加错误处理(API 失败时不影响首页加载)
   - [ ] 添加 loading 状态(可选)

## Dependencies
- Task 3 依赖 Task 2
- Task 5 依赖 Task 4
- Task 6 依赖 Task 5
- Task 7 依赖所有前置任务

## Parallelizable Work
- Phase 1 和 Phase 2 的 Task 4 可以并行开发
- Task 6 可以与 Task 5 部分并行(先完成基础弹窗再添加今日不再提醒)
