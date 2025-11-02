# Android App Bundle 업로드 가이드

## 📦 App Bundle이란?

Android App Bundle (`.aab` 파일)은 Google Play Store에 앱을 배포하기 위한 파일 형식입니다.

**앱 번들에는 "내용물"을 올리는 게 아닙니다!**
**→ 앱을 빌드하면 생성되는 `.aab` 파일 자체를 업로드하는 것입니다.**

---

## 🚀 App Bundle 생성 및 업로드 방법

### Step 1: App Bundle 빌드

터미널에서 다음 명령어 실행:

```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard

# App Bundle 빌드
flutter build appbundle --release
```

**빌드 시간**: 약 5-10분

**빌드 완료 후 생성되는 파일**:
```
android/app/build/outputs/bundle/release/app-release.aab
```

### Step 2: Google Play Console에서 업로드

1. **좌측 메뉴에서 "테스트 및 출시" 클릭**
2. **"프로덕션"** 또는 **"내부 테스트"** 선택
   - 처음에는 "내부 테스트"부터 시작하는 것을 권장
3. **"새 버전 만들기"** 또는 **"프로덕션 출시"** 버튼 클릭
4. **"App Bundle 또는 APK 업로드"** 섹션에서:
   - **"App Bundle 또는 APK 업로드"** 버튼 클릭
   - 생성된 `app-release.aab` 파일 선택
   - 파일 업로드

---

## 📋 빌드 전 확인사항

### 필수 확인:
- ✅ 앱 버전 확인 (`pubspec.yaml`)
  ```yaml
  version: 1.0.0+1  # 버전 이름 + 빌드 번호
  ```
- ✅ 서명 키 확인 (`android/app/key.jks` 존재)
- ✅ Firebase 설정 확인 (`google-services.json` 존재)

### 권장 확인:
- ✅ 앱이 정상적으로 실행되는지 테스트
- ✅ 릴리즈 모드로 빌드 테스트

---

## 🔧 빌드 명령어 상세

### 기본 빌드:
```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard
flutter build appbundle --release
```

### 빌드 옵션:
```bash
# 특정 플랫폼만 빌드
flutter build appbundle --release --target-platform android-arm64

# 빌드 번호 자동 증가
flutter build appbundle --release --build-number=$(date +%s)
```

### 빌드 파일 확인:
```bash
# 빌드된 파일 위치 확인
ls -lh android/app/build/outputs/bundle/release/app-release.aab

# 파일 크기 확인 (보통 10-20MB)
```

---

## 📤 Google Play Console 업로드 단계

### 1. 테스트 및 출시 페이지로 이동

1. Google Play Console 좌측 메뉴에서 **"테스트 및 출시"** 클릭
2. 하위 메뉴에서 선택:
   - **"내부 테스트"** (권장: 처음 출시 시)
   - **"클로즈드 테스트"** (제한된 사용자 테스트)
   - **"프로덕션"** (전체 사용자 대상 출시)

### 2. 새 버전 만들기

1. **"새 버전 만들기"** 버튼 클릭
2. 또는 **"프로덕션 출시"** 버튼 클릭

### 3. App Bundle 업로드

1. **"App Bundle 또는 APK 업로드"** 섹션 찾기
2. **"App Bundle 또는 APK 업로드"** 버튼 클릭
3. 파일 선택 대화상자에서:
   - `android/app/build/outputs/bundle/release/app-release.aab` 파일 선택
4. 파일 업로드 시작
5. 업로드 완료 대기 (몇 분 소요)

### 4. 업로드 후 설정

업로드 완료 후:
1. **버전 이름 입력** (예: 1.0.0)
2. **릴리즈 노트 작성** (선택사항)
   - 예: "초기 버전 출시"
3. **"검토를 위해 출시"** 또는 **"저장"** 버튼 클릭

---

## ✅ 체크리스트

### 빌드 전:
- [ ] `pubspec.yaml` 버전 확인
- [ ] 서명 키 확인 (`android/app/key.jks`)
- [ ] Firebase 설정 확인
- [ ] 앱 테스트 완료

### 빌드:
- [ ] `flutter build appbundle --release` 실행
- [ ] 빌드 성공 확인
- [ ] `app-release.aab` 파일 확인

### 업로드:
- [ ] Google Play Console → "테스트 및 출시" 클릭
- [ ] "내부 테스트" 또는 "프로덕션" 선택
- [ ] "새 버전 만들기" 클릭
- [ ] `app-release.aab` 파일 업로드
- [ ] 업로드 완료 대기
- [ ] 버전 이름 및 릴리즈 노트 입력

---

## 💡 팁

### 빌드 오류 발생 시:
1. **캐시 정리**:
   ```bash
   flutter clean
   flutter pub get
   ```

2. **의존성 확인**:
   ```bash
   flutter doctor
   ```

3. **Gradle 빌드 직접 실행**:
   ```bash
   cd android
   ./gradlew bundleRelease
   ```

### 업로드 오류 발생 시:
- **파일 크기 확인**: 보통 10-20MB (너무 작거나 크면 문제)
- **서명 확인**: 키스토어로 서명되었는지 확인
- **패키지명 확인**: `com.talkboard.app`인지 확인

---

## 📝 현재 프로젝트 정보

- **패키지명**: `com.talkboard.app`
- **앱 이름**: 톡보드
- **빌드 파일 위치**: `android/app/build/outputs/bundle/release/app-release.aab`
- **서명 키**: `android/app/key.jks` (존재 확인됨)

---

## 🎯 다음 단계

App Bundle 업로드 후:
1. **앱 정보 입력** (이름, 설명, 스크린샷 등)
2. **콘텐츠 등급 설정**
3. **검토 제출**

---

**지금 바로 빌드부터 시작하시겠어요?**

