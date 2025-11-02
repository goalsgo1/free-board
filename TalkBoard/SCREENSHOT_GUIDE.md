# 스크린샷 촬영 가이드

## 📸 스크린샷 촬영 방법

### Android

#### 방법 1: ADB 명령어로 직접 저장 (권장) ⭐
```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard

# 기본 명령어 (3단계)
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png screenshots/android/01_login.png
adb shell rm /sdcard/screenshot.png

# 또는 한 줄로
adb shell screencap -p /sdcard/screenshot.png && \
adb pull /sdcard/screenshot.png screenshots/android/01_login.png && \
adb shell rm /sdcard/screenshot.png
```

**자세한 내용**: [ANDROID_SCREENSHOT_COMMANDS.md](ANDROID_SCREENSHOT_COMMANDS.md) 참고

#### 방법 2: 디바이스 연결 확인 후 촬영
```bash
# 디바이스 연결 확인
adb devices

# 스크린샷 촬영 및 복사
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png screenshot.png
```

#### 방법 2: Android Studio 에뮬레이터
1. Android Studio에서 에뮬레이터 실행
2. 에뮬레이터에서 스크린샷 버튼 클릭
3. 스크린샷 저장

#### 방법 3: Flutter 앱 실행 후 수동 촬영
```bash
# 릴리즈 모드로 앱 실행
flutter run --release

# 디바이스에서 직접 스크린샷 촬영
# Android: 전원 버튼 + 볼륨 다운
```

### iOS

#### 방법 1: 터미널 명령어로 스크린샷 (권장)
```bash
# 시뮬레이터 실행
open -a Simulator

# 앱 실행
flutter run --release

# 시뮬레이터에서 스크린샷 촬영 및 파일로 저장
xcrun simctl io booted screenshot screenshot.png

# 또는 특정 경로에 저장
xcrun simctl io booted screenshot ~/Desktop/screenshot.png

# TalkBoard 스크린샷 폴더에 저장
xcrun simctl io booted screenshot screenshots/ios/01_login.png
```

#### 방법 2: 시뮬레이터 내에서 스크린샷 촬영
1. 시뮬레이터에서 `Cmd + S` (또는 Device > Screenshot)
2. 스크린샷이 데스크톱에 자동으로 저장됨
3. 파일 이름: `Simulator Screen Shot - [날짜] - at [시간].png`

#### 방법 3: 시뮬레이터 Photos 앱에서 내보내기
1. 시뮬레이터에서 Photos 앱 열기
2. 스크린샷 선택
3. 하단 공유 버튼(↑ 아이콘) 클릭
4. "Save to Files" 또는 "AirDrop" 선택
5. Mac으로 저장

#### 방법 2: Xcode를 통한 촬영
1. Xcode에서 시뮬레이터 실행
2. Product > Scheme > Edit Scheme
3. Run > Options에서 스크린샷 설정

#### 방법 3: 실제 디바이스 사용
```bash
# 앱 실행
flutter run --release

# 디바이스에서 직접 스크린샷 촬영
# iPhone: 전원 버튼 + 볼륨 업
```

## 📋 촬영할 화면 추천

### 필수 화면 (최소)
1. **로그인/회원가입 화면**
   - 앱의 첫 인상을 보여줍니다

2. **게시글 목록 화면**
   - 앱의 핵심 기능을 보여줍니다

### 권장 화면 (5개 이상)
1. **로그인/회원가입 화면**
   - 사용자 인증 프로세스

2. **게시글 목록 화면**
   - 메인 화면, 게시글 목록

3. **게시글 상세 화면**
   - 게시글 내용 및 조회수

4. **댓글 화면**
   - 댓글 및 대댓글 기능

5. **게시글 작성 화면**
   - 게시글 작성 프로세스

## 🎨 스크린샷 최적화 팁

### 1. 일관된 스타일
- 동일한 디바이스 크기 사용
- 동일한 상태 유지 (다크 모드 등)

