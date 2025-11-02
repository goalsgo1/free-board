# Android 스크린샷 촬영 명령어 모음

## 📸 Android 스크린샷 촬영 5가지 방법

### 1. ADB 명령어로 직접 저장 (가장 빠름) ⭐ 권장

```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard

# 기본 명령어
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png screenshots/android/01_login.png

# 또는 한 줄로
adb shell screencap -p | sed 's/\r$//' > screenshots/android/01_login.png
```

**특징:**
- ✅ 가장 빠르고 직접적
- ✅ 파일 경로 지정 가능
- ✅ 즉시 컴퓨터에 저장

### 2. ADB 명령어 (단계별)

```bash
# 1단계: 디바이스 연결 확인
adb devices

# 2단계: 스크린샷 촬영 (디바이스 내부 저장)
adb shell screencap -p /sdcard/screenshot.png

# 3단계: PC로 복사
adb pull /sdcard/screenshot.png screenshots/android/01_login.png

# 4단계: 디바이스에서 삭제 (선택)
adb shell rm /sdcard/screenshot.png
```

**특징:**
- ✅ 단계별로 확인 가능
- ✅ 안정적

### 3. 디바이스 물리 버튼 + 복사

```bash
# 디바이스에서 전원 버튼 + 볼륨 다운으로 스크린샷 촬영
# 그 다음 자동으로 PC로 복사
adb pull /sdcard/Pictures/Screenshots/Screenshot_$(date +%Y%m%d_%H%M%S).png screenshots/android/
```

**특징:**
- ✅ 디바이스 자동 저장 경로 사용
- ✅ 날짜/시간 포함 파일명

### 4. 자동화 스크립트 (여러 스크린샷)

```bash
#!/bin/bash
# screenshot_android.sh

cd /Users/haemin/Documents/GitHub/project/TalkBoard/screenshots/android/

echo "Android 스크린샷을 촬영합니다..."

# 로그인 화면
read -p "로그인 화면 준비됨? (Enter): "
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png 01_login.png
adb shell rm /sdcard/screenshot.png
echo "✅ 로그인 화면 저장됨"

# 게시글 목록
read -p "게시글 목록 준비됨? (Enter): "
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png 02_list.png
adb shell rm /sdcard/screenshot.png
echo "✅ 게시글 목록 저장됨"

# 게시글 상세
read -p "게시글 상세 준비됨? (Enter): "
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png 03_detail.png
adb shell rm /sdcard/screenshot.png
echo "✅ 게시글 상세 저장됨"

# 댓글 화면
read -p "댓글 화면 준비됨? (Enter): "
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png 04_comment.png
adb shell rm /sdcard/screenshot.png
echo "✅ 댓글 화면 저장됨"

echo "완료!"
```

### 5. 일회성 명령어 (이름 변경 포함)

```bash
# 스크린샷 촬영 및 이름 변경을 한 번에
adb shell screencap -p /sdcard/screenshot.png && \
adb pull /sdcard/screenshot.png screenshots/android/01_login.png && \
adb shell rm /sdcard/screenshot.png
```

**특징:**
- ✅ 한 줄로 모든 작업 완료
- ✅ 임시 파일 자동 삭제

## 🚀 가장 빠른 방법 (권장)

### 프로젝트 폴더에서 실행

```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard

# 각 화면에서 실행
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png screenshots/android/01_login.png
adb shell rm /sdcard/screenshot.png
```

### 한 줄 명령어

```bash
adb shell screencap -p /sdcard/screenshot.png && adb pull /sdcard/screenshot.png screenshots/android/01_login.png && adb shell rm /sdcard/screenshot.png
```

## 📋 체크리스트

### 사전 확인
- [ ] Android 디바이스 연결 확인: `adb devices`
- [ ] 디바이스가 연결되어 있는지 확인 (unauthorized가 아닌 device로 표시)

### 스크린샷 촬영 순서
1. [ ] 앱 실행 (`flutter run --release`)
2. [ ] 원하는 화면으로 이동
3. [ ] 터미널에서 명령어 실행
4. [ ] 파일이 저장되었는지 확인: `ls screenshots/android/`

## 💡 유용한 팁

### 디바이스 확인
```bash
# 연결된 디바이스 확인
adb devices

# 특정 디바이스 선택 (여러 디바이스 연결 시)
adb -s <device-id> shell screencap -p /sdcard/screenshot.png
```

### 파일 확인
```bash
# 저장된 파일 확인
ls -lh screenshots/android/

# 파일 크기 확인
du -h screenshots/android/*.png
```

### 에러 해결
```bash
# ADB 서버 재시작
adb kill-server
adb start-server

# 디바이스 재연결
adb reconnect
```

## ⚠️ 주의사항

1. **디바이스 연결**: USB 디버깅이 활성화되어 있어야 합니다
2. **파일 경로**: 명령어 실행 전 `cd`로 프로젝트 폴더로 이동
3. **권한**: `/sdcard/` 경로는 접근 가능해야 합니다

