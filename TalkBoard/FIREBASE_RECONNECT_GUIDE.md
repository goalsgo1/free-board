# 🆕 Firebase 프로젝트 재연결 가이드 (TalkBoard)

## ✅ 완료된 작업

1. ✅ 폴더 이름 변경: `FreeBoard` → `TalkBoard` (완료)
2. ✅ 이전 Firebase 설정 파일 삭제:
   - `android/app/google-services.json` (삭제됨)
   - `ios/Runner/GoogleService-Info.plist` (삭제됨)
   - `lib/firebase_options.dart` (삭제됨)
   - `firebase.json` (삭제됨)

## 🔧 새 Firebase 프로젝트 연결

### 1단계: Firebase Console에서 프로젝트 확인

1. https://console.firebase.google.com 접속
2. **"톡보드"** 프로젝트가 생성되어 있는지 확인
3. 없다면 새로 생성:
   - "프로젝트 추가" 클릭
   - 프로젝트 이름: `톡보드`
   - Google Analytics 사용 (선택 사항)

### 2단계: Firestore Database 생성 (아직 안 했다면)

1. Firebase Console → **"Cloud Firestore"** 선택
2. **"데이터베이스 만들기"** 클릭
3. **"테스트 모드로 시작"** 선택
4. 위치: **asia-northeast3 (서울)** 추천
5. **"완료"** 클릭

### 3단계: Authentication 활성화 (아직 안 했다면)

1. Firebase Console → **"Authentication"** 선택
2. **"시작하기"** 클릭
3. **"Sign-in method"** 탭 선택
4. **"이메일/비밀번호"** 선택
5. **"사용 설정"** 클릭 후 **"저장"** 클릭

### 4단계: FlutterFire CLI로 연결

터미널에서 다음 명령어를 실행하세요:

```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard
flutterfire configure
```

**실행 과정:**
1. Firebase 프로젝트 목록이 표시됩니다
2. **"톡보드"** 프로젝트를 선택하세요
3. 플랫폼 선택:
   - ✅ Android
   - ✅ iOS
   - ✅ Web (선택 사항)
4. 각 플랫폼의 앱 정보를 확인/수정 후 계속 진행

**자동으로 생성되는 파일:**
- ✅ `lib/firebase_options.dart`
- ✅ `android/app/google-services.json`
- ✅ `ios/Runner/GoogleService-Info.plist`
- ✅ `firebase.json`

### 5단계: 의존성 설치

```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard
flutter pub get
```

### 6단계: Firestore 색인 생성

새 프로젝트이므로 색인을 다시 생성해야 합니다:

1. Firebase Console → Firestore Database → **"색인"** 탭
2. `새_프로젝트_색인_추가_가이드.md` 파일 참고
3. 다음 3개의 색인 생성:
   - `comments`: `postId ↑`, `isDeleted ↑`
   - `comments`: `postId ↑`, `createdAt ↑`
   - `posts`: `isDeleted ↑`, `createdAt ↓`

### 7단계: Firestore 보안 규칙 설정

1. Firebase Console → Firestore Database → **"규칙"** 탭
2. `FIRESTORE_SECURITY_RULES.md` 파일의 규칙 복사
3. **"게시"** 클릭

### 8단계: 앱 실행 및 테스트

```bash
flutter run
```

게시글 작성, 댓글 기능이 정상적으로 작동하는지 확인하세요!

## ✅ 확인 사항

재연결이 완료되면 다음을 확인하세요:

- [ ] `lib/firebase_options.dart`의 `projectId`가 새 "톡보드" 프로젝트 ID와 일치
- [ ] `firebase.json`의 `projectId`가 새 프로젝트 ID와 일치
- [ ] 앱 실행 후 Firebase 연결 정상 작동
- [ ] 게시글 작성/읽기 정상 작동
- [ ] 사용자 인증 (로그인/회원가입) 정상 작동
- [ ] 댓글 작성 정상 작동
- [ ] Firestore 색인 3개 모두 생성 완료
- [ ] Firestore 보안 규칙 설정 완료

## 🚨 문제 해결

### 오류: "Firebase project id could not be found"
- Firebase Console에서 "톡보드" 프로젝트가 정상적으로 생성되었는지 확인
- `flutterfire configure` 실행 시 올바른 프로젝트 선택 확인

### 오류: "Permission denied" 또는 인증 오류
- Firestore 보안 규칙이 올바르게 설정되었는지 확인
- Authentication이 활성화되었는지 확인

### 오류: "The query requires an index"
- Firestore 색인이 모두 생성되었는지 확인
- `새_프로젝트_색인_추가_가이드.md` 파일 참고

### 기타 문제
- `flutter clean` 실행 후 `flutter pub get` 재실행
- Firebase Console에서 프로젝트 설정 확인

## 📚 관련 문서

- [새 프로젝트 색인 추가 가이드](새_프로젝트_색인_추가_가이드.md)
- [Firestore 보안 규칙](FIRESTORE_SECURITY_RULES.md)
- [Firebase 설정 가이드](FIREBASE_SETUP.md)

