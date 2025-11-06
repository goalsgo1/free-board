# 🔔 푸시 알림 시스템 기획서

## 📋 개요

푸시 알림을 통해 사용자에게 의미 있는 정보를 전달하고, 유령 회원을 재활성화하며, 돌아가신 분을 기억하고 싶은 마음을 전달합니다.

## 🎯 푸시 알림의 목적

1. **기억과 추모**: 돌아가신 분을 기억하고 추모하는 마음 전달
2. **사용자 유치**: 유령 회원 재활성화 및 신규 사용자 유치
3. **활동 촉진**: 앱 내 활동을 자연스럽게 유도
4. **공감과 위로**: 사용자 간 공감과 위로의 공동체 형성

---

## 📊 기능별 푸시 알림 분석

### 1. 추모관 관련 알림

#### 1.1 추모관 생성 완료 알림
- **상황**: 사용자가 추모관을 생성했을 때
- **목적**: 생성 완료 확인 및 추모관 방문 유도
- **알림 내용**: 
  - "추모관이 생성되었습니다. [고인 이름]님을 기억하는 공간을 만들어주셔서 감사합니다."
  - "추모관 보러 가기" 버튼
- **발송 시점**: 추모관 생성 직후
- **대상**: 추모관 생성자
- **우선순위**: 낮음 (즉시 발송 불필요)

#### 1.2 추모관에 새 댓글 알림
- **상황**: 추모관에 댓글이 달렸을 때
- **목적**: 위로 메시지 확인 및 응답 유도
- **알림 내용**:
  - "[댓글 작성자]님이 [고인 이름]님의 추모관에 위로 메시지를 남겼습니다."
  - 댓글 내용 일부 (50자)
  - "댓글 보러 가기" 버튼
- **발송 시점**: 댓글 작성 직후
- **대상**: 추모관 생성자
- **우선순위**: 높음 (즉시 발송)
- **제한**: 
  - 같은 추모관에 1시간 내 여러 댓글이 달리면 묶어서 발송
  - 알림 설정에서 OFF 가능

#### 1.3 추모관 방문 수 증가 알림
- **상황**: 추모관 방문 수가 특정 수치에 도달했을 때
- **목적**: 추모관의 관심도 확인 및 위로
- **알림 내용**:
  - "[고인 이름]님의 추모관에 [N]명이 방문했습니다."
  - "많은 분들이 [고인 이름]님을 기억하고 계십니다."
  - "추모관 보러 가기" 버튼
- **발송 시점**: 방문 수가 10, 50, 100, 500, 1000명 단위로 도달 시
- **대상**: 추모관 생성자
- **우선순위**: 중간 (당일 발송)

#### 1.4 추모관에 추모금 전달 알림
- **상황**: 추모관에 추모금이 전달되었을 때
- **목적**: 추모금 수령 확인 및 감사 표현
- **알림 내용**:
  - "[기부자 이름]님이 [고인 이름]님의 추모관에 추모금을 전달했습니다."
  - "추모금: ₩[금액]"
  - "추모금 내역 보기" 버튼
- **발송 시점**: 추모금 전달 직후
- **대상**: 추모관 생성자 (수령자)
- **우선순위**: 높음 (즉시 발송)

#### 1.5 추모관 공유 알림
- **상황**: 추모관이 공유되었을 때
- **목적**: 공유 활동 확인 및 감사
- **알림 내용**:
  - "[고인 이름]님의 추모관이 공유되었습니다."
  - "더 많은 분들이 [고인 이름]님을 기억하고 계십니다."
  - "추모관 보러 가기" 버튼
- **발송 시점**: 공유 발생 시 (일일 1회 집계)
- **대상**: 추모관 생성자
- **우선순위**: 낮음 (당일 발송)

### 2. 댓글 관련 알림

#### 2.1 내 댓글에 답글 알림
- **상황**: 내가 작성한 댓글에 답글이 달렸을 때
- **목적**: 대화 참여 유도
- **알림 내용**:
  - "[답글 작성자]님이 댓글에 답글을 남겼습니다."
  - 답글 내용 일부 (50자)
  - "답글 보러 가기" 버튼
- **발송 시점**: 답글 작성 직후
- **대상**: 원댓글 작성자
- **우선순위**: 높음 (즉시 발송)

### 3. 기도 요청 관련 알림

#### 3.1 기도 요청 알림
- **상황**: 새로운 기도 요청이 등록되었을 때
- **목적**: 기도 참여 유도
- **알림 내용**:
  - "[작성자 이름]님이 기도 요청을 등록했습니다."
  - 기도 요청 제목
  - "함께 기도하기" 버튼
- **발송 시점**: 기도 요청 등록 직후
- **대상**: 모든 사용자 (알림 설정 ON인 경우)
- **우선순위**: 중간 (당일 발송)
- **제한**: 하루 최대 3개까지

#### 3.2 내 기도 요청에 참여 알림
- **상황**: 내가 작성한 기도 요청에 참여했을 때
- **목적**: 기도 참여 확인 및 감사
- **알림 내용**:
  - "[참여자 이름]님이 함께 기도하고 있습니다."
  - "현재 [N]명이 함께 기도하고 있습니다."
  - "기도 요청 보러 가기" 버튼
- **발송 시점**: 기도 참여 직후
- **대상**: 기도 요청 작성자
- **우선순위**: 중간 (당일 발송)
- **제한**: 같은 기도 요청에 1시간 내 여러 참여가 있으면 묶어서 발송

### 4. 감정 공유 게시판 관련 알림

#### 4.1 내 글에 댓글/좋아요 알림
- **상황**: 내가 작성한 감정 공유 글에 댓글이나 좋아요가 달렸을 때
- **목적**: 공감 확인 및 응답 유도
- **알림 내용**:
  - "[사용자 이름]님이 글에 공감을 표시했습니다."
  - 또는 "[사용자 이름]님이 댓글을 남겼습니다."
  - "글 보러 가기" 버튼
- **발송 시점**: 댓글/좋아요 발생 직후
- **대상**: 글 작성자
- **우선순위**: 중간 (당일 발송)
- **제한**: 같은 글에 1시간 내 여러 활동이 있으면 묶어서 발송

