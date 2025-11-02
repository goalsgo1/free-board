# Firestore 인덱스 설정 가이드

## 현재 문제
댓글 기능을 사용할 때 `[cloud_firestore/failed-precondition] The query requires an index` 오류가 발생합니다.

## 원인
Firestore에서 `where` 조건과 `orderBy`를 함께 사용할 때는 **복합 인덱스**가 필요합니다.

현재 필요한 인덱스:

**게시글 목록 (posts):**
- `where('isDeleted', isEqualTo: false)` 
- `orderBy('createdAt', descending: true)`

**댓글 목록 (comments):**
- `where('postId', isEqualTo: postId)` 
- `where('isDeleted', isEqualTo: false)`
- `orderBy('createdAt', descending: false)`

## 해결 방법

### 방법 1: 자동 인덱스 생성 (가장 쉬움) ⭐

1. **에러 메시지의 URL 클릭**
   - 오류 메시지에 표시된 링크를 클릭하세요
   - 자동으로 인덱스 생성 페이지로 이동합니다

2. **인덱스 생성 확인**
   - Firebase Console에서 인덱스 생성이 시작됩니다
   - "Build index" 버튼이 표시되면 클릭

3. **인덱스 생성 완료 대기**
   - 보통 몇 분 정도 소요됩니다
   - 상태가 "Enabled"가 되면 완료입니다

### 방법 2: Firebase Console에서 수동 생성

1. **Firebase Console 접속**
   - https://console.firebase.google.com 접속
   - **톡보드** 프로젝트 선택
   - 왼쪽 메뉴에서 **Firestore Database** 선택
   - 상단 **"색인"** (Indexes) 탭 클릭

2. **인덱스 추가**

   **게시글 인덱스 (posts):**
   - "색인 추가" 버튼 클릭 → "복합" 선택
   - **컬렉션 ID**: `posts`
   - **필드 추가**:
     - `isDeleted` (오름차순 ↑)
     - `createdAt` (내림차순 ↓)
   - "만들기" 클릭

   **댓글 인덱스 #1 (comments - postId, isDeleted):**
   - "색인 추가" 버튼 클릭 → "복합" 선택
   - **컬렉션 ID**: `comments`
   - **필드 추가**:
     - `postId` (오름차순 ↑)
     - `isDeleted` (오름차순 ↑)
   - "만들기" 클릭

   **댓글 인덱스 #2 (comments - postId, createdAt):**
   - "색인 추가" 버튼 클릭 → "복합" 선택
   - **컬렉션 ID**: `comments`
   - **필드 추가**:
     - `postId` (오름차순 ↑)
     - `createdAt` (오름차순 ↑)
   - "만들기" 클릭

3. **인덱스 생성**
   - "만들기" 또는 "Create" 클릭
   - 인덱스 생성 완료까지 대기

## 인덱스 생성 완료 확인

인덱스 생성이 완료되면:
- Firebase Console의 "색인" 탭에서 상태가 "Enabled"로 표시됩니다
- 브라우저를 새로고침하거나 앱을 Hot Restart (`R` 키)
- 이제 댓글 기능이 정상적으로 작동합니다

## 참고사항

⚠️ **인덱스 생성 시간**: 처음 생성할 때는 1-5분 정도 소요될 수 있습니다.

✅ **자동 생성**: 에러 메시지의 링크를 사용하면 가장 간단합니다.

📝 **인덱스 목록**: Firebase Console → Firestore Database → 색인 탭에서 생성된 인덱스를 확인할 수 있습니다.

