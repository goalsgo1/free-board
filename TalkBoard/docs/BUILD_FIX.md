# App Bundle 빌드 실패 해결 가이드

## ⚠️ 빌드 실패 원인

터미널 출력에서 확인된 문제:
1. **cmdline-tools component is missing**
2. **Android license status unknown**

이로 인해 빌드가 실패했습니다.

---

## 🔧 해결 방법

### Step 1: Android 라이센스 동의

터미널에서 다음 명령어 실행:

```bash
flutter doctor --android-licenses
```

모든 라이센스에 대해 **"y"** 또는 **"yes"** 입력

### Step 2: cmdline-tools 설치 확인

Android Studio에서:
1. Android Studio 실행
2. **Tools** → **SDK Manager** 클릭
3. **SDK Tools** 탭 클릭
4. **Android SDK Command-line Tools** 체크
5. **Apply** 클릭하여 설치

또는 터미널에서:
```bash
sdkmanager "cmdline-tools;latest"
```

### Step 3: 빌드 재시도

라이센스 동의 후 다시 빌드:

```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard
flutter clean
flutter pub get
flutter build appbundle --release
```

---

## ✅ 빠른 해결 방법

### 가장 간단한 방법:

1. **Android 라이센스 동의**:
   ```bash
   flutter doctor --android-licenses
   ```
   모든 라이센스에 대해 "y" 입력

2. **빌드 재시도**:
   ```bash
   flutter build appbundle --release
   ```

---

## 📋 체크리스트

- [ ] `flutter doctor --android-licenses` 실행
- [ ] 모든 라이센스 동의 (y 입력)
- [ ] `flutter clean` 실행 (선택사항)
- [ ] `flutter build appbundle --release` 재시도
- [ ] 빌드 성공 확인
- [ ] `app-release.aab` 파일 확인

---

## 🎯 다음 단계

빌드가 성공하면:
1. `android/app/build/outputs/bundle/release/app-release.aab` 파일 생성
2. Google Play Console에 업로드 가능

---

먼저 `flutter doctor --android-licenses`를 실행하세요!

