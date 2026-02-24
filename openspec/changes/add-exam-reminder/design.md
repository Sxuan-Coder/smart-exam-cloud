# Design: 学生端考试提醒功能

## Overview
为学生用户提供主动的考试提醒服务,在登录后首页加载时自动检测当前正在进行中且未参加的考试,并通过弹窗友好地提醒用户,避免错过考试。

## Architecture

### Backend Architecture
```
ExamController (GET /exam/pending)
    ↓
IExamService.getPendingExams(userId)
    ↓
ExamServiceImpl
    ├─ 查询用户所在班级的考试列表
    ├─ 过滤: startTime <= now <= endTime
    ├─ 从 RecordMapper 查询已参加记录
    ├─ 排除已参加的考试
    └─ 返回 List<PendingExamVO>
```

### Frontend Architecture
```
StudentPage.vue (created)
    ↓
checkPendingExams()
    ├─ 检查 localStorage (今日不再提醒?)
    ├─ 调用 exam.getPendingExams()
    ├─ 如果有待考试卷 → showExamReminder = true
    └─ 渲染 el-dialog
        ├─ 显示考试列表
        └─ 提供操作按钮
```

## Data Model

### PendingExamVO
```java
public class PendingExamVO {
    private Integer id;              // 考试ID
    private String title;            // 考试标题
    private String startTime;        // 开始时间 (格式化后的字符串)
    private String endTime;          // 结束时间
    private Integer remainingMinutes; // 剩余时间(分钟)
}
```

## API Design

### Endpoint
```
GET /api/exam/pending
```

### Request
- Headers: `Authorization: Bearer <token>`
- Query Parameters: 无 (从 JWT 中获取 userId)

### Response
```json
{
  "code": 200,
  "msg": "查询成功",
  "data": [
    {
      "id": 1,
      "title": "Java 期末考试",
      "startTime": "2026-01-03 14:00:00",
      "endTime": "2026-01-03 16:00:00",
      "remainingMinutes": 45
    },
    {
      "id": 2,
      "title": "数据结构测验",
      "startTime": "2026-01-03 15:00:00",
      "endTime": "2026-01-03 16:30:00",
      "remainingMinutes": 75
    }
  ]
}
```

## UI/UX Design

### Popup Dialog
- **触发时机**: 首页加载完成后 (约 500ms 延迟,避免阻塞)
- **外观**:
  - 标题: "考试提醒" (带图标,使用 Lucide Icon,如 Bell)
  - 副标题: "您有 X 门考试正在进行中,请及时参加"
  - 考试卡片列表:
    - 考试名称 (粗体)
    - 时间范围 (灰色小字)
    - 剩余时间 (橙色高亮,如 "剩余 45 分钟")
  - 操作区:
    - 主按钮: "立即考试" (跳转到第一门考试)
    - 次要按钮: "稍后提醒" (关闭弹窗)
    - 复选框: "今日不再提醒"
- **配色**: 深蓝主题 (#1E40AF),避免紫色和渐变

### LocalStorage Schema
```javascript
{
  "exam-reminder-disabled": "2026-01-03" // 存储禁用日期
}
```

## Implementation Considerations

### Backend
- **性能优化**: 使用联表查询减少数据库往返次数
- **缓存策略**: 考虑对用户待考列表进行短时缓存 (5分钟)
- **权限控制**: 确保只有学生角色可以访问,教师和管理员应返回空列表

### Frontend
- **错误处理**: API 失败时静默处理,不影响首页加载
- **防抖**: 避免重复调用 API
- **用户体验**: 提供跳过提醒的选项,尊重用户选择

## Alternative Approaches
1. **轮询方式**: 定时轮询检查,但会增加服务器负担,不推荐
2. **WebSocket 推送**: 实时性更好,但对于登录提醒场景过于复杂,暂不采用
3. **浏览器通知**: 可作为后续增强,但需要用户授权,优先级较低

## Trade-offs
- **便利性 vs 打扰**: 通过"今日不再提醒"平衡
- **准确性 vs 性能**: 使用数据库查询而非缓存,确保数据准确性
- **简洁 vs 功能**: 初版只提供基础提醒,后续可扩展(如按考试优先级排序、提前提醒等)