### 5. 추모금 관련 알림

#### 5.1 추모금 수령 완료 알림
- **상황**: 추모금 출금이 완료되었을 때
- **목적**: 출금 완료 확인
- **알림 내용**:
  - "추모금 출금이 완료되었습니다."
  - "출금액: ₩[금액]"
  - "추모금 내역 보기" 버튼
- **발송 시점**: 출금 처리 완료 후
- **대상**: 수령자
- **우선순위**: 높음 (즉시 발송)

### 6. 기념일 관련 알림

#### 6.1 생일 알림
- **상황**: 고인의 생일 전날 및 당일
- **목적**: 생일을 기억하고 추모
- **알림 내용**:
  - "오늘은 [고인 이름]님의 생일입니다."
  - "생일을 축하하며 [고인 이름]님을 기억합니다."
  - "추모관 보러 가기" 버튼
- **발송 시점**: 생일 전날 오후 6시, 생일 당일 오전 9시
- **대상**: 추모관 생성자 및 추모관을 좋아요한 사용자
- **우선순위**: 높음 (정확한 시간 발송)

#### 6.2 기일 알림
- **상황**: 고인이 돌아가신 날 (기일) 전날 및 당일
- **목적**: 기일을 기억하고 추모
- **알림 내용**:
  - "내일은 [고인 이름]님이 돌아가신 날입니다."
  - 또는 "오늘은 [고인 이름]님이 돌아가신 날입니다."
  - "[고인 이름]님을 기억하며 함께 추모합니다."
  - "추모관 보러 가기" 버튼
- **발송 시점**: 기일 전날 오후 6시, 기일 당일 오전 9시
- **대상**: 추모관 생성자 및 추모관을 좋아요한 사용자
- **우선순위**: 높음 (정확한 시간 발송)

#### 6.3 기념일 주간 알림
- **상황**: 기념일이 1주일 전
- **목적**: 기념일 준비 및 추모관 방문 유도
- **알림 내용**:
  - "[고인 이름]님의 [생일/기일]이 1주일 후입니다."
  - "추모관을 방문하여 [고인 이름]님을 기억해보세요."
  - "추모관 보러 가기" 버튼
- **발송 시점**: 기념일 1주일 전 오전 10시
- **대상**: 추모관 생성자
- **우선순위**: 중간

### 7. 홈 화면 공개 제안 알림

#### 7.1 홈 화면 공개 제안 알림
- **상황**: 추모글이 많은 공감을 받았을 때
- **목적**: 홈 화면 공개 제안
- **알림 내용**:
  - "당신의 추모글이 많은 공감을 받았습니다."
  - "좋아요 [N]개, 댓글 [N]개"
  - "홈 화면에 공개하여 더 많은 사람들과 나누시겠어요?"
  - "공개하기" / "나중에" 버튼
- **발송 시점**: 좋아요 + 댓글 수 합계가 10개 이상 도달 시
- **대상**: 편지 작성자
- **우선순위**: 높음 (즉시 발송)

### 8. 프리미엄 관련 알림

#### 8.1 프리미엄 구독 만료 알림
- **상황**: 프리미엄 구독이 만료되기 3일 전
- **목적**: 구독 갱신 유도
- **알림 내용**:
  - "프리미엄 구독이 3일 후 만료됩니다."
  - "구독을 갱신하여 모든 기능을 계속 이용하세요."
  - "구독 갱신하기" 버튼
- **발송 시점**: 만료 3일 전 오전 10시
- **대상**: 프리미엄 구독자
- **우선순위**: 중간

#### 8.2 프리미엄 구독 만료 알림 (만료일)
- **상황**: 프리미엄 구독이 만료된 날
- **목적**: 구독 갱신 유도
- **알림 내용**:
  - "프리미엄 구독이 만료되었습니다."
  - "구독을 갱신하여 모든 기능을 계속 이용하세요."
  - "구독 갱신하기" 버튼
- **발송 시점**: 만료일 오전 9시
- **대상**: 프리미엄 구독자
- **우선순위**: 중간

---

## 🎯 사용자 유치 및 재활성화 알림

### 1. 신규 사용자 유치 알림

#### 1.1 가입 환영 알림
- **상황**: 신규 사용자가 가입했을 때
- **목적**: 앱 사용 안내 및 첫 추모관 생성 유도
- **알림 내용**:
  - "기억의 정원에 오신 것을 환영합니다."
  - "소중한 분을 기억하는 추모관을 만들어보세요."
  - "추모관 만들기" 버튼
- **발송 시점**: 가입 직후
- **대상**: 신규 사용자
- **우선순위**: 중간

#### 1.2 첫 추모관 생성 유도 알림
- **상황**: 가입 후 3일이 지났는데 추모관을 만들지 않은 경우
- **목적**: 첫 추모관 생성 유도
- **알림 내용**:
  - "소중한 분을 기억하는 추모관을 만들어보세요."
  - "사진, 편지, 추억을 담아 영원히 기억할 수 있습니다."
  - "추모관 만들기" 버튼
- **발송 시점**: 가입 후 3일째 오전 10시
- **대상**: 추모관을 만들지 않은 신규 사용자
- **우선순위**: 중간

#### 1.3 앱 기능 안내 알림
- **상황**: 가입 후 7일이 지났는데 활동이 적은 경우
- **목적**: 앱 기능 안내 및 활동 유도
- **알림 내용**:
  - "기억의 정원에서 할 수 있는 것들"
  - "추모관 만들기, 댓글 작성, 기도 요청 등 다양한 기능을 이용해보세요."
  - "앱 둘러보기" 버튼
- **발송 시점**: 가입 후 7일째 오전 10시
- **대상**: 활동이 적은 신규 사용자
- **우선순위**: 낮음

### 2. 유령 회원 재활성화 알림

#### 2.1 장기 미접속 유도 알림 (1주일)
- **상황**: 마지막 접속 후 7일이 지났을 때
- **목적**: 앱 재방문 유도
- **알림 내용**:
  - "[고인 이름]님의 추모관에 새로운 위로 메시지가 도착했습니다."
  - "많은 분들이 [고인 이름]님을 기억하고 계십니다."
  - "추모관 보러 가기" 버튼
