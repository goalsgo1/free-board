# Firebase 프로젝트 재연결 가이드

## 📋 목적
기존 "톡보드 프로젝트" 프로젝트에서 "톡보드"라는 이름의 새 Firebase 프로젝트로 재연결합니다.

## 🔧 단계별 가이드

### 1단계: Firebase Console에서 새 프로젝트 생성

1. https://console.firebase.google.com 접속
2. "프로젝트 추가" 클릭
3. 프로젝트 정보 입력:
   - **프로젝트 이름**: `톡보드` (또는 원하는 이름)
   - Google Analytics 사용 (선택 사항)
4. "프로젝트 만들기" 클릭
5. 프로젝트 생성 완료 대기 (1-2분)

### 2단계: Firebase 서비스 설정

#### Firestore Database 생성
1. Firebase Console → 왼쪽 메뉴에서 **Firestore Database** 선택
2. "데이터베이스 만들기" 클릭
3. **테스트 모드로 시작** 선택 (개발용)
4. 위치 선택: **asia-northeast3 (서울)** 추천
5. "완료" 클릭

#### Authentication 활성화
1. Firebase Console → 왼쪽 메뉴에서 **Authentication** 선택
2. "시작하기" 클릭
3. "Sign-in method" 탭 선택
4. "이메일/비밀번호" 선택
5. "사용 설정" 클릭
6. "저장" 클릭

### 3단계: Flutter 앱에 새 프로젝트 연결

터미널에서 다음 명령어 실행:

```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard
flutterfire configure
```

**명령어 실행 시:**
1. Firebase 프로젝트 목록이 나타남
2. 방금 생성한 **톡보드** 프로젝트 선택
3. 플랫폼 선택:
   - ✅ Android
   - ✅ iOS  
   - ✅ Web (선택 사항)
4. 각 플랫폼의 설정 파일 생성 확인

### 4단계: 생성된 파일 확인

다음 파일들이 자동으로 업데이트됩니다:

- ✅ `lib/firebase_options.dart` - Firebase 설정 코드
- ✅ `android/app/google-services.json` - Android 설정
- ✅ `ios/Runner/GoogleService-Info.plist` - iOS 설정
- ✅ `firebase.json` - FlutterFire 설정

### 5단계: 앱 실행 및 테스트

```bash
# 의존성 재설치
flutter pub get

# Android 실행
flutter run

# iOS 실행
flutter run -d ios
```

## ⚠️ 주의사항

### 기존 데이터
- 기존 Firebase 프로젝트의 데이터는 새 프로젝트로 **이동되지 않습니다**
- 필요한 데이터가 있다면 수동으로 마이그레이션해야 합니다

### Firebase 보안 규칙
새 프로젝트를 생성했으므로 보안 규칙을 다시 설정해야 합니다:

1. Firebase Console → Firestore Database → 규칙 탭
2. `FIRESTORE_SECURITY_RULES.md` 파일의 규칙 복사 후 적용
3. "게시" 클릭

### Firebase 인덱스
필요한 경우 Firestore 인덱스를 다시 생성해야 합니다:

1. Firebase Console → Firestore Database → 인덱스 탭
2. `FIRESTORE_INDEX_SETUP.md` 파일 참고하여 인덱스 생성

## ✅ 확인 사항

재연결이 완료되면 다음을 확인하세요:

- [ ] `lib/firebase_options.dart`의 `projectId`가 새 프로젝트 ID와 일치하는지 확인
- [ ] `firebase.json`의 `projectId`가 새 프로젝트 ID와 일치하는지 확인
- [ ] 앱 실행 후 Firebase 연결이 정상적으로 작동하는지 확인
- [ ] 게시글 작성/읽기가 정상적으로 작동하는지 확인
- [ ] 사용자 인증이 정상적으로 작동하는지 확인

## 🔄 문제 해결

### 오류: "Firebase project id could not be found"
- Firebase Console에서 프로젝트가 정상적으로 생성되었는지 확인
- `flutterfire configure` 실행 시 올바른 프로젝트를 선택했는지 확인

### 오류: "Permission denied" 또는 인증 오류
- Firestore 보안 규칙이 올바르게 설정되었는지 확인
- Authentication이 활성화되었는지 확인

### 기타 문제
- `flutter clean` 실행 후 `flutter pub get` 재실행
- Firebase Console에서 프로젝트 설정 확인

## 📚 참고 문서

- [Firebase 설정 가이드](FIREBASE_SETUP.md)
- [Firestore 보안 규칙](FIRESTORE_SECURITY_RULES.md)
- [Firestore 인덱스 설정](FIRESTORE_INDEX_SETUP.md)
- [Firebase 인증 설정](FIREBASE_AUTH_SETUP.md)

