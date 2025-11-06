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
  notificationSettings: {
    anniversaryAlerts: boolean, // 기념일 알림
    commentAlerts: boolean,    // 댓글 알림
    prayerAlerts: boolean      // 기도 알림
  }
}
```

### 2. memorials (추모관)

```javascript
{
  memorialId: string,          // 추모관 고유 ID
  creatorId: string,           // 생성자 ID (users.userId)
  deceasedName: string,        // 고인 이름
  lifeSummary: string,         // 생애 요약
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
    createdAt: timestamp
  },
  anniversary: {
    birthday: date,           // 생일
    memorialDay: date          // 기일
  },
  isPublic: boolean,          // 공개/비공개
  visitCount: number,         // 방문 횟수
  lastVisitedAt: timestamp,  // 마지막 방문 일시
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
  userId: string,             // 작성자 ID
  userName: string,           // 작성자 이름
  content: string,            // 댓글 내용
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
  userId: string,             // 작성자 ID
  userName: string,           // 작성자 이름
  title: string,              // 제목
  content: string,            // 내용
  prayerCount: number,        // 함께 기도 카운트
  participants: [string],    // 참여자 ID 배열
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
  userId: string,             // 작성자 ID
  userName: string,           // 작성자 이름
  title: string,             // 제목
  content: string,           // 내용
  likeCount: number,         // 좋아요 수
  commentCount: number,      // 댓글 수
  category: 'grief' | 'memory' | 'comfort', // 카테고리
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

## 🔍 인덱스 설정

### Firestore 인덱스

```javascript
// memorials 컬렉션
- creatorId (ascending) + createdAt (descending)
- isPublic (ascending) + createdAt (descending)
- anniversary.birthday (ascending)
- anniversary.memorialDay (ascending)

// comments 컬렉션
- memorialId (ascending) + createdAt (descending)

// prayers 컬렉션
- createdAt (descending)
- memorialId (ascending) + createdAt (descending)

// donations 컬렉션
- memorialId (ascending) + createdAt (descending)
- recipientId (ascending) + createdAt (descending)
- paymentStatus (ascending) + createdAt (descending)

// emotions 컬렉션
- createdAt (descending)
- category (ascending) + createdAt (descending)
- likeCount (descending)

// visits 컬렉션
- memorialId (ascending) + date (ascending)
- memorialId (ascending) + visitedAt (descending)
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
users/
  {userId}/
    avatar.jpg
```