- **발송 시점**: 마지막 접속 후 7일째 오전 10시
- **대상**: 7일 이상 미접속 사용자 (추모관이 있는 경우)
- **우선순위**: 중간
- **조건**: 
  - 추모관이 있고, 최근 활동(댓글, 방문 등)이 있는 경우에만 발송
  - 활동이 없으면 다른 알림 사용

#### 2.2 장기 미접속 유도 알림 (2주일)
- **상황**: 마지막 접속 후 14일이 지났을 때
- **목적**: 앱 재방문 유도
- **알림 내용**:
  - "오래간만입니다. [고인 이름]님을 기억하는 시간을 가져보세요."
  - "추모관을 방문하여 소중한 추억을 되새겨보세요."
  - "추모관 보러 가기" 버튼
- **발송 시점**: 마지막 접속 후 14일째 오전 10시
- **대상**: 14일 이상 미접속 사용자 (추모관이 있는 경우)
- **우선순위**: 중간

#### 2.3 장기 미접속 유도 알림 (1개월)
- **상황**: 마지막 접속 후 30일이 지났을 때
- **목적**: 앱 재방문 유도
- **알림 내용**:
  - "[고인 이름]님의 영원한 시간이 계속 흐르고 있습니다."
  - "새로운 삶의 시간: [N]년 [N]개월 [N]일"
  - "추모관을 방문하여 [고인 이름]님을 기억해보세요."
  - "추모관 보러 가기" 버튼
- **발송 시점**: 마지막 접속 후 30일째 오전 10시
- **대상**: 30일 이상 미접속 사용자 (추모관이 있는 경우)
- **우선순위**: 중간

#### 2.4 장기 미접속 유도 알림 (3개월)
- **상황**: 마지막 접속 후 90일이 지났을 때
- **목적**: 앱 재방문 유도
- **알림 내용**:
  - "기억의 정원에서 [고인 이름]님을 기억하고 계신가요?"
  - "많은 시간이 흘렀지만, [고인 이름]님에 대한 기억은 영원합니다."
  - "추모관을 방문하여 소중한 추억을 되새겨보세요."
  - "추모관 보러 가기" 버튼
- **발송 시점**: 마지막 접속 후 90일째 오전 10시
- **대상**: 90일 이상 미접속 사용자 (추모관이 있는 경우)
- **우선순위**: 낮음

#### 2.5 기념일 기반 재활성화 알림
- **상황**: 기념일이 다가올 때 (유령 회원)
- **목적**: 기념일을 통해 앱 재방문 유도
- **알림 내용**:
  - "[고인 이름]님의 [생일/기일]이 [N]일 후입니다."
  - "기념일을 맞이하여 [고인 이름]님을 기억하는 시간을 가져보세요."
  - "추모관 보러 가기" 버튼
- **발송 시점**: 기념일 3일 전 오전 10시
- **대상**: 30일 이상 미접속 사용자 중 기념일이 있는 경우
- **우선순위**: 높음 (기념일은 중요하므로)

#### 2.6 활동 기반 재활성화 알림
- **상황**: 추모관에 새로운 활동이 있을 때 (유령 회원)
- **목적**: 새로운 활동을 통해 앱 재방문 유도
- **알림 내용**:
  - "[고인 이름]님의 추모관에 새로운 위로 메시지가 도착했습니다."
  - "많은 분들이 [고인 이름]님을 기억하고 계십니다."
  - "댓글 보러 가기" 버튼
- **발송 시점**: 댓글이 달린 후 (유령 회원인 경우)
- **대상**: 7일 이상 미접속 사용자 중 추모관에 댓글이 달린 경우
- **우선순위**: 높음 (실제 활동이 있으므로)

### 3. 돌아가신 분을 기억하는 알림

#### 3.1 영원한 시간 알림 (주간)
- **상황**: 매주 특정 요일
- **목적**: 돌아가신 분을 기억하고 추모
- **알림 내용**:
  - "[고인 이름]님의 새로운 삶의 시간이 계속 흐르고 있습니다."
  - "새로운 삶의 시간: [N]년 [N]개월 [N]일"
  - "[고인 이름]님을 기억하며 함께 추모합니다."
  - "추모관 보러 가기" 버튼
- **발송 시점**: 매주 일요일 오전 9시
- **대상**: 추모관 생성자 및 추모관을 좋아요한 사용자
- **우선순위**: 중간
- **제한**: 사용자가 설정한 경우에만 발송

#### 3.2 영원한 시간 알림 (월간)
- **상황**: 매월 1일
- **목적**: 돌아가신 분을 기억하고 추모
- **알림 내용**:
  - "새로운 달이 시작되었습니다."
  - "[고인 이름]님의 새로운 삶의 시간: [N]년 [N]개월"
  - "[고인 이름]님을 기억하며 함께 추모합니다."
  - "추모관 보러 가기" 버튼
- **발송 시점**: 매월 1일 오전 9시
- **대상**: 추모관 생성자 및 추모관을 좋아요한 사용자
- **우선순위**: 중간
- **제한**: 사용자가 설정한 경우에만 발송

#### 3.3 기념일 기억 알림
- **상황**: 기념일 전날 및 당일
- **목적**: 기념일을 기억하고 추모
- **알림 내용**: 기념일 알림과 동일 (위 참조)
- **특징**: 유령 회원에게도 발송하여 재활성화 유도

#### 3.4 특별한 날 기억 알림
- **상황**: 돌아가신 날로부터 특정 기간 경과 시
- **목적**: 특별한 날을 기억하고 추모
- **알림 내용**:
  - "[고인 이름]님이 돌아가신 지 [N]년이 되었습니다."
  - "시간이 흘러도 [고인 이름]님에 대한 기억은 영원합니다."
  - "추모관을 방문하여 [고인 이름]님을 기억해보세요."
  - "추모관 보러 가기" 버튼
- **발송 시점**: 
  - 1주년, 1개월, 100일, 1년, 2년, 5년 등 특별한 날
  - 해당 날짜 오전 9시
