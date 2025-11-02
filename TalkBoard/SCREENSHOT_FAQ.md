# 📸 스크린샷 FAQ

## Q: iOS 스크린샷만 촬영했는데 앱 스토어 등록이 가능한가요?

### A: 부분적으로 가능합니다

- ✅ **Apple App Store**: iOS 스크린샷만으로 등록 가능
- ❌ **Google Play Store**: Android 스크린샷 필요 (iOS만으로는 불가능)

## 📱 앱 스토어별 요구사항

### Apple App Store
- **iOS 스크린샷**: ✅ 필수
- **Android 스크린샷**: ❌ 불필요
- **결론**: iOS 스크린샷만으로 등록 가능

### Google Play Store
- **Android 스크린샷**: ✅ 필수
- **iOS 스크린샷**: ❌ 불필요
- **결론**: Android 스크린샷 없이는 등록 불가능

## 🚀 Android 스크린샷 빠르게 촬영하기

### 방법 1: Android 에뮬레이터 사용 (가장 쉬움) ⭐

```bash
# 1. Android 에뮬레이터 실행
flutter run --release -d emulator-5554

# 2. 각 화면에서 스크린샷 촬영
# Android Studio 에뮬레이터의 스크린샷 버튼 클릭
# 또는 ADB 명령어 사용:
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png screenshots/android/
```

### 방법 2: ADB 명령어로 자동 촬영

```bash
# 프로젝트 디렉토리로 이동
cd /Users/haemin/Documents/GitHub/project/TalkBoard

# Android 에뮬레이터에서 스크린샷 촬영
adb -s emulator-5554 shell screencap -p /sdcard/01_post_list.png
adb -s emulator-5554 pull /sdcard/01_post_list.png screenshots/android/

adb -s emulator-5554 shell screencap -p /sdcard/02_post_detail.png
adb -s emulator-5554 pull /sdcard/02_post_detail.png screenshots/android/
```

### 방법 3: 실제 Android 디바이스 사용

1. Android 스마트폰을 USB로 Mac에 연결
2. 개발자 모드 및 USB 디버깅 활성화
3. `flutter run --release` 실행
4. 각 화면에서 스크린샷 촬영

## 📋 최소 필요한 Android 스크린샷

Google Play Store 최소 요구사항: **2개**

1. ✅ **게시글 목록 화면** (필수)
2. ✅ **게시글 상세 + 댓글 화면** (필수)

**추가 권장:**
3. 로그인/회원가입 화면
4. 게시글 작성 화면

## ⚡ 빠른 촬영 가이드 (5분 안에 완료)

### 1단계: 앱 실행 (1분)
```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard
flutter run --release -d emulator-5554
```

### 2단계: 샘플 데이터 생성 (30초)
- 앱에서 샘플 데이터 생성 버튼 클릭
- 또는 이미 데이터가 있다면 생략

### 3단계: 스크린샷 촬영 (2분)
1. 게시글 목록 화면에서 스크린샷
2. 게시글 하나 클릭
3. 게시글 상세 + 댓글 화면에서 스크린샷

### 4단계: 저장 (1분)
- 스크린샷을 `screenshots/android/` 폴더에 저장
- 파일명: `01_post_list.png`, `02_post_detail.png`

## 💡 팁

### iOS 스크린샷 재사용 불가
- iOS와 Android는 다른 플랫폼이므로 스크린샷을 재사용할 수 없습니다
- 각 플랫폼별로 별도로 촬영해야 합니다

### 동일한 화면 구성
- iOS와 Android에서 동일한 화면을 촬영하세요
- 게시글 목록, 게시글 상세, 댓글 화면 등

### 릴리즈 모드 필수
- `flutter run --release` 모드로 촬영하세요
- Debug 모드 배지가 보이면 안 됩니다

## ✅ 체크리스트

### Apple App Store
- [x] iOS 스크린샷 촬영 완료 (이미 완료)
- [ ] App Store Connect에 업로드 준비 완료

### Google Play Store
- [ ] Android 스크린샷 촬영 필요
  - [ ] 게시글 목록 화면
  - [ ] 게시글 상세 + 댓글 화면
- [ ] Google Play Console에 업로드 준비

## 🎯 결론

**현재 상태:**
- ✅ Apple App Store 등록 준비 완료 (iOS 스크린샷 있음)
- ⏳ Google Play Store 등록 준비 중 (Android 스크린샷 필요)

**다음 단계:**
1. Android 에뮬레이터에서 앱 실행
2. 최소 2개 스크린샷 촬영
3. `screenshots/android/` 폴더에 저장

Android 스크린샷만 촬영하면 Google Play Store 등록도 가능합니다! 🚀

