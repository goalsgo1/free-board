# 🔧 Firebase 앱 등록 가이드

## 현재 상황

Firebase Console의 "프로젝트 설정" 페이지에서 **"프로젝트에 앱이 없습니다"** 메시지가 표시되고 있습니다.

이는 Firebase Console에 앱이 등록되지 않았다는 의미입니다. 로컬에는 설정 파일이 있지만, Firebase 프로젝트에 실제 앱이 연결되지 않았을 수 있습니다.

## 해결 방법

### 방법 1: FlutterFire CLI 재실행 (권장)

터미널에서 다음 명령어를 실행하여 Firebase에 앱을 다시 등록하세요:

```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard
export PATH="$PATH:$HOME/.pub-cache/bin"
flutterfire configure --project=talkboard-b93dd
```

**실행 과정:**
1. 프로젝트 `talkboard-b93dd` 선택 (또는 자동 선택)
2. 플랫폼 선택:
   - ✅ Android
   - ✅ iOS
   - ✅ Web (선택 사항)
3. 각 플랫폼의 앱 정보 입력:
   - **Android**: Package name: `com.talkboard.app`
   - **iOS**: Bundle ID: `com.talkboard.app`
   - **Web**: App nickname (선택 사항)
4. 앱이 Firebase Console에 자동으로 등록됩니다

### 방법 2: Firebase Console에서 직접 추가

Firebase Console에서 직접 앱을 추가할 수도 있습니다:

1. **Firebase Console** → **프로젝트 설정** 접속
2. **"내 앱"** 섹션에서 플랫폼 선택:
   - **Android** 아이콘 클릭
   - **iOS** 아이콘 클릭
   - **Web</>** 아이콘 클릭 (선택 사항)

3. **Android 앱 추가:**
   - 패키지 이름: `com.talkboard.app`
   - 앱 닉네임: `톡보드` (선택 사항)
   - 디버그 서명 인증서 SHA-1: (선택 사항, 나중에 추가 가능)
   - **앱 등록** 클릭
   - `google-services.json` 파일 다운로드
   - `android/app/` 폴더에 배치

4. **iOS 앱 추가:**
   - Bundle ID: `com.talkboard.app`
   - 앱 닉네임: `톡보드` (선택 사항)
   - App Store ID: (선택 사항)
   - **앱 등록** 클릭
   - `GoogleService-Info.plist` 파일 다운로드
   - `ios/Runner/` 폴더에 배치

5. **Web 앱 추가 (선택 사항):**
   - 앱 닉네임: `톡보드` (선택 사항)
   - Firebase Hosting 설정: (선택 사항)
   - **앱 등록** 클릭
   - 설정 코드 확인

## 확인 사항

### 앱 등록 후 확인

Firebase Console → **프로젝트 설정** → **내 앱** 섹션에서:
- [ ] Android 앱이 표시되는지 확인
- [ ] iOS 앱이 표시되는지 확인
- [ ] 앱 ID가 올바른지 확인

### 로컬 설정 파일 확인

```bash
# Firebase 설정 파일 확인
ls -la android/app/google-services.json
ls -la ios/Runner/GoogleService-Info.plist
ls -la lib/firebase_options.dart
ls -la firebase.json
```

### 앱 실행 테스트

```bash
flutter run
```

게시글 작성, 댓글 기능이 정상적으로 작동하는지 확인하세요.

## 문제 해결

### "Firebase project id could not be found" 오류
- Firebase Console에서 프로젝트가 정상적으로 생성되었는지 확인
- 프로젝트 ID가 `talkboard-b93dd`인지 확인

### "앱이 이미 존재합니다" 오류
- Firebase Console에서 기존 앱을 확인
- 다른 Bundle ID/Package name 사용 또는 기존 앱 사용

### 앱 등록은 되었지만 연결이 안 되는 경우
- `flutter clean` 실행 후 `flutter pub get` 재실행
- Firebase 설정 파일이 올바른 위치에 있는지 확인

## 추천 방법

**방법 1 (FlutterFire CLI)**을 추천합니다:
- 자동으로 모든 설정 파일 생성
- 앱을 Firebase Console에 자동 등록
- 여러 플랫폼을 한 번에 설정 가능
- 설정 파일들이 자동으로 업데이트됨

## 다음 단계

앱이 Firebase Console에 등록되면:
1. Firestore 색인 생성 확인
2. Firestore 보안 규칙 확인
3. 앱 실행 및 테스트