- **대상**: 추모관 생성자 및 추모관을 좋아요한 사용자
- **우선순위**: 높음

---

## 📅 알림 발송 스케줄

### 일일 알림
- **오전 9시**: 기념일 알림 (생일/기일 당일)
- **오전 10시**: 일반 알림 (재활성화, 기능 안내 등)
- **오후 6시**: 기념일 알림 (생일/기일 전날)

### 주간 알림
- **일요일 오전 9시**: 영원한 시간 알림 (주간)

### 월간 알림
- **매월 1일 오전 9시**: 영원한 시간 알림 (월간)

### 즉시 발송 알림
- 댓글 알림
- 추모금 전달 알림
- 홈 화면 공개 제안 알림
- 기도 요청 알림 (선택)

---

## 🎨 알림 메시지 톤앤매너

### 기본 원칙
1. **따뜻하고 위로하는 톤**: 추모 앱의 특성상 따뜻하고 위로하는 메시지
2. **존중과 기억**: 돌아가신 분에 대한 존중과 기억 강조
3. **희망과 위로**: 죽음 이후에도 시간이 흐른다는 희망적 메시지
4. **자연스러운 유도**: 활동 유도는 자연스럽고 부드럽게

### 메시지 예시

#### 기념일 알림
- ✅ 좋은 예: "오늘은 [고인 이름]님의 생일입니다. 생일을 축하하며 [고인 이름]님을 기억합니다."
- ❌ 나쁜 예: "[고인 이름]님의 생일입니다. 추모관을 방문하세요."

#### 재활성화 알림
- ✅ 좋은 예: "[고인 이름]님의 영원한 시간이 계속 흐르고 있습니다. 새로운 삶의 시간: [N]년 [N]개월 [N]일"
- ❌ 나쁜 예: "오래간만입니다. 앱을 다시 사용해보세요."

#### 활동 알림
- ✅ 좋은 예: "[사용자 이름]님이 [고인 이름]님의 추모관에 위로 메시지를 남겼습니다."
- ❌ 나쁜 예: "새로운 댓글이 있습니다."

---

## ⚙️ 알림 설정

### 추모관별 알림 설정 (핵심)

각 추모관마다 개별적으로 알림 설정을 관리할 수 있습니다. 사용자는 각 추모관의 특성에 맞게 알림을 켜고 끌 수 있습니다.

#### 추모관별 알림 설정 화면
- **위치**: 추모관 상세 화면 → 설정 버튼 → "알림 설정"
- **기능**: 각 추모관마다 개별 알림 설정 관리
- **설정 항목**:
  1. **기념일 알림** (생일/기일)
     - 생일 알림 ON/OFF
     - 기일 알림 ON/OFF
     - 기념일 1주일 전 알림 ON/OFF
  2. **댓글 알림**
     - 새 댓글 알림 ON/OFF
     - 댓글 답글 알림 ON/OFF
  3. **기도 요청 알림**
     - 기도 요청 알림 ON/OFF
     - 기도 참여 알림 ON/OFF
  4. **추모금 알림**
     - 추모금 전달 알림 ON/OFF
     - 추모금 수령 완료 알림 ON/OFF
  5. **방문 수 증가 알림**
     - 방문 수 마일스톤 알림 ON/OFF (10, 50, 100, 500, 1000명)
  6. **공유 알림**
     - 공유 알림 ON/OFF
  7. **영원한 시간 알림**
     - 주간 알림 ON/OFF (매주 일요일)
     - 월간 알림 ON/OFF (매월 1일)
     - 특별한 날 알림 ON/OFF (1주년, 1개월, 100일 등)
  8. **재활성화 알림** (유령 회원용)
     - 재활성화 알림 ON/OFF
  9. **홈 화면 공개 제안 알림**
     - 홈 화면 공개 제안 알림 ON/OFF
  10. **알림 수신 시간**
      - 알림 수신 시작 시간 (기본: 09:00)
      - 알림 수신 종료 시간 (기본: 22:00)
      - 기념일 알림은 시간 제한 없음 (고정 시간 발송)

#### 추모관별 알림 설정 저장
- **저장 위치**: `memorials` 컬렉션의 `notificationSettings` 필드
- **기본값**: 모든 알림 ON (사용자가 직접 끄지 않는 한)
- **설정 변경**: 추모관별로 독립적으로 관리

#### 알림 발송 시 확인 순서
1. **사용자 전체 알림 설정** 확인 (`users.notificationSettings`)
   - 전체 알림이 OFF면 발송하지 않음
   - 알림 수신 시간 확인
2. **추모관별 알림 설정** 확인 (`memorials.notificationSettings`)
   - 해당 추모관의 알림이 OFF면 발송하지 않음
   - 알림 수신 시간 확인
3. **알림 빈도 제한** 확인
   - 같은 추모관 하루 최대 3개
   - 같은 사용자 하루 최대 5개
4. **알림 발송**

### 사용자 전체 알림 설정 (전역 설정)

#### 알림 종류별 ON/OFF
- **전체 알림 ON/OFF**: 모든 알림의 마스터 스위치
- **기념일 알림**: 생일/기일 알림 (전체)
- **댓글 알림**: 추모관 댓글 알림 (전체)
- **기도 알림**: 기도 요청 알림 (전체)
- **홈 화면 공개 제안 알림**: 공개 제안 알림 (전체)
- **재활성화 알림**: 유령 회원 재활성화 알림 (전체)
- **영원한 시간 알림**: 주간/월간 영원한 시간 알림 (전체)

#### 알림 시간 설정
- **알림 수신 시간**: 기본 09:00 ~ 22:00
- **기념일 알림 시간**: 전날 18:00, 당일 09:00 (고정, 변경 불가)

#### 알림 빈도 제한
- **같은 추모관**: 하루 최대 3개
- **같은 사용자**: 하루 최대 5개
- **재활성화 알림**: 주 1회

---

## 📱 알림 클릭 시 화면 이동

### 알림 터치 시 동작

푸시 알림을 터치하면 해당 알림과 관련된 화면으로 자동으로 이동합니다.

#### 알림 타입별 화면 이동 매핑

