# Flutter 앱 실행 모드 가이드

## 🚀 실행 모드 종류

### 1. 디버그 모드 (Debug Mode)
- 개발 및 테스트용
- Hot Reload 지원
- 디버깅 도구 사용 가능
- 성능 최적화 없음
- 개발용 버튼 표시 (예: 샘플 데이터 입력 버튼)

### 2. 릴리즈 모드 (Release Mode)
- 프로덕션 배포용
- 성능 최적화 적용
- 디버깅 도구 제거
- 개발용 버튼 숨김 (스크린샷 촬영에 적합)
- 실제 사용자 환경과 동일

## 📱 실행 방법

### 디버그 모드 실행

#### 방법 1: 터미널 명령어
```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard
flutter run
```

#### 방법 2: 플랫폼 지정
```bash
# Android
flutter run -d android

# iOS
flutter run -d ios

# 웹
flutter run -d chrome
```

#### 방법 3: 디바이스 선택
```bash
# 사용 가능한 디바이스 확인
flutter devices

# 특정 디바이스 선택
flutter run -d <device-id>
```

### 릴리즈 모드 실행

#### 방법 1: 기본 명령어
```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard
flutter run --release
```

#### 방법 2: 플랫폼 지정
```bash
# Android
flutter run --release -d android

# iOS
flutter run --release -d ios

# 웹
flutter run --release -d chrome
```

## 🔍 모드별 차이점

### 디버그 모드
- ✅ Hot Reload 가능 (코드 변경 시 즉시 반영)
- ✅ 디버깅 도구 사용 가능
- ✅ 개발용 버튼 표시 (샘플 데이터 입력 버튼 등)
- ✅ 상세한 에러 메시지
- ❌ 성능이 느림
- ❌ 앱 크기가 큼

### 릴리즈 모드
- ✅ 최적화된 성능
- ✅ 작은 앱 크기
- ✅ 프로덕션 환경과 동일
- ✅ 개발용 버튼 숨김 (스크린샷 촬영에 적합)
- ❌ Hot Reload 불가
- ❌ 디버깅 도구 제한적

## 📸 스크린샷 촬영을 위한 실행

### 권장 방법: 릴리즈 모드
```bash
flutter run --release
```

**이유:**
- 개발용 버튼이 보이지 않음
- 실제 앱과 동일한 상태
- 스크린샷이 더 깔끔함

### 단계별 가이드

#### 1단계: 앱 실행
```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard
flutter run --release
```

#### 2단계: 스크린샷 촬영
- 회원가입 화면: 수동으로 입력 (버튼 없음)
- 로그인 화면: 수동으로 입력 (버튼 없음)
- 게시글 목록: 샘플 데이터 생성 후 촬영
- 게시글 상세: 게시글 클릭 후 촬영
- 댓글 화면: 게시글 상세에서 촬영

## 🛠️ 개발 시 권장 워크플로우

### 1. 개발 중
```bash
flutter run
```
- Hot Reload로 빠른 개발
- 디버깅 도구 사용
- 개발용 버튼 활용

### 2. 테스트 중
```bash
flutter run --release
```
- 릴리즈 모드로 최종 테스트
- 성능 확인
- 실제 환경과 동일하게 테스트

### 3. 스크린샷 촬영
```bash
flutter run --release
```
- 릴리즈 모드로 실행
- 개발용 버튼 숨김
- 깔끔한 스크린샷 촬영

## 💡 유용한 명령어

### 디바이스 확인
```bash
flutter devices
```

### 실행 중인 앱 종료
```bash
# 터미널에서 'q' 키 입력
# 또는 Ctrl+C
```

### 앱 다시 빌드
```bash
flutter run --release --no-hot-reload
```

### 빌드 확인
```bash
flutter build apk --release      # Android APK
flutter build appbundle --release # Android AAB
flutter build ios --release      # iOS
```

## ⚠️ 주의사항

1. **스크린샷 촬영**: 반드시 릴리즈 모드로 실행
2. **개발 작업**: 디버그 모드로 실행하여 Hot Reload 활용
3. **성능 테스트**: 릴리즈 모드로 실행

## 📋 체크리스트

### 스크린샷 촬영 전
- [ ] 릴리즈 모드로 실행 (`flutter run --release`)
- [ ] 개발용 버튼이 보이지 않는지 확인
- [ ] 샘플 데이터 생성 완료

### 개발 중
- [ ] 디버그 모드로 실행 (`flutter run`)
- [ ] Hot Reload 활용
- [ ] 개발용 버튼으로 빠른 테스트

