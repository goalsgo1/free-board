# 🗄️ 데이터베이스 구조 및 데이터 모델

## 📊 Firestore 컬렉션 구조

### 1. users (사용자)

```javascript
{
  userId: string,              // 사용자 고유 ID (Firebase Auth UID)
  email: string,               // 이메일
  displayName: string,         // 표시 이름
  createdAt: timestamp,        // 가입 일시
  updatedAt: timestamp,         // 수정 일시
  isPremium: boolean,          // 프리미엄 구독 여부
  premiumExpiresAt: timestamp, // 프리미엄 만료 일시
  pushToken: string,           // 푸시 알림 토큰
  lastActiveAt: timestamp,    // 마지막 활동 일시 (재활성화 판단용)
  lastNotificationSentAt: timestamp, // 마지막 알림 발송 일시
  dailyNotificationCount: number, // 일일 알림 발송 횟수
  notificationSettings: {
    anniversaryAlerts: boolean, // 기념일 알림
    commentAlerts: boolean,    // 댓글 알림
    prayerAlerts: boolean,     // 기도 알림
    homePublicAlerts: boolean, // 홈 화면 공개 제안 알림
    reengagementAlerts: boolean, // 재활성화 알림
    eternalTimeAlerts: boolean, // 영원한 시간 알림 (주간/월간)
    notificationTimeStart: string, // 알림 수신 시작 시간 (예: "09:00")
    notificationTimeEnd: string    // 알림 수신 종료 시간 (예: "22:00")
  }
}
```

### 2. memorials (추모관)

```javascript
{
  memorialId: string,          // 추모관 고유 ID
  creatorId: string,           // 생성자 ID (users.userId) - AI 생성 시 'system' 또는 null
  memorialType: 'human' | 'pet', // 추모 대상 타입 (사람/애완동물)
  deceasedName: string,        // 고인 이름
  lifeSummary: string,         // 생애 요약
  isAIGenerated: boolean,      // AI 생성 데이터 여부 (초기 데이터 식별용)
  aiGeneratedAt: timestamp,    // AI 생성 일시 (isAIGenerated가 true일 때)
  photos: [                   // 사진 배열 (최대 5장, 프리미엄: 무제한)
    {
      url: string,             // 이미지 URL
      order: number,           // 순서
      uploadedAt: timestamp
    }
  ],
  video: {
    type: 'youtube' | 'upload', // 동영상 타입
    url: string,               // YouTube 링크 또는 업로드 URL
    thumbnail: string          // 썸네일 URL
  },
  letter: {
    type: 'text' | 'audio',    // 편지 타입
    content: string,          // 텍스트 내용 또는 오디오 URL
    isHomePublic: boolean,    // 홈 화면 공개 여부
    homePublicRequested: boolean, // 홈 화면 공개 제안 알림 발송 여부
    homePublicRequestedAt: timestamp, // 홈 화면 공개 제안 알림 발송 일시
    likeCount: number,        // 좋아요 수 (댓글 수와 합산하여 공개 제안 기준)
    isAIGenerated: boolean,   // AI 생성 편지 여부 (초기 데이터 식별용)
    createdAt: timestamp
  },
  anniversary: {
    birthday: date,           // 생일
    memorialDay: date          // 기일 (고인이 돌아가신 날)
  },
  eternalTime: {
    startDate: timestamp,     // 영원한 시간 시작일 (memorialDay와 동일)
    enabled: boolean,         // 영원한 시간 표시 활성화 여부
    lastUpdated: timestamp    // 마지막 업데이트 일시 (실시간 계산용)
  },
  notificationSettings: {
    // 추모관별 알림 설정
    anniversaryAlerts: boolean,        // 기념일 알림 (생일/기일)
    commentAlerts: boolean,           // 댓글 알림
    prayerAlerts: boolean,            // 기도 요청 알림
    donationAlerts: boolean,          // 추모금 전달 알림
    visitMilestoneAlerts: boolean,    // 방문 수 증가 알림 (10, 50, 100, 500, 1000명)
    shareAlerts: boolean,             // 공유 알림
    eternalTimeAlerts: boolean,       // 영원한 시간 알림 (주간/월간/특별한 날)
    reengagementAlerts: boolean,      // 재활성화 알림 (유령 회원용)
    homePublicAlerts: boolean,       // 홈 화면 공개 제안 알림
    notificationTimeStart: string,   // 알림 수신 시작 시간 (예: "09:00")
    notificationTimeEnd: string       // 알림 수신 종료 시간 (예: "22:00")
  },
  isPublic: boolean,          // 공개/비공개
  visitCount: number,         // 방문 횟수
  lastVisitedAt: timestamp,  // 마지막 방문 일시
  shareCount: number,        // 공유 횟수
  shareVisitCount: number,   // 공유를 통해 방문한 사람 수
  commentCount: number,       // 댓글 수 (통계용)
  donationCount: number,      // 추모금 전달 횟수 (통계용)
  totalDonationAmount: number, // 총 추모금 수령액 (통계용)
  createdAt: timestamp,       // 생성 일시
  updatedAt: timestamp,       // 수정 일시
  deletedAt: timestamp       // 삭제 일시 (소프트 삭제)
}
```