| 알림 타입 | 이동 화면 | 전달 파라미터 | 비고 |
|---------|---------|------------|------|
| **기념일 알림** | 추모관 상세 화면 | `memorialId` | 생일/기일 알림 클릭 시 |
| **댓글 알림** | 추모관 상세 화면 (댓글 섹션) | `memorialId`, `commentId` | 댓글이 있는 위치로 스크롤 |
| **댓글 답글 알림** | 추모관 상세 화면 (댓글 섹션) | `memorialId`, `commentId` | 답글이 있는 위치로 스크롤 |
| **기도 요청 알림** | 기도 요청 상세 화면 | `prayerId` | 기도 요청 상세 화면으로 이동 |
| **기도 참여 알림** | 기도 요청 상세 화면 | `prayerId` | 기도 요청 상세 화면으로 이동 |
| **추모금 전달 알림** | 추모관 상세 화면 → 추모금 내역 | `memorialId`, `donationId` | 추모금 내역 화면으로 이동 |
| **추모금 수령 완료 알림** | 추모금 내역 화면 | `donationId` | 추모금 내역 화면으로 이동 |
| **방문 수 증가 알림** | 추모관 상세 화면 | `memorialId` | 추모관 상세 화면으로 이동 |
| **공유 알림** | 추모관 상세 화면 | `memorialId` | 추모관 상세 화면으로 이동 |
| **영원한 시간 알림** | 추모관 상세 화면 (영원한 시간 섹션) | `memorialId` | 영원한 시간 섹션으로 스크롤 |
| **재활성화 알림** | 추모관 상세 화면 | `memorialId` | 추모관 상세 화면으로 이동 |
| **홈 화면 공개 제안 알림** | 홈 화면 공개 설정 화면 | `memorialId`, `letterId` | 공개 설정 화면으로 이동 |
| **감정 공유 게시판 알림** | 감정 공유 게시판 상세 화면 | `emotionId` | 감정 공유 글 상세 화면으로 이동 |
| **프리미엄 구독 만료 알림** | 프리미엄 구독 화면 | - | 구독 화면으로 이동 |

### 알림 데이터 구조 (상세)

```javascript
{
  // FCM 알림 데이터
  notification: {
    title: string,    // 알림 제목
    body: string,     // 알림 내용
  },
  data: {
    // 화면 이동 정보
    screen: string,           // 이동할 화면 (예: 'memorialDetail', 'prayerDetail', 'donationHistory')
    type: string,             // 알림 타입 (예: 'anniversary', 'comment', 'donation')
    
    // 화면 이동에 필요한 파라미터
    memorialId: string,       // 추모관 ID (대부분의 알림에 필요)
    commentId: string,         // 댓글 ID (댓글 관련 알림)
    donationId: string,        // 추모금 ID (추모금 관련 알림)
    prayerId: string,          // 기도 요청 ID (기도 관련 알림)
    emotionId: string,         // 감정 공유 글 ID (감정 공유 관련 알림)
    letterId: string,          // 편지 ID (홈 화면 공개 제안 알림)
    
    // 추가 파라미터
    scrollTo: string,         // 스크롤할 섹션 (예: 'comments', 'eternalTime')
    highlightId: string,      // 강조할 항목 ID (예: 댓글 ID)
  }
}
```

### Flutter 앱에서 알림 클릭 처리

#### 1. 알림 클릭 이벤트 수신

```dart
// main.dart 또는 알림 서비스
FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  // 앱이 실행 중일 때 알림 클릭
  _handleNotificationClick(message);
});

// 앱이 종료된 상태에서 알림 클릭
FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
  if (message != null) {
    _handleNotificationClick(message);
  }
});
```

#### 2. 알림 클릭 처리 로직

```dart
void _handleNotificationClick(RemoteMessage message) {
  final data = message.data;
  final screen = data['screen'];
  final type = data['type'];
  
  switch (screen) {
    case 'memorialDetail':
      // 추모관 상세 화면으로 이동
      final memorialId = data['memorialId'];
      final scrollTo = data['scrollTo']; // 'comments', 'eternalTime' 등
      final highlightId = data['highlightId']; // 댓글 ID 등
      
      Navigator.pushNamed(
        context,
        '/memorial/detail',
        arguments: {
          'memorialId': memorialId,
          'scrollTo': scrollTo,
          'highlightId': highlightId,
        },
      );
      break;
      
    case 'prayerDetail':
      // 기도 요청 상세 화면으로 이동
      final prayerId = data['prayerId'];
      Navigator.pushNamed(
        context,
        '/prayer/detail',
        arguments: {'prayerId': prayerId},
      );
      break;
      
    case 'donationHistory':
      // 추모금 내역 화면으로 이동
      final memorialId = data['memorialId'];
      final donationId = data['donationId'];
      Navigator.pushNamed(
        context,
        '/donation/history',
        arguments: {
          'memorialId': memorialId,
          'donationId': donationId,
        },
      );
      break;
      
    case 'emotionDetail':
      // 감정 공유 게시판 상세 화면으로 이동
      final emotionId = data['emotionId'];
      Navigator.pushNamed(
        context,
        '/emotion/detail',
        arguments: {'emotionId': emotionId},
      );
      break;
      
    case 'homePublicSettings':
      // 홈 화면 공개 설정 화면으로 이동
      final memorialId = data['memorialId'];
      final letterId = data['letterId'];
      Navigator.pushNamed(
        context,
        '/memorial/home-public-settings',
        arguments: {
          'memorialId': memorialId,
          'letterId': letterId,
        },
      );
      break;
      
    case 'premium':
      // 프리미엄 구독 화면으로 이동
      Navigator.pushNamed(context, '/premium/subscribe');
      break;
      
    default:
      // 알 수 없는 화면이면 홈 화면으로 이동
      Navigator.pushNamed(context, '/home');
  }
}
```

#### 3. 특정 섹션으로 스크롤

