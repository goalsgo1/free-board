# 디버그 서명 오류 해결 가이드

## ⚠️ 오류 메시지

Google Play Console에서 오류 발생:
```
디버그 모드로 서명한 APK 또는 Android App Bundle을 업로드했습니다.
출시 모드로 APK 또는 Android App Bundle에 서명해야 합니다.
```

## 🔍 문제 원인

App Bundle이 **디버그 키**로 서명되어 있습니다.
Google Play Store에는 **릴리즈 키**로 서명된 파일이 필요합니다.

---

## 🔧 해결 방법

### Step 1: 빌드 캐시 정리

```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard

# Flutter 캐시 정리
flutter clean

# 의존성 재설치
flutter pub get
```

### Step 2: key.properties 확인

`android/key.properties` 파일이 올바른지 확인:

```properties
storePassword=키스토어 비밀번호
keyPassword=키 비밀번호
keyAlias=upload
storeFile=app/key.jks
```

**중요 확인사항:**
- `storeFile=app/key.jks` ← 이 경로가 올바른지 확인
- 실제 파일 위치: `android/app/key.jks`

### Step 3: build.gradle.kts 경로 확인

현재 설정:
```kotlin
storeFile = file(keystoreProperties["storeFile"] as String)
```

이것은 `android/app/` 폴더 기준입니다.
`key.properties`의 `storeFile=app/key.jks`가 올바릅니다.

### Step 4: 재빌드

```bash
# 릴리즈 모드로 빌드
flutter build appbundle --release
```

빌드 후 서명 확인:
```bash
# 빌드된 파일의 서명 정보 확인
jarsigner -verify -verbose -certs build/app/outputs/bundle/release/app-release.aab
```

---

## 🔍 문제 진단

### key.properties 파일 경로 문제일 수 있습니다

현재 `build.gradle.kts`에서:
```kotlin
val keystorePropertiesFile = rootProject.file("../key.properties")
```

이는 `android/` 폴더에서 `../key.properties`를 찾습니다.
즉, `TalkBoard/key.properties`를 찾습니다.

**확인 필요:**
- `key.properties` 파일 위치가 `android/key.properties`인지
- 또는 `TalkBoard/key.properties`인지

---

## 🛠️ 빠른 해결 방법

### 방법 1: key.properties 경로 수정

`android/key.properties` 파일이 있다면, `build.gradle.kts`에서 경로 확인:
```kotlin
val keystorePropertiesFile = rootProject.file("../key.properties")
```

이것은 `TalkBoard/key.properties`를 찾습니다.

만약 `android/key.properties`에 있다면:
```kotlin
val keystorePropertiesFile = rootProject.file("key.properties")
```

로 수정해야 합니다.

### 방법 2: 빌드 로그 확인

빌드 시 서명 관련 로그 확인:
```bash
flutter build appbundle --release --verbose 2>&1 | grep -i sign
```

---

## ✅ 최종 확인

빌드 성공 후 서명 확인:

```bash
# App Bundle 서명 확인
jarsigner -verify -verbose -certs build/app/outputs/bundle/release/app-release.aab | head -20
```

출력에서:
- **"smk"** 또는 **"signer certificate"**가 보이면 서명됨
- **"jar verified"**가 보이면 서명 유효

---

## 🎯 빠른 재빌드 명령어

```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard

# 캐시 정리
flutter clean
flutter pub get

# 재빌드
flutter build appbundle --release
```

---

먼저 `flutter clean` 후 재빌드해보세요!