### 3. comments (댓글)

```javascript
{
  commentId: string,          // 댓글 고유 ID
  memorialId: string,         // 추모관 ID
  userId: string,             // 작성자 ID (AI 생성 시 'system' 또는 null)
  userName: string,           // 작성자 이름
  content: string,            // 댓글 내용
  isAIGenerated: boolean,    // AI 생성 댓글 여부 (초기 데이터 식별용)
  aiGeneratedAt: timestamp,  // AI 생성 일시 (isAIGenerated가 true일 때)
  createdAt: timestamp,       // 작성 일시
  updatedAt: timestamp,       // 수정 일시
  deletedAt: timestamp        // 삭제 일시 (소프트 삭제)
}
```

### 4. prayers (기도 요청)

```javascript
{
  prayerId: string,           // 기도 요청 고유 ID
  memorialId: string,         // 추모관 ID (선택)
  userId: string,             // 작성자 ID (AI 생성 시 'system' 또는 null)
  userName: string,           // 작성자 이름
  title: string,              // 제목
  content: string,            // 내용
  prayerCount: number,        // 함께 기도 카운트
  participants: [string],    // 참여자 ID 배열
  isAIGenerated: boolean,    // AI 생성 기도 요청 여부 (초기 데이터 식별용)
  aiGeneratedAt: timestamp,  // AI 생성 일시 (isAIGenerated가 true일 때)
  createdAt: timestamp,       // 작성 일시
  updatedAt: timestamp        // 수정 일시
}
```

### 5. prayerParticipants (기도 참여자)

```javascript
{
  prayerId: string,           // 기도 요청 ID
  userId: string,             // 참여자 ID
  participatedAt: timestamp  // 참여 일시
}
```

### 6. donations (추모금)

```javascript
{
  donationId: string,        // 추모금 고유 ID
  memorialId: string,         // 추모관 ID
  donorId: string,           // 기부자 ID
  donorName: string,          // 기부자 이름
  amount: number,            // 전달 금액
  fee: number,               // 수수료 (5%)
  maintenanceFee: number,     // 유지비 (₩1,900)
  netAmount: number,         // 수령액 (amount - fee - maintenanceFee)
  paymentMethod: string,      // 결제 수단
  paymentStatus: 'pending' | 'completed' | 'failed', // 결제 상태
  recipientId: string,       // 수령자 ID (memorials.creatorId)
  withdrawnAt: timestamp,    // 출금 일시
  createdAt: timestamp,       // 생성 일시
  completedAt: timestamp      // 완료 일시
}
```

### 7. emotions (감정 공유 게시판)

```javascript
{
  emotionId: string,         // 글 고유 ID
  userId: string,             // 작성자 ID (AI 생성 시 'system' 또는 null)
  userName: string,           // 작성자 이름
  title: string,             // 제목
  content: string,           // 내용
  likeCount: number,         // 좋아요 수
  commentCount: number,      // 댓글 수
  category: 'grief' | 'memory' | 'comfort', // 카테고리
  isAIGenerated: boolean,   // AI 생성 글 여부 (초기 데이터 식별용)
  aiGeneratedAt: timestamp,  // AI 생성 일시 (isAIGenerated가 true일 때)
  createdAt: timestamp,       // 작성 일시
  updatedAt: timestamp,       // 수정 일시
  deletedAt: timestamp        // 삭제 일시 (소프트 삭제)
}
```

### 8. emotionLikes (감정 글 좋아요)

```javascript
{
  emotionId: string,        // 글 ID
  userId: string,           // 좋아요한 사용자 ID
  likedAt: timestamp        // 좋아요 일시
}
```

### 9. emotionComments (감정 글 댓글)

```javascript
{
  commentId: string,         // 댓글 고유 ID
  emotionId: string,        // 글 ID
  userId: string,           // 작성자 ID
  userName: string,         // 작성자 이름
  content: string,          // 댓글 내용
  createdAt: timestamp,      // 작성 일시
  updatedAt: timestamp,      // 수정 일시
  deletedAt: timestamp       // 삭제 일시 (소프트 삭제)
}
```

### 10. regretLetters (후회 없는 편지)

