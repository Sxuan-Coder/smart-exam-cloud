
import request from '@/utils/request'

export function examPaging(params) {
  return request({
    url: 'exams/paging',
    method: 'get',
    params
  })
}

// export function repoAdd(data) {
//   return request({
//     url: 'repo',
//     method: 'post',
//     data
//   })
// }

export function examDel(ids) {
  return request({
    url: 'exams/' + ids,
    method: 'delete'
  })
}

export function examUpdate(id, data) {
  return request({
    url: `exams/${id}`,
    method: 'put',
    data
  })
}
export function getGradeExamList(params) {
  return request({
    url: 'exams/grade',
    method: 'get',
    params
  })
}

export function getExamDetail(examId) {
  return request({
    url: 'exams/detail?examId=' + examId,
    method: 'get'
  })
}
export function examStart(examId) {
  return request({
    url: 'exams/start?examId=' + examId,
    method: 'get'
  })
}

export function examQuList(examId) {
  return request({
    url: 'exams/question/list/' + examId,
    method: 'get'
  })
}

export function fillAnswer(data) {
  return request({
    url: 'exams/full-answer',
    method: 'post',
    data
  })
}

export function quDetail(params) {
  return request({
    url: 'exams/question/single',
    method: 'get',
    params
  })
}

export function handExam(examId) {
  return request({
    url: 'exams/hand-exam/' + examId,
    method: 'get'
  })
}

export function saveData(data) {
  return request({
    url: 'exams',
    method: 'post',
    data
  })
}

export function examCheat(examId) {
  return request({
    url: `exams/cheat/${examId}`,
    method: 'put'

  })
}

export function examCollect(examId) {
  return request({
    url: `exams/collect/${examId}`,
    method: 'get'
  })
}


export function details(examId) {
  return request({
    url: `exams/details/${examId}`,
    method: 'get'
  })
}

export function aiComposePaper(data) {
  return request({
    url: 'exams/ai-compose',
    method: 'post',
    timeout: 120000, // AI 生成可能较慢，延长至 2 分钟
    data
  })
}

export function confirmAiPaper(params) {
  return request({
    url: 'exams/ai-compose/confirm',
    method: 'post',
    params
  })
}

// 获取待考试卷列表
export function getPendingExams() {
  return request({
    url: 'exams/pending',
    method: 'get'
  })
}