### 2. 주요 기능 강조
- 텍스트 오버레이 추가 가능
- 화살표나 설명 추가

### 3. 실제 사용 흐름
- 로그인 → 목록 → 상세 → 댓글 순서

### 4. 해상도 확인
- Android: 1080x1920px (9:16) 또는 1920x1080px (16:9)
- iOS: 1284x2778px (6.5인치 iPhone) 권장

## 📐 크기 요구사항

### Google Play Store
- **최소 크기**: 320px (짧은 변)
- **최대 크기**: 3840px (긴 변)
- **비율**: 16:9 또는 9:16
- **형식**: PNG 또는 JPEG
- **투명 배경**: 불가
- **최소 개수**: 2개 (휴대폰)

### Apple App Store
- **6.5인치 iPhone**: 1284x2778px (권장)
- **5.5인치 iPhone**: 1242x2208px
- **형식**: PNG 또는 JPEG
- **투명 배경**: 불가
- **최소 개수**: 1개

## 🚀 빠른 시작

### 1. 앱 실행 (릴리즈 모드 권장)

#### 릴리즈 모드 실행 (스크린샷 촬영용 - 권장)
```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard

# Android
flutter run --release

# iOS
flutter run --release -d ios
```

**릴리즈 모드의 장점:**
- 개발용 버튼이 보이지 않음
- 실제 앱과 동일한 상태
- 더 깔끔한 스크린샷

#### 디버그 모드 실행 (개발용)
```bash
# Android
flutter run

# iOS
flutter run -d ios
```

**디버그 모드의 특징:**
- Hot Reload 지원
- 개발용 버튼 표시 (예: 샘플 데이터 입력 버튼)
- 디버깅 도구 사용 가능

**참고**: 자세한 내용은 [RUN_MODE_GUIDE.md](RUN_MODE_GUIDE.md)를 참고하세요.

### 2. 주요 화면 순서대로 방문
1. 로그인 화면
2. 게시글 목록
3. 게시글 작성
4. 게시글 상세
5. 댓글 화면

### 3. 스크린샷 촬영
- 각 화면에서 스크린샷 촬영
- 파일명: `screenshot_01_login.png`, `screenshot_02_list.png` 등

### 4. 파일 정리
```bash
# 스크린샷 폴더 생성 (선택)
mkdir -p screenshots/android
mkdir -p screenshots/ios

# 스크린샷 이동
mv screenshot*.png screenshots/
```

## 💡 스크린샷 편집 도구 (선택)

1. **Figma**: 무료 디자인 도구
2. **Canva**: 온라인 디자인 도구
3. **Sketch**: Mac 전용 디자인 도구

## ✅ 체크리스트

### Android
- [ ] 로그인 화면 스크린샷
- [ ] 게시글 목록 스크린샷
- [ ] 게시글 상세 스크린샷
- [ ] 댓글 화면 스크린샷
- [ ] 최소 2개 이상 준비
- [ ] 권장 크기 확인 (1080x1920px 또는 1920x1080px)

### iOS
- [ ] 로그인 화면 스크린샷
- [ ] 게시글 목록 스크린샷
- [ ] 게시글 상세 스크린샷
- [ ] 최소 1개 이상 준비
- [ ] 권장 크기 확인 (1284x2778px)

## 📝 파일명 규칙 (선택)

```
screenshots/
├── android/
│   ├── 01_login.png
│   ├── 02_list.png
│   ├── 03_detail.png
│   ├── 04_comment.png
│   └── 05_create.png
└── ios/
    ├── 01_login.png
    ├── 02_list.png
    ├── 03_detail.png
    ├── 04_comment.png
    └── 05_create.png
```

## 🎯 다음 단계

1. 스크린샷 촬영 완료
2. 스크린샷 크기 확인 및 조정
3. 앱 스토어에 업로드
4. 스토어 등록 정보 작성 (STORE_LISTING_TEMPLATE.md 참고)

