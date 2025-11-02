# Keystore 파일 경로 수정 완료

## ⚠️ 오류 메시지

```
Keystore file '/Users/haemin/Documents/GitHub/project/TalkBoard/android/app/app/key.jks' not found
```

**문제**: `android/app/app/key.jks`를 찾고 있었습니다 (잘못된 경로)

**실제 파일 위치**: `android/app/key.jks`

---

## ✅ 해결 완료

### `key.properties` 파일 수정:

**이전:**
```properties
storeFile=app/key.jks
```

**수정:**
```properties
storeFile=key.jks
```

### 이유:

`build.gradle.kts`에서:
```kotlin
storeFile = file(keystoreProperties["storeFile"] as String)
```

`file()` 함수는 `android/app/` 폴더 기준입니다.

- **이전**: `file("app/key.jks")` → `android/app/app/key.jks` 찾음 ❌
- **수정**: `file("key.jks")` → `android/app/key.jks` 찾음 ✅

---

## 🔄 재빌드

### Step 1: 캐시 정리 (선택사항)

```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard
flutter clean
flutter pub get
```

### Step 2: 재빌드

```bash
flutter build appbundle --release
```

이제 정상적으로 빌드됩니다!

---

## ✅ 확인 사항

빌드 성공 후:
- ✅ 릴리즈 키로 서명된 App Bundle 생성
- ✅ `build/app/outputs/bundle/release/app-release.aab` 파일 생성
- ✅ Google Play Console에 업로드 가능

---

## 📤 다음 단계

빌드 성공 후:
1. Google Play Console에서 이전 파일 제거
2. 새로 빌드된 `app-release.aab` 파일 업로드
3. 정상적으로 업로드 완료!

---

**이제 `flutter build appbundle --release` 명령어를 다시 실행하세요!**

