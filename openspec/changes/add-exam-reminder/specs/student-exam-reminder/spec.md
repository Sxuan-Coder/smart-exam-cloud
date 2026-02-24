# Capability: 学生考试提醒 (Student Exam Reminder)

## ADDED Requirements

### Requirement: 自动检测待考试卷
系统应该在学生登录并进入首页时,自动检测当前时间在考试时间范围内且该学生未参加的考试。

#### Scenario: 学生登录后有待考试卷
- **Given** 学生"张三"登录系统
- **And** 当前时间为 2026-01-03 14:30
- **And** 存在考试"Java期末考试",时间范围 14:00-16:00
- **And** "张三"尚未参加该考试
- **When** "张三"首页加载完成
- **Then** 系统应返回该考试在待考列表中
- **And** 剩余时间应计算为 90 分钟

#### Scenario: 学生登录后无待考试卷
- **Given** 学生"李四"登录系统
- **And** 当前无正在进行的考试
- **When** "李四"首页加载完成
- **Then** 系统应返回空列表
- **And** 不应显示提醒弹窗

#### Scenario: 学生已参加的考试不应提醒
- **Given** 学生"王五"登录系统
- **And** 存在考试"数据结构测验",时间范围 15:00-16:30
- **And** "王五"已经提交了该考试答卷
- **When** "王五"首页加载完成
- **Then** 该考试不应出现在待考列表中

### Requirement: 友好的弹窗提醒
当检测到待考试卷时,应该以非阻塞的方式友好地提醒学生,并提供快捷操作入口。

#### Scenario: 显示单门待考试卷
- **Given** 系统检测到 1 门待考试卷
- **When** 弹窗显示
- **Then** 应显示考试名称、时间范围和剩余时间
- **And** 提供"立即考试"和"稍后提醒"按钮
- **And** 提示文本应为"您有 1 门考试正在进行中"

#### Scenario: 显示多门待考试卷
- **Given** 系统检测到 3 门待考试卷
- **When** 弹窗显示
- **Then** 应显示所有考试的列表
- **And** 按开始时间升序排序
- **And** 提示文本应为"您有 3 门考试正在进行中"

#### Scenario: 立即考试功能
- **Given** 弹窗显示考试"Java期末考试"
- **When** 学生点击"立即考试"
- **Then** 应跳转到该考试的准备页面
- **And** 弹窗应关闭

### Requirement: 今日不再提醒
学生应该能够选择在当天不再显示考试提醒弹窗,避免重复打扰。

#### Scenario: 勾选今日不再提醒
- **Given** 考试提醒弹窗已显示
- **When** 学生勾选"今日不再提醒"复选框
- **And** 关闭弹窗
- **Then** 应在 localStorage 中记录当前日期
- **And** 同一天内再次登录不应显示提醒

#### Scenario: 次日恢复提醒
- **Given** 学生昨日勾选了"今日不再提醒"
- **And** 当前日期为次日
- **When** 学生登录首页
- **Then** 如果有待考试卷,应正常显示提醒

### Requirement: 权限控制
只有学生角色可以接收考试提醒,教师和管理员不应看到此功能。

#### Scenario: 学生访问待考试卷接口
- **Given** 当前用户角色为"学生"
- **When** 调用 GET /api/exam/pending
- **Then** 应返回 200 状态码
- **And** 返回待考试卷列表

#### Scenario: 教师访问待考试卷接口
- **Given** 当前用户角色为"教师"
- **When** 调用 GET /api/exam/pending
- **Then** 应返回 403 状态码
- **And** 提示"权限不足"

## MODIFIED Requirements
无

## REMOVED Requirements
无

## Related Capabilities
- `student-exam-participation`: 学生参加考试的核心流程
- `exam-time-control`: 考试时间范围的判定逻辑
