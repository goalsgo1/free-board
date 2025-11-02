# 앱 아이콘 및 스크린샷 준비 가이드

## 📱 앱 아이콘

### Android 아이콘

**위치**: `android/app/src/main/res/mipmap-*/ic_launcher.png`

**필요한 크기:**
- `mipmap-mdpi/ic_launcher.png`: 48x48px
- `mipmap-hdpi/ic_launcher.png`: 72x72px
- `mipmap-xhdpi/ic_launcher.png`: 96x96px
- `mipmap-xxhdpi/ic_launcher.png`: 144x144px
- `mipmap-xxxhdpi/ic_launcher.png`: 192x192px

**Google Play Store 요구사항:**
- Feature Graphic: 1024x500px PNG (투명 배경 불가)
- 앱 아이콘: 512x512px PNG (투명 배경 불가)

### iOS 아이콘

**위치**: `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

**필요한 크기:**
- 1024x1024px (App Store용)

**현재 상태**: 기본 아이콘 사용 중

### 추천 도구

1. **온라인 도구**
   - [App Icon Generator](https://www.appicon.co/)
   - [Icon Kitchen](https://icon.kitchen/)
   - [MakeAppIcon](https://makeappicon.com/)

2. **Flutter 패키지**
   ```bash
   flutter pub add flutter_launcher_icons
   ```
   
   `pubspec.yaml`에 설정:
   ```yaml
   dev_dependencies:
     flutter_launcher_icons: ^0.13.1
   
   flutter_launcher_icons:
     android: true
     ios: true
     image_path: "assets/icon/app_icon.png"
   ```
   
   실행:
   ```bash
   flutter pub get
   flutter pub run flutter_launcher_icons
   ```

## 📸 스크린샷

### Google Play Store

**최소 요구사항:**
- **휴대폰**: 최소 2개, 권장 8개
- **태블릿**: 권장 4개

**크기 요구사항:**
- **16:9 또는 9:16 비율**
- 최소 크기: 320px (짧은 변)
- 최대 크기: 3840px (긴 변)
- 형식: PNG 또는 JPEG
- 투명 배경: 불가

**추천 크기:**
- 휴대폰: 1080x1920px (9:16) 또는 1920x1080px (16:9)
- 태블릿: 1600x2560px (9:16) 또는 2560x1600px (16:9)

### Apple App Store

**최소 요구사항:**
- **iPhone**: 최소 1개, 권장 3-10개
- **iPad**: 권장 (선택사항)

**크기 요구사항:**
- **6.5인치 iPhone** (권장): 1284x2778px
- **5.5인치 iPhone**: 1242x2208px
- **iPad Pro 12.9인치**: 2048x2732px

**형식**: PNG 또는 JPEG
**투명 배경**: 불가

### 스크린샷 촬영 방법

#### Android
```bash
# 실제 디바이스에서 스크린샷 촬영
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png

# 또는
flutter run --release
# 디바이스에서 스크린샷 촬영
```

#### iOS
```bash
# 시뮬레이터에서 스크린샷 촬영
xcrun simctl io booted screenshot screenshot.png

# 또는
# Xcode > Product > Scheme > Edit Scheme > Run > Options
# 또는 디바이스에서 직접 촬영
```

### 추천 스크린샷 구성

1. **로그인 화면**
2. **게시글 목록 화면**
3. **게시글 상세 화면**
4. **댓글 화면**
5. **게시글 작성 화면**

## 🎨 디자인 가이드

### 색상 팔레트
- 주 색상: Blue (#2196F3)
- 배경: White
- 텍스트: Dark Gray

### 텍스트
- 앱 이름: **TalkBoard**
- 슬로건: "자유롭게 소통하는 게시판"

## 📋 체크리스트

### 앱 아이콘
- [ ] Android 아이콘 5개 크기 생성
- [ ] iOS 아이콘 1024x1024px 생성
- [ ] Google Play Store Feature Graphic 생성 (1024x500px)
- [ ] Google Play Store 아이콘 생성 (512x512px)

### 스크린샷
- [ ] Android 휴대폰 스크린샷 2개 이상
- [ ] Android 태블릿 스크린샷 (선택)
- [ ] iOS iPhone 스크린샷 1개 이상
- [ ] iOS iPad 스크린샷 (선택)

### 메타데이터
- [ ] 앱 이름: TalkBoard
- [ ] 짧은 설명 (140자 이내)
- [ ] 긴 설명 (4000자 이내)
- [ ] 키워드 (iOS용, 100자 이내)

## 🚀 빠른 시작

### 1. 간단한 아이콘 생성

1. **온라인 도구 사용**:
   - [AppIcon.co](https://www.appicon.co/) 방문
   - 1024x1024px 아이콘 이미지 업로드
   - 모든 플랫폼 아이콘 자동 생성

2. **생성된 아이콘 다운로드 및 적용**:
   - Android: `android/app/src/main/res/mipmap-*/ic_launcher.png` 교체
   - iOS: `ios/Runner/Assets.xcassets/AppIcon.appiconset/` 교체

### 2. 스크린샷 촬영

```bash
# 앱 실행
flutter run --release

# 주요 화면에서 스크린샷 촬영
# - 로그인 화면
# - 게시글 목록
# - 게시글 상세
# - 댓글 화면
```

## 💡 팁

1. **아이콘 디자인**
   - 단순하고 명확한 디자인
   - 작은 크기에서도 알아볼 수 있어야 함
   - 브랜드 색상 사용

2. **스크린샷 최적화**
   - 실제 사용 흐름을 보여주기
   - 주요 기능 강조
   - 텍스트 오버레이 추가 가능 (선택)

3. **일관성 유지**
   - 모든 스크린샷에서 동일한 스타일
   - 동일한 기기 크기 사용

