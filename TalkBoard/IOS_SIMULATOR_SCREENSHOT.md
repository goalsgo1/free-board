# iOS 시뮬레이터 스크린샷 가이드

## 📸 iOS 시뮬레이터에서 스크린샷 촬영 및 내보내기

### 방법 1: 터미널 명령어로 직접 저장 (가장 빠름) ⭐ 권장

#### 기본 명령어
```bash
xcrun simctl io booted screenshot screenshot.png
```

#### 프로젝트 폴더에 저장
```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard

# iOS 스크린샷 폴더에 저장
xcrun simctl io booted screenshot screenshots/ios/01_login.png
xcrun simctl io booted screenshot screenshots/ios/02_list.png
xcrun simctl io booted screenshot screenshots/ios/03_detail.png
xcrun simctl io booted screenshot screenshots/ios/04_comment.png
```

#### 데스크톱에 저장
```bash
xcrun simctl io booted screenshot ~/Desktop/screenshot.png
```

#### 현재 디렉토리에 저장
```bash
xcrun simctl io booted screenshot ./screenshot.png
```

**장점:**
- ✅ 가장 빠름
- ✅ 파일 경로 지정 가능
- ✅ 한 번의 명령으로 완료

### 방법 2: 시뮬레이터 메뉴 사용

#### 스크린샷 촬영
1. 시뮬레이터 실행 중
2. **`Cmd + S`** (또는 Device > Screenshot)
3. 스크린샷이 **데스크톱에 자동 저장**됨

#### 저장 위치
- **기본 위치**: `~/Desktop/`
- **파일명 형식**: `Simulator Screen Shot - [날짜] - at [시간].png`
- 예: `Simulator Screen Shot - Nov 2, 2025 - at 9.30.00 PM.png`

#### 파일 이동
```bash
# 데스크톱에서 프로젝트 폴더로 이동
mv ~/Desktop/"Simulator Screen Shot"*.png screenshots/ios/
```

**장점:**
- ✅ 간단함
- ✅ GUI 사용 가능
- ❌ 파일 이름 자동 생성 (수동으로 이름 변경 필요)

### 방법 3: 시뮬레이터 Photos 앱에서 내보내기

#### 단계별 가이드

1. **스크린샷 촬영**
   - 시뮬레이터에서 `Cmd + S`로 스크린샷 촬영
   - 또는 앱 내에서 스크린샷 기능 사용

2. **Photos 앱 열기**
   - 시뮬레이터에서 Photos 앱 실행
   - 스크린샷 섹션 찾기

3. **스크린샷 선택**
   - 원하는 스크린샷 선택

4. **공유 버튼 클릭**
   - 하단 툴바에서 **공유 아이콘 (↑)** 클릭

5. **내보내기 방법 선택**
   - **"Save to Files"** 선택 → Mac 파일 시스템에 저장
   - 또는 **"AirDrop"** 선택 → Mac으로 전송

**장점:**
- ✅ 시뮬레이터 내에서 직접 관리
- ✅ 여러 스크린샷 한 번에 선택 가능
- ❌ 절차가 다소 복잡

### 방법 4: 드래그 앤 드롭 (간단)

1. 시뮬레이터에서 `Cmd + S`로 스크린샷 촬영
2. 데스크톱에 저장된 파일 찾기
3. Finder에서 원하는 폴더로 드래그 앤 드롭

## 🚀 빠른 시작 (권장 방법)

### 1단계: 스크린샷 폴더 확인
```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard
ls screenshots/ios/
```

### 2단계: 앱 실행
```bash
flutter run --release -d ios
```

### 3단계: 각 화면에서 스크린샷 촬영
```bash
# 다른 터미널 창에서 실행 (앱은 계속 실행 중)

# 로그인 화면
xcrun simctl io booted screenshot screenshots/ios/01_login.png

# 게시글 목록 화면
xcrun simctl io booted screenshot screenshots/ios/02_list.png

# 게시글 상세 화면
xcrun simctl io booted screenshot screenshots/ios/03_detail.png

# 댓글 화면
xcrun simctl io booted screenshot screenshots/ios/04_comment.png
```

## 📋 파일 저장 위치 추천

### 권장 폴더 구조
```
TalkBoard/screenshots/
├── android/
│   ├── 01_login.png
│   ├── 02_list.png
│   ├── 03_detail.png
│   └── 04_comment.png
└── ios/
    ├── 01_login.png
    ├── 02_list.png
    ├── 03_detail.png
    └── 04_comment.png
```

### 한 번에 여러 스크린샷 저장
```bash
# 스크린샷 폴더로 이동
cd screenshots/ios/

# 여러 스크린샷 촬영
xcrun simctl io booted screenshot 01_login.png
# (화면 전환 후)
xcrun simctl io booted screenshot 02_list.png
# (화면 전환 후)
xcrun simctl io booted screenshot 03_detail.png
```

## 💡 팁

### 1. 시뮬레이터 확인
```bash
# 실행 중인 시뮬레이터 확인
xcrun simctl list devices | grep Booted
```

### 2. 특정 시뮬레이터에서 촬영
```bash
# 시뮬레이터 ID 확인
xcrun simctl list devices

# 특정 시뮬레이터에서 스크린샷
xcrun simctl io <simulator-id> screenshot screenshot.png
```

### 3. 자동화 스크립트 (선택)
```bash
#!/bin/bash
# screenshot.sh

cd /Users/haemin/Documents/GitHub/project/TalkBoard/screenshots/ios/

echo "스크린샷을 촬영합니다..."
echo "각 화면에서 준비되면 Enter를 누르세요"

read -p "로그인 화면 준비됨? (Enter): "
xcrun simctl io booted screenshot 01_login.png
echo "✅ 로그인 화면 저장됨"

read -p "게시글 목록 준비됨? (Enter): "
xcrun simctl io booted screenshot 02_list.png
echo "✅ 게시글 목록 저장됨"

read -p "게시글 상세 준비됨? (Enter): "
xcrun simctl io booted screenshot 03_detail.png
echo "✅ 게시글 상세 저장됨"

read -p "댓글 화면 준비됨? (Enter): "
xcrun simctl io booted screenshot 04_comment.png
echo "✅ 댓글 화면 저장됨"

echo "완료!"
```

## ⚠️ 주의사항

1. **시뮬레이터 실행 중**: 스크린샷 촬영 전에 시뮬레이터가 실행 중이어야 합니다
2. **파일 경로**: 경로에 공백이 있으면 따옴표로 감싸세요
3. **파일 이름**: 한글 이름은 피하는 것이 좋습니다

## ✅ 체크리스트

### 터미널 명령어 사용 (권장)
- [ ] 시뮬레이터 실행 확인
- [ ] 스크린샷 폴더 생성 확인
- [ ] `xcrun simctl io booted screenshot` 명령어 사용
- [ ] 파일이 올바른 위치에 저장되었는지 확인

### 시뮬레이터 메뉴 사용
- [ ] `Cmd + S`로 스크린샷 촬영
- [ ] 데스크톱에서 파일 확인
- [ ] 원하는 폴더로 이동

## 🎯 가장 빠른 방법

**터미널 명령어 사용:**
```bash
xcrun simctl io booted screenshot screenshots/ios/01_login.png
```

이 명령어 하나면 바로 프로젝트 폴더에 저장됩니다!

