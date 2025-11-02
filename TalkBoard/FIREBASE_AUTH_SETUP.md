# Firebase Authentication 설정 가이드

## 현재 문제
`[firebase_auth/configuration-not-found]` 에러가 발생합니다.
이는 Firebase Console에서 Authentication 서비스를 활성화하지 않아서 발생합니다.

## 해결 방법

### 1단계: Firebase Console에서 Authentication 활성화

1. **Firebase Console 접속**
   - https://console.firebase.google.com/project/톡보드 프로젝트 접속

2. **Authentication 메뉴로 이동**
   - 왼쪽 메뉴에서 "Authentication" (또는 "인증") 클릭
   - 또는 프로젝트 오버뷰에서 "Authentication" 카드 클릭

3. **시작하기 클릭**
   - "시작하기" 또는 "Get started" 버튼 클릭

4. **로그인 방법 설정**
   - "Sign-in method" (로그인 방법) 탭 클릭
   - 이메일/비밀번호 인증 활성화:
     - "이메일/비밀번호" 클릭
     - 첫 번째 토글(이메일/비밀번호 사용)을 "사용 설정"으로 변경
     - "저장" 클릭

5. **확인**
   - 이메일/비밀번호가 "사용 설정" 상태로 표시되는지 확인

### 2단계: 앱 새로고침

1. **브라우저 새로고침**
   - 앱이 실행 중인 브라우저를 새로고침 (F5 또는 Cmd+R)

2. **또는 Hot Restart**
   - 터미널에서 `R` 키를 눌러 앱 재시작

## 완료 후

이제 다음 기능을 사용할 수 있습니다:
- ✅ 회원가입 (이메일/비밀번호)
- ✅ 로그인 (이메일/비밀번호)
- ✅ 로그아웃
- ✅ 게시글 작성/수정/삭제

## 참고사항

⚠️ **중요**: Authentication 서비스를 활성화하지 않으면 인증 관련 모든 기능이 작동하지 않습니다.

✅ **확인 방법**: Authentication이 활성화되면 Firebase Console의 Authentication 메뉴에서 사용자 목록을 볼 수 있습니다.

