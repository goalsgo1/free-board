# Firestore 보안 규칙 설정 가이드

## 현재 문제
앱에서 Firestore 데이터베이스에 접근할 때 권한 오류가 발생하고 있습니다.

## 해결 방법

### Firebase Console에서 보안 규칙 설정

1. **Firebase Console 접속**
   - https://console.firebase.google.com/project/톡보드 프로젝트
   - 또는 프로젝트 선택 후 TalkBoard 프로젝트로 이동

2. **Firestore Database로 이동**
   - 왼쪽 메뉴에서 "Firestore Database" 클릭
   - 상단 탭에서 "규칙" 탭 선택

3. **개발용 보안 규칙 설정**
   
   현재 규칙이 다음과 같다면:
   ```
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /{document=**} {
         allow read, write: if false;
       }
     }
   }
   ```
   
   **개발 중에는** 다음 규칙으로 변경하세요 (모든 접근 허용):
   ```
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /{document=**} {
         allow read, write: if true;
       }
     }
   }
   ```

4. **규칙 게시**
   - "게시" 버튼 클릭
   - 잠시 후 규칙이 적용됩니다

## 주의사항

⚠️ **중요**: 위 규칙(`allow read, write: if true`)은 **개발/테스트용**입니다.

**프로덕션 배포 전에는 반드시 보안 규칙을 수정해야 합니다!**

### 프로덕션용 보안 규칙 예시

인증이 필요한 경우:
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /posts/{postId} {
      allow read: if true;  // 모든 사용자가 읽기 가능
      allow write: if request.auth != null;  // 로그인한 사용자만 작성 가능
    }
  }
}
```

## 규칙 적용 확인

규칙을 게시한 후:
1. 브라우저에서 앱을 새로고침하세요
2. 또는 앱을 다시 실행하세요
3. 이제 게시글 작성 및 읽기가 정상적으로 작동해야 합니다