```javascript
{
  letterId: string,          // 편지 고유 ID
  userId: string,            // 작성자 ID (익명 공개 시에도 저장하되 표시하지 않음)
  userName: string,          // 작성자 이름 (익명 공개 시 "익명"으로 표시)
  isAnonymous: boolean,      // 익명 공개 여부
  title: string,             // 편지 제목 (선택)
  content: string,           // 편지 내용
  category: 'family' | 'friend' | 'lover' | 'work' | 'faith', // 관계 유형
  visibility: 'public' | 'anonymous' | 'private', // 공개 여부
  linkedMemorialId: string,  // 연결된 추모관 ID (선택)
  likeCount: number,         // 공감 수
  commentCount: number,      // 댓글 수
  viewCount: number,         // 조회 수
  isAIGenerated: boolean,    // AI 생성 편지 여부 (초기 데이터 식별용)
  aiGeneratedAt: timestamp,  // AI 생성 일시 (isAIGenerated가 true일 때)
  createdAt: timestamp,      // 작성 일시
  updatedAt: timestamp,      // 수정 일시
  deletedAt: timestamp       // 삭제 일시 (소프트 삭제)
}
```

### 11. regretLetterLikes (후회 없는 편지 공감)

```javascript
{
  letterId: string,          // 편지 ID
  userId: string,           // 공감한 사용자 ID
  likedAt: timestamp        // 공감 일시
}
```

### 12. regretLetterComments (후회 없는 편지 댓글)

```javascript
{
  commentId: string,         // 댓글 고유 ID
  letterId: string,         // 편지 ID
  userId: string,           // 작성자 ID
  userName: string,         // 작성자 이름
  content: string,          // 댓글 내용
  isAIGenerated: boolean,   // AI 생성 댓글 여부 (초기 데이터 식별용)
  aiGeneratedAt: timestamp,  // AI 생성 일시
  createdAt: timestamp,      // 작성 일시
  updatedAt: timestamp,      // 수정 일시
  deletedAt: timestamp       // 삭제 일시 (소프트 삭제)
}
```

### 13. aiMemories (AI 기억 분석)

```javascript
{
  memoryId: string,          // 분석 고유 ID
  memorialId: string,        // 추모관 ID
  userId: string,            // 사용자 ID
  conversations: [           // 업로드된 대화 목록
    {
      type: 'image' | 'text', // 대화 타입
      content: string,        // 이미지 URL 또는 텍스트 내용
      uploadedAt: timestamp
    }
  ],
  analysisResult: {
    tone: string,            // 말투 (존댓말/반말 등)
    relationship: string,    // 관계 유형 (가족/연인/친구 등)
    emotionKeywords: [string], // 감정 키워드 배열
    conversationPattern: {   // 대화 패턴
      structure: string,     // 질문/응답 구조
      humor: boolean,        // 유머 사용 여부
      nickname: string       // 애칭
    },
    commonPhrases: [string]  // 자주 쓰는 표현
  },
  analyzedAt: timestamp,     // 분석 완료 일시
  createdAt: timestamp       // 생성 일시
}
```

### 14. aiReplies (AI 답장)

```javascript
{
  replyId: string,           // 답장 고유 ID
  memorialId: string,        // 추모관 ID
  memoryId: string,          // AI 기억 분석 ID
  userId: string,            // 사용자 ID
  userMessage: string,       // 사용자가 입력한 메시지
  aiReply: string,           // AI가 생성한 답장
  audioUrl: string,          // 음성 변환 파일 URL (선택)
  isSaved: boolean,          // 저장 여부
  createdAt: timestamp,      // 생성 일시
  savedAt: timestamp         // 저장 일시
}
```

### 15. wills (유언장)

```javascript
{
  willId: string,            // 유언 고유 ID
  userId: string,            // 작성자 ID
  userName: string,          // 작성자 이름 (익명 작성 시 "익명")
  isAnonymous: boolean,      // 익명 작성 여부
  category: 'family' | 'friend' | 'estate' | 'farewell' | 'special', // 카테고리
  title: string,             // 유언 제목 (선택)
  content: string,           // 유언 내용
  visibility: 'public' | 'private', // 공개 여부
  likeCount: number,         // 공감 수
  commentCount: number,      // 댓글 수
  viewCount: number,         // 조회 수
  isTemplate: boolean,       // 템플릿 여부 (시스템 제공 템플릿)
  createdAt: timestamp,      // 작성 일시
  updatedAt: timestamp,      // 수정 일시
  deletedAt: timestamp       // 삭제 일시 (소프트 삭제)
}
```

### 16. willLikes (유언 공감)

```javascript
{
  willId: string,           // 유언 ID
  userId: string,           // 공감한 사용자 ID
  likedAt: timestamp        // 공감 일시
}
```

### 17. willComments (유언 댓글)

```javascript
{
  commentId: string,         // 댓글 고유 ID
  willId: string,           // 유언 ID
  userId: string,           // 작성자 ID
  userName: string,         // 작성자 이름
  content: string,          // 댓글 내용
  createdAt: timestamp,      // 작성 일시
  updatedAt: timestamp,      // 수정 일시
  deletedAt: timestamp       // 삭제 일시 (소프트 삭제)
}
```

