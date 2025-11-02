# 🔧 iOS 실제 디바이스 실행 가이드

## 현재 오류

실제 iPhone에서 앱을 실행하려고 할 때 다음 오류가 발생했습니다:

1. **PLA Update 오류**: Apple Developer 계정에서 최신 Program License Agreement에 동의해야 합니다.
2. **Provisioning Profile 없음**: 새로운 Bundle ID `com.talkboard.app`에 대한 provisioning profile이 없습니다.

## 해결 방법

### 방법 1: Apple Developer 계정 설정 (실제 디바이스 실행용)

#### 1단계: Apple Developer 계정에서 PLA 동의

1. **Apple Developer 웹사이트 접속**
   - https://developer.apple.com 접속
   - Apple ID로 로그인

2. **Program License Agreement 동의**
   - 계정 설정 → Agreements, Tax, and Banking
   - 최신 Program License Agreement가 있으면 동의

#### 2단계: Xcode에서 Provisioning Profile 생성

1. **Xcode 실행**
   ```bash
   cd /Users/haemin/Documents/GitHub/project/TalkBoard
   open ios/Runner.xcworkspace
   ```

2. **Signing & Capabilities 설정**
   - 왼쪽 네비게이터에서 **Runner** 프로젝트 선택
   - **TARGETS** → **Runner** 선택
   - **Signing & Capabilities** 탭 선택
   - **Automatically manage signing** 체크
   - **Team** 선택 (Apple Developer 계정)
   - Xcode가 자동으로 provisioning profile을 생성합니다

3. **Bundle Identifier 확인**
   - Bundle Identifier가 `com.talkboard.app`인지 확인
   - 다른 값이면 `com.talkboard.app`로 변경

#### 3단계: 디바이스에서 실행

1. **iPhone 연결**: USB로 iPhone을 Mac에 연결
2. **신뢰 설정**: iPhone에서 "이 컴퓨터를 신뢰하시겠습니까?" → **신뢰**
3. **앱 실행**: Xcode에서 디바이스 선택 후 실행

### 방법 2: iOS 시뮬레이터 사용 (권장 - 개발/테스트용)

실제 디바이스 설정이 복잡하다면, iOS 시뮬레이터에서 테스트할 수 있습니다:

```bash
# iOS 시뮬레이터 선택 (iPhone 16 Plus)
flutter run -d 515154F8-7B1B-4173-8FFC-C58008DE351F

# 또는 시뮬레이터 목록에서 선택
flutter run
# 그 다음 3번 (iPhone 16 Plus) 선택
```

### 방법 3: Android 에뮬레이터 사용 (가장 쉬움)

Android 에뮬레이터는 개발자 계정 없이 바로 사용 가능합니다:

```bash
flutter run
# 그 다음 1번 (sdk gphone64 arm64) 선택
```

## 권장 순서

### 즉시 테스트 (권장)
1. **Android 에뮬레이터** 사용 (가장 간단)
   ```bash
   flutter run -d emulator-5554
   ```

2. **iOS 시뮬레이터** 사용
   ```bash
   flutter run -d 515154F8-7B1B-4173-8FFC-C58008DE351F
   ```

### 실제 디바이스 테스트 (나중에)
1. Apple Developer 계정에서 PLA 동의
2. Xcode에서 provisioning profile 생성
3. 실제 디바이스에서 실행

## 참고사항

### Apple Developer 계정
- **무료 계정**: 개발자 등록 없이 테스트 가능 (제한적)
- **유료 계정 ($99/년)**: App Store 배포 및 모든 기능 사용 가능

### Provisioning Profile
- 새로운 Bundle ID (`com.talkboard.app`)로 변경했으므로 새로 생성해야 합니다
- Xcode에서 "Automatically manage signing"을 체크하면 자동으로 생성됩니다

## 빠른 해결책

**지금 당장 앱을 테스트하려면:**

```bash
# Android 에뮬레이터에서 실행 (권장)
flutter run -d emulator-5554

# 또는 iOS 시뮬레이터에서 실행
flutter run -d 515154F8-7B1B-4173-8FFC-C58008DE351F
```

실제 iPhone에서 실행하려면 위의 "방법 1"을 따라하세요.

