# Firestore 보안 규칙 설정 가이드

## 현재 상태
현재는 개발용 규칙(`allow read, write: if true`)으로 설정되어 있어 누구나 접근 가능합니다.

## 프로덕션용 보안 규칙 설정

### Firebase Console에서 규칙 업데이트

1. **Firebase Console 접속**
   - https://console.firebase.google.com/project/톡보드 프로젝트
   - 왼쪽 메뉴에서 "Firestore Database" 선택
   - 상단 "규칙" 탭 클릭

2. **다음 규칙으로 변경**

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // 게시글 컬렉션
    match /posts/{postId} {
      // 읽기: 모든 사용자 가능
      allow read: if true;
      
      // 작성: 로그인한 사용자만 가능
      allow create: if request.auth != null 
                   && request.resource.data.userId == request.auth.uid;
      
      // 수정: 작성자만 가능
      allow update: if request.auth != null 
                     && resource.data.userId == request.auth.uid
                     && request.resource.data.userId == request.auth.uid;
      
      // 삭제: 작성자만 가능
      allow delete: if request.auth != null 
                     && resource.data.userId == request.auth.uid;
    }
    
    // 댓글 컬렉션
    match /comments/{commentId} {
      // 읽기: 모든 사용자 가능
      allow read: if true;
      
      // 작성: 로그인한 사용자만 가능
      allow create: if request.auth != null 
                   && request.resource.data.userId == request.auth.uid;
      
      // 수정: 작성자만 가능
      allow update: if request.auth != null 
                     && resource.data.userId == request.auth.uid
                     && request.resource.data.userId == request.auth.uid;
      
      // 삭제: 작성자만 가능
      allow delete: if request.auth != null 
                     && resource.data.userId == request.auth.uid;
    }
  }
}
```

3. **규칙 게시**
   - "게시" 버튼 클릭
   - 규칙이 적용되는데 몇 초 정도 걸릴 수 있습니다

## 규칙 설명

### 게시글 컬렉션 (posts)
- **읽기 (read)**: 모든 사용자가 게시글을 읽을 수 있습니다
- **작성 (create)**: 로그인한 사용자만 게시글을 작성할 수 있고, 자신의 userId를 사용해야 합니다
- **수정 (update)**: 작성자만 자신의 게시글을 수정할 수 있습니다
- **삭제 (delete)**: 작성자만 자신의 게시글을 삭제할 수 있습니다

### 댓글 컬렉션 (comments)
- **읽기 (read)**: 모든 사용자가 댓글을 읽을 수 있습니다
- **작성 (create)**: 로그인한 사용자만 댓글을 작성할 수 있고, 자신의 userId를 사용해야 합니다
- **수정 (update)**: 작성자만 자신의 댓글을 수정할 수 있습니다
- **삭제 (delete)**: 작성자만 자신의 댓글을 삭제할 수 있습니다

## 테스트

규칙 적용 후:
1. 로그인하지 않은 사용자는 게시글과 댓글을 읽을 수만 있습니다
2. 로그인한 사용자만 게시글과 댓글을 작성할 수 있습니다
3. 본인 게시글/댓글만 수정/삭제할 수 있습니다

## 중요 참고사항

⚠️ **주의**: 규칙 변경 후 앱을 다시 실행해야 변경사항이 반영됩니다.

⚙️ **개발 중**: 개발 중에는 테스트 모드(`allow read, write: if true`)를 사용할 수 있지만, **절대 프로덕션 환경에 배포하지 마세요!**