### 18. matchingProfiles (매칭 프로필)

```javascript
{
  profileId: string,          // 프로필 고유 ID
  userId: string,            // 사용자 ID
  type: 'seeking' | 'offering', // 구인(seeking) 또는 구직(offering)
  lostRelationship: 'mother' | 'father' | 'daughter' | 'son' | 'friend' | 'sibling', // 상실한 관계
  seekingRelationship: 'mother' | 'father' | 'daughter' | 'son' | 'friend' | 'sibling', // 찾는 관계
  displayName: string,        // 표시 이름 (익명 가능)
  ageRange: string,          // 나이대 (예: "30-40대")
  region: string,            // 지역 (선택)
  introduction: string,      // 자기소개
  profileImageUrl: string,   // 프로필 사진 URL (선택)
  isAnonymous: boolean,      // 익명 여부
  isVerified: boolean,       // 검증 여부 (실명 인증 또는 추모관 연동)
  matchingConditions: {     // 매칭 조건
    preferredAgeRange: string, // 선호 나이대
    preferredRegion: string,   // 선호 지역 (선택)
    personalityType: string,   // 성격 유형 (선택)
    lossPeriod: string,        // 상실 경과 시간 (선택)
  },
  status: 'active' | 'paused' | 'matched' | 'closed', // 프로필 상태
  createdAt: timestamp,      // 등록 일시
  updatedAt: timestamp,      // 수정 일시
  deletedAt: timestamp       // 삭제 일시 (소프트 삭제)
}
```

### 19. matchingRequests (매칭 신청)

```javascript
{
  requestId: string,          // 신청 고유 ID
  senderProfileId: string,   // 신청자 프로필 ID
  receiverProfileId: string, // 수신자 프로필 ID
  message: string,           // 신청 메시지
  status: 'pending' | 'accepted' | 'rejected' | 'cancelled', // 신청 상태
  createdAt: timestamp,      // 신청 일시
  respondedAt: timestamp,    // 응답 일시
}
```

### 20. matchings (매칭 관계)

```javascript
{
  matchingId: string,         // 매칭 고유 ID
  profileId1: string,        // 프로필 1 ID
  profileId2: string,        // 프로필 2 ID
  requestId: string,         // 매칭 신청 ID
  status: 'active' | 'ended', // 매칭 상태
  matchedAt: timestamp,      // 매칭 성사 일시
  endedAt: timestamp,        // 매칭 종료 일시 (선택)
}
```

### 21. matchingChats (매칭 채팅)

```javascript
{
  chatId: string,            // 채팅 고유 ID
  matchingId: string,        // 매칭 ID
  senderId: string,          // 발신자 ID
  message: string,           // 메시지 내용
  createdAt: timestamp,      // 발신 일시
  isRead: boolean,           // 읽음 여부
}
```

### 22. matchingReports (매칭 신고)

```javascript
{
  reportId: string,          // 신고 고유 ID
  reporterId: string,        // 신고자 ID
  reportedProfileId: string, // 신고된 프로필 ID
  reportedUserId: string,    // 신고된 사용자 ID
  reason: string,            // 신고 사유
  description: string,       // 신고 상세 내용
  status: 'pending' | 'processed' | 'rejected', // 신고 처리 상태
  createdAt: timestamp,      // 신고 일시
}
```

### 23. gratitudeBenefits (감사 혜택)

```javascript
{
  benefitId: string,          // 감사 혜택 고유 ID
  title: string,            // 감사 혜택 제목
  description: string,      // 감사 혜택 설명
  bannerImageUrl: string,   // 배너 이미지 URL
  type: 'signup' | 'activity' | 'special' | 'coupon', // 감사 혜택 유형
  startDate: timestamp,     // 시작 일시
  endDate: timestamp,       // 종료 일시
  isActive: boolean,        // 활성화 여부
  conditions: {            // 참여 조건
    minSignupOrder: number,  // 최소 가입 순위 (예: 1000명 이내)
    minEmpathyCount: number, // 최소 공감 수
    minMemorialCount: number, // 최소 추모관 수
    requireFirstMemorial: boolean, // 첫 추모관 생성 필수
    minDonationCount: number, // 최소 추모금 전달 횟수
    minLoginDays: number,     // 최소 로그인 일수
    requireReview: boolean,   // 리뷰 작성 필수
  },
  rewards: {               // 혜택
    premiumMonths: number,  // 프리미엄 무료 개월 수
    premiumDays: number,    // 프리미엄 무료 일수
    discountPercent: number, // 할인율 (%)
    itemIds: string[],      // 무료 제공 아이템 ID 목록
  },
  maxParticipants: number, // 최대 참여자 수 (null: 제한 없음)
  currentParticipants: number, // 현재 참여자 수
  isAutomatic: boolean,    // 자동 지급 여부
  createdAt: timestamp,    // 생성 일시
  updatedAt: timestamp,    // 수정 일시
}
```

