# iOS 빌드 문제 해결 가이드

## 🔴 현재 문제: "Xcode build failed due to concurrent builds"

이 오류는 Xcode가 동시에 여러 빌드 프로세스를 실행하려고 할 때 발생합니다.

### 원인
1. **Xcode가 이미 열려있음**: Xcode에서 프로젝트가 열려있으면 Flutter CLI 빌드가 실패할 수 있음
2. **다른 Flutter 빌드 프로세스 실행 중**: 백그라운드에 다른 빌드가 실행 중일 수 있음
3. **DerivedData 충돌**: Xcode의 빌드 캐시 문제

### 해결 방법

#### 1. 즉시 해결 (빠른 방법)

```bash
# Xcode 종료
# 모든 Xcode 프로세스 종료
killall Xcode

# Flutter 프로세스 확인 및 종료
killall flutter

# 다시 빌드 시도
cd /Users/haemin/Documents/GitHub/project/TalkBoard
flutter clean
flutter pub get
flutter run
```

#### 2. Xcode DerivedData 정리

```bash
# DerivedData 정리 (빌드 캐시 삭제)
rm -rf ~/Library/Developer/Xcode/DerivedData

# Pods 정리 및 재설치
cd /Users/haemin/Documents/GitHub/project/TalkBoard/ios
rm -rf Pods Podfile.lock
pod install

# Flutter 클린
cd ..
flutter clean
flutter pub get
```

#### 3. 프로젝트 폴더 확인

```bash
# iOS 빌드 폴더 정리
cd /Users/haemin/Documents/GitHub/project/TalkBoard
flutter clean
rm -rf ios/build
rm -rf ios/Pods
rm -rf ios/.symlinks

# 재설치
flutter pub get
cd ios && pod install && cd ..
```

## ✅ iOS 설정 확인

### 필수 설정 확인

#### 1. Podfile 설정
- ✅ `platform :ios, '13.0'` 설정 완료

#### 2. Xcode 프로젝트 설정
- ✅ `IPHONEOS_DEPLOYMENT_TARGET = 13.0` 설정 완료

#### 3. Firebase 설정
- ✅ `GoogleService-Info.plist` 파일 있음
- ✅ `firebase_options.dart` 생성됨

#### 4. Bundle ID 확인 필요

```bash
# Bundle ID 확인
grep -r "PRODUCT_BUNDLE_IDENTIFIER" ios/Runner.xcodeproj/project.pbxproj
```

### 추가로 확인할 사항

#### 1. Xcode에서 직접 열기 (권장)
```bash
# Xcode에서 프로젝트 열기
cd /Users/haemin/Documents/GitHub/project/TalkBoard
open ios/Runner.xcworkspace
```

Xcode에서:
1. 상단의 디바이스 선택 (iPhone 16 Plus)
2. Product > Clean Build Folder (Cmd+Shift+K)
3. Product > Build (Cmd+B)
4. Product > Run (Cmd+R)

#### 2. Flutter CLI로 빌드 (간단한 방법)

```bash
# 시뮬레이터 사용 (더 빠름)
flutter run -d ios

# 특정 디바이스 지정
flutter run -d "515154F8-7B1B-4173-8FFC-C58008DE351F"
```

## 🚀 빌드 최적화 팁

### 1. 첫 빌드는 항상 느림
- CocoaPods 설치 및 컴파일: 약 2-5분
- 첫 빌드 후 캐시 생성
- 이후 빌드는 더 빠름 (30초~1분)

### 2. Debug vs Release 빌드
- **Debug**: 빠름 (~1분), 개발용
- **Release**: 느림 (~3-5분), 최적화됨

### 3. 빌드 시간 단축 팁
```bash
# Debug 빌드 사용 (권장)
flutter run --debug

# Hot Reload 사용 (코드 변경 시 빠른 반영)
# 코드 수정 후 저장하면 자동으로 반영됨
```

## 📋 체크리스트

### 빌드 전 확인 사항
- [ ] Xcode가 닫혀있는지 확인
- [ ] 다른 Flutter 프로세스가 실행 중이지 않은지 확인
- [ ] `flutter doctor`에서 모든 설정이 완료되었는지 확인
- [ ] iOS 디바이스/시뮬레이터가 연결되어 있는지 확인

### 문제 해결 순서
1. **Xcode 프로세스 종료**
2. **Flutter 프로세스 종료**
3. **flutter clean 실행**
4. **pod install 재실행**
5. **빌드 재시도**

## ⚠️ 주의사항

- Xcode를 열면 Flutter CLI 빌드가 실패할 수 있음
- 반대로, Flutter CLI로 빌드 중이면 Xcode에서 빌드 실패 가능
- 하나의 빌드 방법만 사용하는 것을 권장