```dart
// 추모관 상세 화면에서 특정 섹션으로 스크롤
class MemorialDetailScreen extends StatefulWidget {
  final String? scrollTo;
  final String? highlightId;
  
  @override
  _MemorialDetailScreenState createState() => _MemorialDetailScreenState();
}

class _MemorialDetailScreenState extends State<MemorialDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    
    // 알림에서 특정 섹션으로 스크롤 요청이 있으면
    if (widget.scrollTo != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToSection(widget.scrollTo!);
      });
    }
  }
  
  void _scrollToSection(String section) {
    double offset = 0;
    
    switch (section) {
      case 'comments':
        // 댓글 섹션 위치 계산
        offset = _calculateCommentsOffset();
        break;
      case 'eternalTime':
        // 영원한 시간 섹션 위치 계산
        offset = _calculateEternalTimeOffset();
        break;
    }
    
    _scrollController.animateTo(
      offset,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    
    // 특정 항목 강조 (예: 댓글)
    if (widget.highlightId != null) {
      _highlightItem(widget.highlightId!);
    }
  }
  
  void _highlightItem(String itemId) {
    // 댓글 강조 애니메이션
    setState(() {
      _highlightedCommentId = itemId;
    });
    
    // 3초 후 강조 해제
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _highlightedCommentId = null;
      });
    });
  }
}
```

### Cloud Functions에서 알림 데이터 설정

#### 기념일 알림 예시

```javascript
await sendNotification(creatorData.pushToken, {
  title: `오늘은 ${memorial.deceasedName}님의 생일입니다`,
  body: `생일을 축하하며 ${memorial.deceasedName}님을 기억합니다.`,
  data: {
    screen: 'memorialDetail',
    type: 'anniversary',
    memorialId: memorialDoc.id,
  }
});
```

#### 댓글 알림 예시

```javascript
await sendNotification(creator.pushToken, {
  title: `${comment.userName}님이 ${memorial.deceasedName}님의 추모관에 위로 메시지를 남겼습니다.`,
  body: comment.content.substring(0, 50),
  data: {
    screen: 'memorialDetail',
    type: 'comment',
    memorialId: memorialId,
    commentId: context.params.commentId,
    scrollTo: 'comments',
    highlightId: context.params.commentId,
  }
});
```

#### 추모금 전달 알림 예시

```javascript
await sendNotification(creator.pushToken, {
  title: `${donation.donorName}님이 ${memorial.deceasedName}님의 추모관에 추모금을 전달했습니다.`,
  body: `추모금: ₩${donation.amount.toLocaleString()}`,
  data: {
    screen: 'donationHistory',
    type: 'donation',
    memorialId: memorialId,
    donationId: context.params.donationId,
  }
});
```

#### 영원한 시간 알림 예시

```javascript
await sendNotification(creator.pushToken, {
  title: `${memorial.deceasedName}님의 새로운 삶의 시간이 계속 흐르고 있습니다.`,
  body: `새로운 삶의 시간: ${years}년 ${months}개월 ${days}일`,
  data: {
    screen: 'memorialDetail',
    type: 'eternalTime',
    memorialId: memorialDoc.id,
    scrollTo: 'eternalTime',
  }
});
```

### Deep Linking 지원

알림 클릭 시 Deep Linking을 통해 앱이 종료된 상태에서도 올바른 화면으로 이동할 수 있습니다.

#### Deep Link URL 형식

```
memorialapp://memorial/detail?memorialId={memorialId}&scrollTo={scrollTo}&highlightId={highlightId}
memorialapp://prayer/detail?prayerId={prayerId}
memorialapp://donation/history?memorialId={memorialId}&donationId={donationId}
```

#### Flutter Deep Linking 설정

```dart
// pubspec.yaml
dependencies:
  uni_links: ^0.5.1

// main.dart
import 'package:uni_links/uni_links.dart';

void initUniLinks() {
  getInitialLink().then((String? initialLink) {
    if (initialLink != null) {
      _handleDeepLink(initialLink);
    }
  });
  
  linkStream.listen((String? link) {
    if (link != null) {
      _handleDeepLink(link);
    }
  });
}

void _handleDeepLink(String link) {
  final uri = Uri.parse(link);
  final path = uri.path;
  final queryParams = uri.queryParameters;
  
  switch (path) {
    case '/memorial/detail':
      Navigator.pushNamed(
        context,
        '/memorial/detail',
        arguments: {
          'memorialId': queryParams['memorialId'],
          'scrollTo': queryParams['scrollTo'],
          'highlightId': queryParams['highlightId'],
        },
      );
      break;
    // ... 기타 경로 처리
  }
}
```

---

## 📊 알림 효과 측정

### 지표
1. **알림 열람률**: 알림 클릭률
2. **앱 재방문률**: 알림 클릭 후 앱 방문률
3. **활동 증가율**: 알림 후 활동 증가율
4. **유령 회원 재활성화율**: 장기 미접속 사용자의 재방문율

### A/B 테스트
- **메시지 톤**: 따뜻한 톤 vs 간결한 톤
- **발송 시간**: 오전 9시 vs 오전 10시
- **알림 빈도**: 주 1회 vs 주 2회

---

## 🔐 알림 데이터 구조

### memorials 컬렉션에 추가할 필드 (추모관별 알림 설정)

```javascript
{
  notificationSettings: {
    // 추모관별 알림 설정
    anniversaryAlerts: boolean,        // 기념일 알림 (생일/기일)
    commentAlerts: boolean,           // 댓글 알림
    prayerAlerts: boolean,            // 기도 요청 알림
    donationAlerts: boolean,         // 추모금 전달 알림
    visitMilestoneAlerts: boolean,     // 방문 수 증가 알림 (10, 50, 100, 500, 1000명)
    shareAlerts: boolean,             // 공유 알림
    eternalTimeAlerts: boolean,       // 영원한 시간 알림 (주간/월간/특별한 날)
    reengagementAlerts: boolean,       // 재활성화 알림 (유령 회원용)
    homePublicAlerts: boolean,        // 홈 화면 공개 제안 알림
    notificationTimeStart: string,    // 알림 수신 시작 시간 (예: "09:00")
    notificationTimeEnd: string      // 알림 수신 종료 시간 (예: "22:00")
  }
}
```

### users 컬렉션에 추가할 필드 (전역 알림 설정)