### 24. benefitParticipants (감사 혜택 참여자)

```javascript
{
  participantId: string,   // 참여자 고유 ID
  benefitId: string,         // 감사 혜택 ID
  userId: string,          // 사용자 ID
  participatedAt: timestamp, // 참여 일시
  rewardReceived: boolean, // 혜택 수령 여부
  rewardReceivedAt: timestamp, // 혜택 수령 일시
  rewardType: string,      // 혜택 유형 (premium, coupon, item)
  rewardData: object,      // 혜택 상세 데이터
}
```

### 25. userRewards (사용자 혜택)

```javascript
{
  rewardId: string,        // 혜택 고유 ID
  userId: string,          // 사용자 ID
  type: 'premium' | 'coupon' | 'item', // 혜택 유형
  source: 'gratitude' | 'manual' | 'promotion', // 혜택 출처
  sourceId: string,        // 출처 ID (benefitId 등)
  premiumMonths: number,   // 프리미엄 무료 개월 수
  premiumDays: number,     // 프리미엄 무료 일수
  startDate: timestamp,    // 시작 일시
  endDate: timestamp,      // 종료 일시
  isUsed: boolean,         // 사용 여부
  usedAt: timestamp,       // 사용 일시
  couponCode: string,      // 쿠폰 코드 (쿠폰인 경우)
  discountPercent: number, // 할인율 (%)
  itemIds: string[],       // 무료 제공 아이템 ID 목록
  createdAt: timestamp,    // 생성 일시
}
```

### 26. visits (방문 기록)

```javascript
{
  visitId: string,          // 방문 기록 고유 ID
  memorialId: string,       // 추모관 ID
  userId: string,          // 방문자 ID (익명: null)
  visitedAt: timestamp,     // 방문 일시
  date: string             // 방문 날짜 (YYYY-MM-DD, 중복 방문 체크용)
}
```

### 11. subscriptions (구독)

```javascript
{
  subscriptionId: string,   // 구독 고유 ID
  userId: string,          // 사용자 ID
  plan: 'monthly' | 'yearly', // 구독 플랜
  amount: number,          // 구독 금액
  startDate: timestamp,    // 시작 일시
  endDate: timestamp,      // 만료 일시
  status: 'active' | 'expired' | 'cancelled', // 상태
  paymentMethod: string,    // 결제 수단
  createdAt: timestamp      // 생성 일시
}
```

### 12. items (디지털 헌화 아이템)

```javascript
{
  itemId: string,          // 아이템 고유 ID
  name: string,           // 아이템 이름
  type: 'flower' | 'background' | 'music' | 'animation', // 타입
  price: number,          // 가격
  imageUrl: string,       // 이미지 URL
  description: string,    // 설명
  isActive: boolean       // 활성화 여부
}
```

### 13. userItems (사용자 구매 아이템)

```javascript
{
  userId: string,         // 사용자 ID
  itemId: string,        // 아이템 ID
  memorialId: string,    // 적용된 추모관 ID
  purchasedAt: timestamp, // 구매 일시
  appliedAt: timestamp    // 적용 일시
}
```

### 14. shares (추모관 공유 기록)

```javascript
{
  shareId: string,        // 공유 기록 고유 ID
  memorialId: string,    // 추모관 ID
  userId: string,         // 공유한 사용자 ID (익명: null)
  shareType: 'link' | 'qr' | 'kakao' | 'facebook' | 'twitter', // 공유 타입
  sharedAt: timestamp,    // 공유 일시
  visitedFromShare: boolean // 공유를 통해 방문했는지 여부
}
```

### 15. memorialStats (추모관 통계 - 일별 집계)

```javascript
{
  statId: string,         // 통계 고유 ID
  memorialId: string,    // 추모관 ID
  date: string,          // 날짜 (YYYY-MM-DD)
  visitCount: number,    // 일별 방문 수
  commentCount: number,  // 일별 댓글 수
  donationCount: number, // 일별 추모금 전달 횟수
  donationAmount: number, // 일별 추모금 수령액
  shareCount: number,    // 일별 공유 횟수
  createdAt: timestamp   // 생성 일시
}
```

### 16. backups (추모관 백업 내역)

```javascript
{
  backupId: string,       // 백업 고유 ID
  memorialId: string,    // 추모관 ID
  userId: string,         // 백업한 사용자 ID
  backupType: 'pdf' | 'photos' | 'videos' | 'letters' | 'full', // 백업 타입
  fileUrl: string,        // 백업 파일 URL (Storage 경로)
  fileSize: number,       // 파일 크기 (bytes)
  createdAt: timestamp    // 백업 일시
}
```

### 17. notifications (알림 내역) - 선택

