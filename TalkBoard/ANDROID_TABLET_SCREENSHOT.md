# 📸 Android 태블릿 스크린샷 촬영 가이드

## 🎯 목적

Google Play Store에 태블릿용 스크린샷을 추가하면 태블릿 사용자에게 앱을 더 잘 보여줄 수 있습니다. (선택사항이지만 권장)

## 📏 태블릿 스크린샷 크기

### Google Play Store 요구사항
- **태블릿 스크린샷**: 선택사항 (하지만 권장)
- **권장 크기**: 
  - 7인치 태블릿: 1024x600px (16:9)
  - 10인치 태블릿: 1280x800px (16:10)
  - 7인치 태블릿 (세로): 600x1024px (9:16)
  - 10인치 태블릿 (세로): 800x1280px (10:16)

## 🚀 방법 1: Android 태블릿 에뮬레이터 생성 (권장)

### 1단계: Android Studio에서 태블릿 에뮬레이터 생성

1. **Android Studio 실행**
2. **Tools** → **Device Manager** (또는 **AVD Manager**)
3. **Create Device** 클릭
4. **Tablet** 카테고리 선택
5. 원하는 태블릿 선택:
   - **Pixel Tablet** (10인치)
   - **Nexus 10** (10인치)
   - **Nexus 7** (7인치)
   - 기타 태블릿 선택
6. **Next** 클릭
7. **시스템 이미지 선택** (예: API 33, API 34)
8. **Finish** 클릭

### 2단계: 태블릿 에뮬레이터 실행

```bash
# Android Studio에서 에뮬레이터 실행
# 또는 터미널에서:
emulator -avd <태블릿_에뮬레이터_이름>

# 실행 중인 에뮬레이터 확인
adb devices
```

### 3단계: 앱 실행 및 스크린샷 촬영

```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard

# 태블릿 에뮬레이터에서 앱 실행
flutter run --release -d <태블릿_에뮬레이터_디바이스_ID>

# 스크린샷 촬영
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png screenshots/android/tablet_01_post_list.png
adb shell rm /sdcard/screenshot.png
```

## 🚀 방법 2: 기존 에뮬레이터 크기 조정 (빠른 방법)

기존 Android 에뮬레이터의 해상도를 태블릿 크기로 변경할 수도 있습니다.

### 1단계: 에뮬레이터 설정 변경

1. **Android Studio** → **Tools** → **AVD Manager**
2. 기존 에뮬레이터 선택 → **Edit** (연필 아이콘)
3. **Advanced Settings** 클릭
4. **Resolution** 섹션에서:
   - **Custom** 선택
   - Width: `1280` (또는 `1024`)
   - Height: `800` (또는 `600`)
   - 또는 태블릿 해상도 설정
5. **Finish** 클릭

### 2단계: 에뮬레이터 재시작

```bash
# 에뮬레이터 재시작
adb kill-server
adb start-server

# 또는 Android Studio에서 에뮬레이터 재시작
```

### 3단계: 앱 실행 및 스크린샷

```bash
flutter run --release -d <에뮬레이터_ID>
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png screenshots/android/tablet_01_post_list.png
```

## 🚀 방법 3: 실제 Android 태블릿 사용

### 1단계: USB 디버깅 활성화

1. 태블릿에서 **설정** → **휴대전화 정보**
2. **빌드 번호**를 7번 탭 (개발자 모드 활성화)
3. **설정** → **개발자 옵션**
4. **USB 디버깅** 활성화

### 2단계: 태블릿 연결 및 확인

```bash
# USB로 태블릿 연결
adb devices

# 태블릿이 목록에 표시되는지 확인
```

### 3단계: 앱 실행 및 스크린샷

```bash
flutter run --release -d <태블릿_디바이스_ID>

# 태블릿에서 앱 사용
# 스크린샷 촬영
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png screenshots/android/tablet_01_post_list.png
```

## 📱 촬영할 화면 (태블릿용)

태블릿 스크린샷도 스마트폰과 동일한 화면을 촬영하세요:

1. **게시글 목록 화면** (가로 모드 권장)
2. **게시글 상세 + 댓글 화면** (가로 모드 권장)
3. **로그인/회원가입 화면** (선택)

### 태블릿의 장점 활용
- **가로 모드**: 태블릿의 넓은 화면을 활용한 레이아웃 촬영
- **멀티 컬럼**: 태블릿에서 목록과 상세를 함께 보여주는 화면 (있다면)

## 📁 저장 위치

```
TalkBoard/screenshots/android/
├── 01_post_list.png          # 스마트폰용 (필수)
├── 02_post_detail.png        # 스마트폰용 (필수)
├── tablet_01_post_list.png   # 태블릿용 (선택)
└── tablet_02_post_detail.png # 태블릿용 (선택)
```

## 🎯 빠른 가이드 (5분 안에)

### Android Studio 사용 (가장 쉬움) ⭐

1. **Android Studio** → **Tools** → **Device Manager**
2. **Create Device** 클릭
3. **Tablet** → **Pixel Tablet** 선택
4. **Next** → 시스템 이미지 선택 → **Finish**
5. 에뮬레이터 실행
6. `flutter run --release` 실행
7. 각 화면에서 스크린샷 촬영

### ADB로 빠르게 촬영

```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard

# 태블릿 에뮬레이터 실행 후
flutter run --release -d <태블릿_디바이스_ID>

# 게시글 목록 화면
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png screenshots/android/tablet_01_post_list.png
adb shell rm /sdcard/screenshot.png

# 게시글 상세 화면
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png screenshots/android/tablet_02_post_detail.png
adb shell rm /sdcard/screenshot.png
```

## ⚠️ 주의사항

### 필수 vs 선택
- **스마트폰 스크린샷**: 필수 (최소 2개)
- **태블릿 스크린샷**: 선택사항 (권장)

### 화면 방향
- 태블릿은 **가로 모드**로 촬영하는 것이 일반적
- 태블릿의 넓은 화면을 활용한 레이아웃을 보여줄 수 있음

## 💡 팁

1. **에뮬레이터 해상도 확인**: 태블릿 에뮬레이터의 실제 해상도 확인
2. **가로 모드**: 태블릿은 가로 모드로 촬영하면 더 전문적으로 보임
3. **레이아웃 확인**: 태블릿에서 앱 레이아웃이 제대로 보이는지 확인

## ✅ 체크리스트

### 태블릿 스크린샷 (선택사항)
- [ ] 태블릿 에뮬레이터 생성 또는 실제 태블릿 준비
- [ ] 게시글 목록 화면 촬영 (가로 모드)
- [ ] 게시글 상세 + 댓글 화면 촬영 (가로 모드)
- [ ] `screenshots/android/tablet_*.png`로 저장

### 필수 스크린샷 (스마트폰)
- [ ] 게시글 목록 화면 (스마트폰)
- [ ] 게시글 상세 + 댓글 화면 (스마트폰)

## 🎯 결론

**태블릿 스크린샷은 선택사항**이지만, Google Play Store에 태블릿용 스크린샷을 추가하면:
- ✅ 태블릿 사용자에게 더 나은 경험 제공
- ✅ 앱의 다양한 화면 크기 지원을 보여줌
- ✅ 더 전문적인 앱 스토어 등록 정보

**우선순위:**
1. **스마트폰 스크린샷** (필수) - 먼저 완료
2. **태블릿 스크린샷** (선택) - 나중에 추가 가능