```javascript
{
  notificationSettings: {
    // 사용자 전체 알림 설정 (마스터 스위치)
    allAlertsEnabled: boolean,        // 전체 알림 ON/OFF (마스터 스위치)
    anniversaryAlerts: boolean,        // 기념일 알림 (전체)
    commentAlerts: boolean,           // 댓글 알림 (전체)
    prayerAlerts: boolean,            // 기도 알림 (전체)
    homePublicAlerts: boolean,        // 홈 화면 공개 제안 알림 (전체)
    reengagementAlerts: boolean,       // 재활성화 알림 (전체)
    eternalTimeAlerts: boolean,      // 영원한 시간 알림 (전체)
    notificationTimeStart: string,   // 알림 수신 시작 시간 (예: "09:00")
    notificationTimeEnd: string,     // 알림 수신 종료 시간 (예: "22:00")
    lastNotificationSentAt: timestamp, // 마지막 알림 발송 일시
    dailyNotificationCount: number,   // 일일 알림 발송 횟수
    lastActiveAt: timestamp           // 마지막 활동 일시 (재활성화 판단용)
  }
}
```

### notifications 컬렉션 (선택)

```javascript
{
  notificationId: string,              // 알림 고유 ID
  userId: string,                      // 수신자 ID
  type: string,                        // 알림 타입
  title: string,                       // 알림 제목
  body: string,                        // 알림 내용
  data: {
    screen: string,                    // 이동할 화면 (예: 'memorialDetail', 'comment', 'donation')
    memorialId: string,                // 추모관 ID (선택)
    commentId: string,                 // 댓글 ID (선택)
    donationId: string,                // 추모금 ID (선택)
    prayerId: string,                  // 기도 요청 ID (선택)
    emotionId: string,                 // 감정 공유 글 ID (선택)
    // 기타 화면 이동에 필요한 파라미터
  },
  isRead: boolean,                     // 읽음 여부
  sentAt: timestamp,                   // 발송 일시
  readAt: timestamp,                   // 읽은 일시
}
```

---

## 🚀 구현 방법

### Cloud Functions

#### 기념일 알림 스케줄링
```javascript
// functions/index.js
const functions = require('firebase-functions');
const admin = require('firebase-admin');

// 매일 오전 9시에 실행
exports.checkAnniversaries = functions.pubsub
  .schedule('0 9 * * *')
  .timeZone('Asia/Seoul')
  .onRun(async (context) => {
    // 오늘 생일/기일인 추모관 찾기
    const today = new Date();
    const memorials = await admin.firestore()
      .collection('memorials')
      .where('anniversary.birthday', '==', today)
      .or(where('anniversary.memorialDay', '==', today))
      .get();
    
    for (const memorialDoc of memorials.docs) {
      const memorial = memorialDoc.data();
      const creator = await admin.firestore()
        .collection('users')
        .doc(memorial.creatorId)
        .get();
      const creatorData = creator.data();
      
      // 1. 사용자 전체 알림 설정 확인
      if (!creatorData.notificationSettings?.anniversaryAlerts) {
        continue; // 사용자 전체 알림이 OFF면 스킵
      }
      
      // 2. 추모관별 알림 설정 확인
      if (!memorial.notificationSettings?.anniversaryAlerts) {
        continue; // 추모관별 알림이 OFF면 스킵
      }
      
      // 3. 알림 발송
      await sendNotification(creatorData.pushToken, {
        title: `오늘은 ${memorial.deceasedName}님의 생일입니다`,
        body: `생일을 축하하며 ${memorial.deceasedName}님을 기억합니다.`,
        data: {
          screen: 'memorialDetail',
          type: 'anniversary',
          memorialId: memorialDoc.id,
        }
      });
    }
  });

// 매일 오후 6시에 실행 (기념일 전날)
exports.checkAnniversariesTomorrow = functions.pubsub
  .schedule('0 18 * * *')
  .timeZone('Asia/Seoul')
  .onRun(async (context) => {
    // 내일 생일/기일인 추모관 찾기
    // 푸시 알림 발송
  });
```

#### 재활성화 알림 스케줄링
```javascript
// 매일 오전 10시에 실행
exports.sendReengagementNotifications = functions.pubsub
  .schedule('0 10 * * *')
  .timeZone('Asia/Seoul')
  .onRun(async (context) => {
    // 7일 이상 미접속 사용자 찾기
    // 활동이 있는 추모관 확인
    // 푸시 알림 발송
  });
```

#### 영원한 시간 알림 스케줄링
```javascript
// 매주 일요일 오전 9시에 실행
exports.sendEternalTimeWeekly = functions.pubsub
  .schedule('0 9 * * 0')
  .timeZone('Asia/Seoul')
  .onRun(async (context) => {
    // 모든 추모관의 영원한 시간 계산
    // 푸시 알림 발송
  });

// 매월 1일 오전 9시에 실행
exports.sendEternalTimeMonthly = functions.pubsub
  .schedule('0 9 1 * *')
  .timeZone('Asia/Seoul')
  .onRun(async (context) => {
    // 모든 추모관의 영원한 시간 계산
    // 푸시 알림 발송
  });
```

### Firestore 트리거