```javascript
{
  notificationId: string,  // 알림 고유 ID
  userId: string,         // 수신자 ID
  type: string,           // 알림 타입 (anniversary, comment, prayer, reengagement, eternalTime 등)
  title: string,          // 알림 제목
  body: string,           // 알림 내용
  data: object,          // 알림 데이터 (화면 이동용)
  memorialId: string,    // 관련 추모관 ID (선택)
  isRead: boolean,        // 읽음 여부
  sentAt: timestamp,      // 발송 일시
  readAt: timestamp       // 읽은 일시 (선택)
}
```

## 🔍 인덱스 설정

### Firestore 인덱스

```javascript
// memorials 컬렉션
- creatorId (ascending) + createdAt (descending)
- isPublic (ascending) + createdAt (descending)
- isAIGenerated (ascending) + createdAt (descending)  // AI 데이터 제거용
- anniversary.birthday (ascending)
- anniversary.memorialDay (ascending)

// comments 컬렉션
- memorialId (ascending) + createdAt (descending)
- isAIGenerated (ascending) + createdAt (descending)  // AI 데이터 제거용

// prayers 컬렉션
- createdAt (descending)
- memorialId (ascending) + createdAt (descending)
- isAIGenerated (ascending) + createdAt (descending)  // AI 데이터 제거용

// donations 컬렉션
- memorialId (ascending) + createdAt (descending)
- recipientId (ascending) + createdAt (descending)
- paymentStatus (ascending) + createdAt (descending)

// emotions 컬렉션
- createdAt (descending)
- category (ascending) + createdAt (descending)
- isAIGenerated (ascending) + createdAt (descending)  // AI 데이터 제거용
- likeCount (descending)

// regretLetters 컬렉션 (후회 없는 편지)
- visibility (ascending) + createdAt (descending)
- category (ascending) + createdAt (descending)
- linkedMemorialId (ascending) + createdAt (descending)
- userId (ascending) + createdAt (descending)  // 내 편지 조회용
- likeCount (descending)  // 공감순 정렬용
- isAIGenerated (ascending) + createdAt (descending)  // AI 데이터 제거용
- visibility (ascending) + category (ascending) + createdAt (descending)
- visibility (ascending) + likeCount (descending)

// regretLetterLikes 컬렉션
- letterId (ascending) + userId (ascending)  // 중복 공감 방지
- letterId (ascending) + likedAt (descending)
- userId (ascending) + likedAt (descending)  // 내가 공감한 편지

// regretLetterComments 컬렉션
- letterId (ascending) + createdAt (descending)
- isAIGenerated (ascending) + createdAt (descending)  // AI 데이터 제거용

// aiMemories 컬렉션 (AI 기억 분석)
- memorialId (ascending) + createdAt (descending)
- userId (ascending) + createdAt (descending)
- memorialId (ascending) + analyzedAt (descending)

// aiReplies 컬렉션 (AI 답장)
- memorialId (ascending) + createdAt (descending)
- memoryId (ascending) + createdAt (descending)
- userId (ascending) + createdAt (descending)
- isSaved (ascending) + createdAt (descending)

// wills 컬렉션 (유언장)
- visibility (ascending) + createdAt (descending)
- category (ascending) + createdAt (descending)
- userId (ascending) + createdAt (descending)  // 내 유언 조회용
- likeCount (descending)  // 공감순 정렬용
- visibility (ascending) + category (ascending) + createdAt (descending)
- visibility (ascending) + likeCount (descending)
- isTemplate (ascending) + category (ascending)  // 템플릿 조회용

// willLikes 컬렉션
- willId (ascending) + userId (ascending)  // 중복 공감 방지
- willId (ascending) + likedAt (descending)
- userId (ascending) + likedAt (descending)  // 내가 공감한 유언

// willComments 컬렉션
- willId (ascending) + createdAt (descending)

// matchingProfiles 컬렉션 (매칭 프로필)
- type (ascending) + createdAt (descending)  // 구인/구직 구분
- type (ascending) + lostRelationship (ascending) + seekingRelationship (ascending) + createdAt (descending)
- userId (ascending) + status (ascending)  // 내 프로필 조회
- status (ascending) + createdAt (descending)  // 활성 프로필 조회
- isVerified (ascending) + createdAt (descending)  // 검증된 프로필

// matchingRequests 컬렉션 (매칭 신청)
- senderProfileId (ascending) + status (ascending) + createdAt (descending)  // 내가 보낸 신청
- receiverProfileId (ascending) + status (ascending) + createdAt (descending)  // 내가 받은 신청
- senderProfileId (ascending) + receiverProfileId (ascending)  // 중복 신청 방지

// matchings 컬렉션 (매칭 관계)
- profileId1 (ascending) + status (ascending) + matchedAt (descending)
- profileId2 (ascending) + status (ascending) + matchedAt (descending)
- matchingId (ascending)  // 채팅 조회용

// matchingChats 컬렉션 (매칭 채팅)
- matchingId (ascending) + createdAt (descending)
- matchingId (ascending) + isRead (ascending) + createdAt (descending)

// matchingReports 컬렉션 (매칭 신고)
- reportedProfileId (ascending) + status (ascending) + createdAt (descending)
- reportedUserId (ascending) + status (ascending) + createdAt (descending)

// gratitudeBenefits 컬렉션 (감사 혜택)
- isActive (ascending) + startDate (descending) + endDate (ascending)
- type (ascending) + isActive (ascending) + startDate (descending)
- startDate (ascending) + endDate (ascending)  // 예정된 감사 혜택 조회

// benefitParticipants 컬렉션 (감사 혜택 참여자)
- benefitId (ascending) + participatedAt (descending)
- userId (ascending) + participatedAt (descending)  // 내 참여 감사 혜택
- benefitId (ascending) + userId (ascending)  // 중복 참여 방지

// userRewards 컬렉션 (사용자 혜택)
- userId (ascending) + isUsed (ascending) + endDate (descending)
- userId (ascending) + type (ascending) + isUsed (ascending)
- endDate (ascending) + isUsed (ascending)  // 만료된 혜택 조회

// visits 컬렉션
- memorialId (ascending) + date (ascending)
- memorialId (ascending) + visitedAt (descending)

// shares 컬렉션
- memorialId (ascending) + sharedAt (descending)
- userId (ascending) + sharedAt (descending)

// memorialStats 컬렉션
- memorialId (ascending) + date (ascending)
- memorialId (ascending) + date (descending)

// backups 컬렉션
- memorialId (ascending) + createdAt (descending)
- userId (ascending) + createdAt (descending)

// notifications 컬렉션 (선택)
- userId (ascending) + sentAt (descending)
- userId (ascending) + isRead (ascending) + sentAt (descending)
- memorialId (ascending) + sentAt (descending)
```

