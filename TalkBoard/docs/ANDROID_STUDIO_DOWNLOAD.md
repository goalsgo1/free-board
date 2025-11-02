# Android Studio 다운로드 가이드

## 🔍 Mac 프로세서 확인

화면에서 두 가지 옵션이 있습니다:
1. **Mac with Apple chip** (Apple Silicon - M1, M2, M3 등)
2. **Mac with Intel chip** (Intel 프로세서)

---

## ✅ 확인 방법

### 터미널에서 확인:

```bash
uname -m
```

결과:
- **`arm64`** → **"Mac with Apple chip"** 선택
- **`x86_64`** → **"Mac with Intel chip"** 선택

---

## 🎯 선택 가이드

### "Mac with Apple chip" 선택:
- Apple Silicon Mac (M1, M2, M3 등)
- 2020년 이후 출시된 MacBook Air/Pro
- Mac mini (M1 이상)
- iMac 24인치 (M1)
- Mac Studio

### "Mac with Intel chip" 선택:
- Intel 프로세서 Mac
- 2020년 이전 출시된 대부분의 Mac
- Intel Core i5, i7, i9 등

---

## 📋 다운로드 파일명

### Apple chip (arm64):
- 파일명: `android-studio-2025.2.1.7-mac_arm.dmg`
- 용량: 약 1GB

### Intel chip (x86_64):
- 파일명: `android-studio-2025.2.1.7-mac.dmg`
- 용량: 약 1GB

---

## ✅ 체크리스트

- [ ] Mac 프로세서 확인 (`uname -m`)
- [ ] 적절한 버전 선택
- [ ] "읽었으며 이에 동의합니다" 체크
- [ ] 다운로드 버튼 클릭
- [ ] 다운로드 완료 대기
- [ ] 설치 파일 실행

---

## 💡 참고사항

### 이미 Android Studio가 설치되어 있나요?

이미 설치되어 있다면:
1. **Android Studio 실행**
2. **Tools → SDK Manager** 클릭
3. **SDK Tools** 탭에서 **Android SDK Command-line Tools** 체크
4. **Apply** 클릭하여 설치

다운로드 없이 SDK Tools만 설치하면 됩니다!

---

## 🚀 다음 단계

다운로드 및 설치 완료 후:
1. Android Studio 실행
2. SDK Manager에서 cmdline-tools 설치
3. 라이센스 동의
4. App Bundle 빌드 재시도