#### 댓글 작성 시 알림
```javascript
exports.onCommentCreated = functions.firestore
  .document('comments/{commentId}')
  .onCreate(async (snap, context) => {
    const comment = snap.data();
    const memorialId = comment.memorialId;
    
    // 추모관 정보 가져오기
    const memorialDoc = await admin.firestore()
      .collection('memorials')
      .doc(memorialId)
      .get();
    const memorial = memorialDoc.data();
    
    // 추모관 생성자 정보 가져오기
    const creatorDoc = await admin.firestore()
      .collection('users')
      .doc(memorial.creatorId)
      .get();
    const creator = creatorDoc.data();
    
    // 1. 사용자 전체 알림 설정 확인
    if (!creator.notificationSettings?.commentAlerts) {
      return; // 사용자 전체 알림이 OFF면 발송하지 않음
    }
    
    // 2. 추모관별 알림 설정 확인
    if (!memorial.notificationSettings?.commentAlerts) {
      return; // 추모관별 알림이 OFF면 발송하지 않음
    }
    
    // 3. 알림 수신 시간 확인
    const now = new Date();
    const currentHour = now.getHours();
    const startHour = parseInt(creator.notificationSettings.notificationTimeStart?.split(':')[0] || '9');
    const endHour = parseInt(creator.notificationSettings.notificationTimeEnd?.split(':')[0] || '22');
    
    if (currentHour < startHour || currentHour >= endHour) {
      return; // 알림 수신 시간이 아니면 발송하지 않음
    }
    
    // 4. 알림 빈도 제한 확인
    const today = new Date().toDateString();
    const lastSent = creator.notificationSettings.lastNotificationSentAt?.toDate();
    if (lastSent && lastSent.toDateString() === today) {
      if (creator.notificationSettings.dailyNotificationCount >= 5) {
        return; // 일일 알림 발송 횟수 제한
      }
    }
    
    // 5. 푸시 알림 발송
    await sendNotification(creator.pushToken, {
      title: `${comment.userName}님이 ${memorial.deceasedName}님의 추모관에 위로 메시지를 남겼습니다.`,
      body: comment.content.substring(0, 50),
      data: {
        screen: 'memorialDetail',
        type: 'comment',
        memorialId: memorialId,
        commentId: context.params.commentId,
        scrollTo: 'comments',
        highlightId: context.params.commentId,
      }
    });
    
    // 6. 알림 발송 기록 업데이트
    await admin.firestore()
      .collection('users')
      .doc(memorial.creatorId)
      .update({
        'notificationSettings.lastNotificationSentAt': admin.firestore.FieldValue.serverTimestamp(),
        'notificationSettings.dailyNotificationCount': admin.firestore.FieldValue.increment(1)
      });
  });
```

#### 추모금 전달 시 알림
```javascript
exports.onDonationCreated = functions.firestore
  .document('donations/{donationId}')
  .onCreate(async (snap, context) => {
    const donation = snap.data();
    const memorialId = donation.memorialId;
    
    // 추모관 정보 가져오기
    const memorialDoc = await admin.firestore()
      .collection('memorials')
      .doc(memorialId)
      .get();
    const memorial = memorialDoc.data();
    
    // 추모관 생성자(수령자) 정보 가져오기
    const creatorDoc = await admin.firestore()
      .collection('users')
      .doc(memorial.creatorId)
      .get();
    const creator = creatorDoc.data();
    
    // 1. 사용자 전체 알림 설정 확인
    if (!creator.notificationSettings?.allAlertsEnabled) {
      return; // 사용자 전체 알림이 OFF면 발송하지 않음
    }
    
    // 2. 추모관별 알림 설정 확인
    if (!memorial.notificationSettings?.donationAlerts) {
      return; // 추모관별 알림이 OFF면 발송하지 않음
    }
    
    // 3. 푸시 알림 발송 (추모금은 즉시 발송)
    await sendNotification(creator.pushToken, {
      title: `${donation.donorName}님이 ${memorial.deceasedName}님의 추모관에 추모금을 전달했습니다.`,
      body: `추모금: ₩${donation.amount.toLocaleString()}`,
      data: {
        screen: 'donationHistory',
        type: 'donation',
        memorialId: memorialId,
        donationId: context.params.donationId,
      }
    });
  });
```

---

## 📋 알림 발송 체크리스트

### 발송 전 확인사항
- [ ] 사용자 전체 알림 설정 확인 (ON/OFF) - `users.notificationSettings.allAlertsEnabled`
- [ ] 사용자 알림 종류별 설정 확인 (ON/OFF) - `users.notificationSettings.[type]Alerts`
- [ ] 추모관별 알림 설정 확인 (ON/OFF) - `memorials.notificationSettings.[type]Alerts`
- [ ] 알림 수신 시간 확인 (09:00 ~ 22:00) - 기념일 알림 제외
- [ ] 일일 알림 발송 횟수 확인 (최대 5개)
- [ ] 같은 추모관 알림 빈도 확인 (하루 최대 3개)
- [ ] 푸시 토큰 유효성 확인
- [ ] 알림 내용 검토 (톤앤매너, 오타)

### 발송 후 확인사항
- [ ] 알림 발송 성공 여부 확인
- [ ] 알림 열람률 확인
- [ ] 앱 재방문률 확인
- [ ] 사용자 피드백 수집

---

## 🎯 우선순위별 구현 계획

### Phase 1: 필수 알림 (즉시 구현)
1. 기념일 알림 (생일/기일)
2. 댓글 알림
3. 추모금 전달 알림
4. 홈 화면 공개 제안 알림

### Phase 2: 주요 알림 (1주차)
5. 기도 요청 알림
6. 감정 공유 게시판 알림
7. 추모금 수령 완료 알림

### Phase 3: 재활성화 알림 (2주차)
8. 장기 미접속 유도 알림 (7일, 14일, 30일, 90일)
9. 기념일 기반 재활성화 알림
10. 활동 기반 재활성화 알림

### Phase 4: 기억 알림 (3주차)
11. 영원한 시간 알림 (주간/월간)
12. 특별한 날 기억 알림 (1주년, 1개월 등)

### Phase 5: 프리미엄 알림 (4주차)
13. 프리미엄 구독 만료 알림

---

## 📝 참고사항

### 알림 발송 제한
- **같은 사용자**: 하루 최대 5개
- **같은 추모관**: 하루 최대 3개
- **재활성화 알림**: 주 1회
- **알림 수신 시간**: 09:00 ~ 22:00 (기념일 제외)

### 알림 메시지 원칙
- **따뜻하고 위로하는 톤**: 추모 앱의 특성상 따뜻한 메시지
- **자연스러운 유도**: 활동 유도는 자연스럽게
- **개인화**: 고인 이름, 사용자 이름 등 개인화된 메시지

### 알림 효과 측정
- **알림 열람률**: 알림 클릭률 추적
- **앱 재방문률**: 알림 클릭 후 앱 방문률
- **활동 증가율**: 알림 후 활동 증가율
- **유령 회원 재활성화율**: 장기 미접속 사용자의 재방문율