## 🔐 보안 규칙

### Firestore Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // 사용자 정보
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    
    // 추모관
    match /memorials/{memorialId} {
      allow read: if resource.data.isPublic == true || 
                     resource.data.creatorId == request.auth.uid;
      allow create: if request.auth != null && 
                       request.auth.uid == request.resource.data.creatorId;
      allow update, delete: if request.auth != null && 
                               resource.data.creatorId == request.auth.uid;
    }
    
    // 댓글
    match /comments/{commentId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null && 
                       request.auth.uid == request.resource.data.userId;
      allow update, delete: if request.auth != null && 
                               resource.data.userId == request.auth.uid;
    }
    
    // 기도 요청
    match /prayers/{prayerId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null && 
                       request.auth.uid == request.resource.data.userId;
      allow update: if request.auth != null;
    }
    
    // 추모금
    match /donations/{donationId} {
      allow read: if request.auth != null && 
                     (resource.data.donorId == request.auth.uid || 
                      resource.data.recipientId == request.auth.uid);
      allow create: if request.auth != null && 
                       request.auth.uid == request.resource.data.donorId;
    }
    
    // 감정 공유
    match /emotions/{emotionId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null && 
                       request.auth.uid == request.resource.data.userId;
      allow update, delete: if request.auth != null && 
                               resource.data.userId == request.auth.uid;
    }
    
    // 후회 없는 편지
    match /regretLetters/{letterId} {
      allow read: if request.auth != null && 
                     (resource.data.visibility == 'public' || 
                      resource.data.visibility == 'anonymous' ||
                      (resource.data.visibility == 'private' && 
                       resource.data.userId == request.auth.uid));
      allow create: if request.auth != null && 
                       request.auth.uid == request.resource.data.userId;
      allow update, delete: if request.auth != null && 
                               resource.data.userId == request.auth.uid;
    }
    
    // 후회 없는 편지 공감
    match /regretLetterLikes/{likeId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null && 
                       request.auth.uid == request.resource.data.userId;
      allow delete: if request.auth != null && 
                       resource.data.userId == request.auth.uid;
    }
    
    // 후회 없는 편지 댓글
    match /regretLetterComments/{commentId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null && 
                       request.auth.uid == request.resource.data.userId;
      allow update, delete: if request.auth != null && 
                               resource.data.userId == request.auth.uid;
    }
    
    // AI 기억 분석
    match /aiMemories/{memoryId} {
      allow read: if request.auth != null && 
                     (resource.data.userId == request.auth.uid ||
                      resource.data.memorialId exists);
      allow create: if request.auth != null && 
                       request.auth.uid == request.resource.data.userId;
      allow update, delete: if request.auth != null && 
                               resource.data.userId == request.auth.uid;
    }
    
    // AI 답장
    match /aiReplies/{replyId} {
      allow read: if request.auth != null && 
                     resource.data.userId == request.auth.uid;
      allow create: if request.auth != null && 
                       request.auth.uid == request.resource.data.userId;
      allow update: if request.auth != null && 
                       resource.data.userId == request.auth.uid;
      allow delete: if request.auth != null && 
                       resource.data.userId == request.auth.uid;
    }
    
    // 유언장
    match /wills/{willId} {
      allow read: if request.auth != null && 
                     (resource.data.visibility == 'public' ||
                      (resource.data.visibility == 'private' && 
                       resource.data.userId == request.auth.uid));
      allow create: if request.auth != null && 
                       request.auth.uid == request.resource.data.userId;
      allow update, delete: if request.auth != null && 
                               resource.data.userId == request.auth.uid;
    }
    
    // 유언 공감
    match /willLikes/{likeId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null && 
                       request.auth.uid == request.resource.data.userId;
      allow delete: if request.auth != null && 
                       resource.data.userId == request.auth.uid;
    }
    
    // 유언 댓글
    match /willComments/{commentId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null && 
                       request.auth.uid == request.resource.data.userId;
      allow update, delete: if request.auth != null && 
                               resource.data.userId == request.auth.uid;
    }
    
    // 매칭 프로필
    match /matchingProfiles/{profileId} {
      allow read: if request.auth != null && 
                     resource.data.status == 'active';
      allow create: if request.auth != null && 
                       request.auth.uid == request.resource.data.userId;
      allow update, delete: if request.auth != null && 
                               resource.data.userId == request.auth.uid;
    }
    
    // 매칭 신청
    match /matchingRequests/{requestId} {
      allow read: if request.auth != null && 
                     (resource.data.senderProfileId exists ||
                      resource.data.receiverProfileId exists);
      allow create: if request.auth != null;
      allow update: if request.auth != null && 
                       resource.data.receiverProfileId exists;
    }
    
    // 매칭 관계
    match /matchings/{matchingId} {
      allow read: if request.auth != null && 
                     (resource.data.profileId1 exists ||
                      resource.data.profileId2 exists);
      allow create: if request.auth != null;  // 서버에서만 생성
      allow update: if request.auth != null;
    }
    
    // 매칭 채팅
    match /matchingChats/{chatId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null && 
                       request.auth.uid == request.resource.data.senderId;
    }
    
    // 매칭 신고
    match /matchingReports/{reportId} {
      allow read: if request.auth != null && 
                     resource.data.reporterId == request.auth.uid;
      allow create: if request.auth != null && 
                       request.auth.uid == request.resource.data.reporterId;
    }
    
    // 감사 혜택
    match /gratitudeBenefits/{benefitId} {
      allow read: if request.auth != null;
      allow create, update, delete: if false;  // 서버에서만 관리
    }
    
    // 감사 혜택 참여자
    match /benefitParticipants/{participantId} {
      allow read: if request.auth != null && 
                     resource.data.userId == request.auth.uid;
      allow create: if request.auth != null && 
                       request.auth.uid == request.resource.data.userId;
    }
    
    // 사용자 혜택
    match /userRewards/{rewardId} {
      allow read: if request.auth != null && 
                     resource.data.userId == request.auth.uid;
      allow create: if false;  // 서버에서만 생성
      allow update: if request.auth != null && 
                       resource.data.userId == request.auth.uid;
    }
    
    // 추모관 공유 기록
    match /shares/{shareId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
    }
    
    // 추모관 통계
    match /memorialStats/{statId} {
      allow read: if request.auth != null;
      allow create, update: if request.auth != null; // 서버에서만 생성/수정
    }
    
    // 추모관 백업
    match /backups/{backupId} {
      allow read: if request.auth != null && 
                     resource.data.userId == request.auth.uid;
      allow create: if request.auth != null && 
                       request.auth.uid == request.resource.data.userId;
      allow delete: if request.auth != null && 
                       resource.data.userId == request.auth.uid;
    }
    
    // 알림 내역 (선택)
    match /notifications/{notificationId} {
      allow read: if request.auth != null && 
                     resource.data.userId == request.auth.uid;
      allow create: if request.auth != null; // 서버에서만 생성
      allow update: if request.auth != null && 
                       resource.data.userId == request.auth.uid;
      allow delete: if request.auth != null && 
                       resource.data.userId == request.auth.uid;
    }
  }
}
```

## 📦 Storage 구조

### Firebase Storage 경로

```
memorials/
  {memorialId}/
    photos/
      {photoId}.jpg
    videos/
      {videoId}.mp4
    letters/
      {letterId}.mp3 (음성 편지)
    ai_memories/
      conversations/
        {conversationId}.jpg (대화 캡처 이미지)
    ai_replies/
      {replyId}/
        audio.mp3 (음성 답장 파일)
    backups/
      {backupId}/
        {backupType}/
          {filename}.pdf | {filename}.zip | {filename}.json
users/
  {userId}/
    avatar.jpg
```

