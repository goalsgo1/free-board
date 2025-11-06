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

### 10. visits (방문 기록)

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
    backups/
      {backupId}/
        {backupType}/
          {filename}.pdf | {filename}.zip | {filename}.json
users/
  {userId}/
    avatar.jpg
```

