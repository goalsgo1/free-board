# Android/iOS 릴리즈 체크리스트

## ✅ 현재 상태 확인

### Firebase 설정
- ✅ Android: `google-services.json` 있음
- ✅ iOS: `GoogleService-Info.plist` 있음
- ✅ `firebase_options.dart` 생성됨

### 기본 설정
- ✅ Android Manifest 설정됨
- ✅ iOS Info.plist 설정됨
- ✅ 앱 아이콘 기본 제공
- ✅ 앱 이름: "톡보드"

## ⚠️ 릴리즈 전 필요한 작업

### 1. Android 릴리즈 준비

#### 필수 사항
- [ ] **앱 서명 키 생성** (중요!)
  - 현재: Debug 키 사용 중 (`signingConfig = signingConfigs.getByName("debug")`)
  - 릴리즈용 서명 키 생성 필요
  - 위치: `android/app/key.jks` (Git에 커밋하지 말 것!)

  ```bash
  keytool -genkey -v -keystore android/app/key.jks \
    -keyalg RSA -keysize 2048 -validity 10000 \
    -alias upload
  ```

- [ ] **서명 설정 추가** (`android/app/build.gradle.kts`)
  ```kotlin
  signingConfigs {
      release {
          storeFile = file("../key.jks")
          storePassword = System.getenv("KEYSTORE_PASSWORD") ?: ""
          keyAlias = "upload"
          keyPassword = System.getenv("KEY_PASSWORD") ?: ""
      }
  }
  
  buildTypes {
      release {
          signingConfig = signingConfigs.getByName("release")
          // ...
      }
  }
  ```

- [ ] **ProGuard/R8 설정** (선택사항)
  - 코드 난독화 및 최적화
  - `android/app/proguard-rules.pro` 파일 생성

- [ ] **앱 아이콘 커스터마이징** (선택사항)
  - 현재: 기본 아이콘
  - 위치: `android/app/src/main/res/mipmap-*/ic_launcher.png`

- [ ] **스플래시 화면** (선택사항)
  - 현재: 기본 제공

#### 권장 사항
- [ ] 앱 버전 업데이트 (`pubspec.yaml`)
  ```yaml
  version: 1.0.0+1  # 버전 이름 + 빌드 번호
  ```
- [ ] Android 최소 SDK 버전 확인
  - 현재: `flutter.minSdkVersion` (일반적으로 21)

### 2. iOS 릴리즈 준비

#### 필수 사항
- [ ] **Apple Developer 계정**
  - 무료 계정: 테스트만 가능
  - 유료 계정 ($99/년): App Store 배포 필수

- [ ] **Bundle ID 확인 및 설정**
  - Xcode에서 확인: `ios/Runner.xcodeproj/project.pbxproj`
  - Firebase Console의 Bundle ID와 일치해야 함

- [ ] **앱 아이콘 커스터마이징** (선택사항)
  - 위치: `ios/Runner/Assets.xcassets/AppIcon.appiconset/`
  - 모든 크기 이미지 필요 (현재 기본 제공됨)

- [ ] **권한 설정 확인** (필요한 경우)
  - 카메라, 사진 라이브러리 등
  - `Info.plist`에 설명 추가

#### 권장 사항
- [ ] Xcode에서 최소 iOS 버전 확인
- [ ] 앱 버전 업데이트

### 3. Firebase 프로덕션 설정

#### 확인 사항
- [ ] **Firestore 보안 규칙**
  - 프로덕션 환경에 맞게 설정
  - `FIRESTORE_SECURITY_RULES.md` 참고

- [ ] **Firebase Authentication**
  - 이메일/비밀번호 인증 활성화 확인

- [ ] **API 키 제한 설정** (보안)
  - Android: 패키지명 제한
  - iOS: Bundle ID 제한

### 4. 빌드 및 테스트

#### Android
```bash
# 릴리즈 APK 빌드
flutter build apk --release

# App Bundle 빌드 (Google Play Store용)
flutter build appbundle --release
```

#### iOS
```bash
# iOS 앱 빌드
flutter build ios --release

# Xcode에서 Archive 생성 필요
# Xcode > Product > Archive
```

### 5. 스토어 등록 준비

#### Google Play Store
- [ ] Google Play Console 계정 생성
- [ ] 앱 정보 작성
  - 앱 이름, 설명, 스크린샷
  - 개인정보처리방침 URL
- [ ] APK 또는 App Bundle 업로드

#### Apple App Store
- [ ] App Store Connect 계정 설정
- [ ] 앱 정보 작성
  - 앱 이름, 설명, 스크린샷
  - 개인정보처리방침 URL
- [ ] Xcode에서 Archive 업로드

## 🚀 즉시 가능한 작업

### 테스트 빌드 (개발용)

#### Android
```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard

# Debug APK 빌드
flutter build apk

# 릴리즈 APK 빌드 (현재 Debug 키 사용)
flutter build apk --release
```

#### iOS
```bash
# iOS 빌드 (시뮬레이터)
flutter build ios

# 실제 디바이스에서 테스트하려면 Xcode 필요
```

## 📋 현재 상태 요약

### ✅ 즉시 가능한 작업
- [x] Android Debug APK 빌드 및 테스트
- [x] iOS 시뮬레이터 빌드
- [x] Firebase 연동 확인

### ⚠️ 스토어 배포 전 필수 작업
- [ ] Android 서명 키 생성 및 설정
- [ ] Apple Developer 계정 설정
- [ ] 앱 아이콘 커스터마이징
- [ ] 앱 정보 작성 (이름, 설명, 스크린샷)

### 💡 권장 사항
- [ ] 앱 버전 관리 (`pubspec.yaml`)
- [ ] 개인정보처리방침 작성
- [ ] Firebase 보안 규칙 검토
- [ ] 성능 최적화 (필요한 경우)

## 🎯 결론

**현재 상태:**
- ✅ **기본 기능**: 모두 정상 작동
- ✅ **Firebase 연동**: 완료
- ✅ **테스트 빌드**: 가능
- ⚠️ **스토어 배포**: 추가 설정 필요

**즉시 가능:**
- Android APK 빌드 및 테스트 (Debug/Release)
- iOS 빌드 및 시뮬레이터 테스트

**스토어 배포 전 필요:**
1. Android 서명 키 설정 (약 10분)
2. 앱 아이콘 및 스토어 정보 작성 (1-2시간)
3. Firebase 보안 규칙 검토 (30분)

**추정 시간:**
- 테스트 빌드: 즉시 가능
- 스토어 배포 준비: 2-3시간

