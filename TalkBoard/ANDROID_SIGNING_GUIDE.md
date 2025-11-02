# Android 서명 키 설정 가이드

## 📋 개요

Google Play Store에 앱을 배포하려면 릴리즈 빌드용 서명 키가 필요합니다. 현재는 Debug 키를 사용하고 있어서, 프로덕션용 서명 키를 생성하고 설정해야 합니다.

## 🔑 서명 키 생성

### 1. 키스토어 생성

```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard/android/app

# 서명 키 생성 (키스토어)
keytool -genkey -v -keystore key.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias upload \
  -storepass 1qaz2wsxA15143@ \
  -keypass 1qaz2wsxA15143@
```

**중요:**
- 키스토어 비밀번호와 키 비밀번호를 안전하게 보관하세요 (분실 시 복구 불가)
- `key.jks` 파일은 **절대 Git에 커밋하지 마세요**
- `.gitignore`에 `key.jks`가 포함되어 있는지 확인하세요

**비밀번호 조건:**
- 공식적인 최소 길이 제한은 없지만, 보안을 위해 **최소 20자 이상** 권장
- 대문자, 소문자, 숫자, 특수문자를 각각 최소 하나 이상 포함 권장
- 키스토어 비밀번호와 키 비밀번호는 서로 다르게 설정 가능 (같게 설정해도 됨)
- 예: `MySecurePassword123!@#` (20자 이상)

### 2. 키 정보 확인

```bash
# 키 정보 확인
keytool -list -v -keystore key.jks -alias upload
```

## ⚙️ Android 빌드 설정

### 1. `key.properties` 파일 생성

```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard/android

# key.properties 파일 생성
cat > key.properties << EOF
storePassword=<키스토어_비밀번호>
keyPassword=<키_비밀번호>
keyAlias=upload
storeFile=app/key.jks
EOF
```

### 2. `build.gradle.kts` 수정

현재 `android/app/build.gradle.kts`를 수정하여 서명 설정을 추가합니다.

**참고**: 이미 수정되었습니다. 아래 내용을 확인하세요.

```kotlin
android {
    // ...
    
    signingConfigs {
        create("release") {
            val keystorePropertiesFile = rootProject.file("key.properties")
            val keystoreProperties = Properties()
            keystoreProperties.load(FileInputStream(keystorePropertiesFile))
            
            storeFile = file(keystoreProperties["storeFile"] as String)
            storePassword = keystoreProperties["storePassword"] as String
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
        }
    }
    
    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            // ...
        }
    }
}
```

## 🚀 빌드 및 테스트

### 릴리즈 APK 빌드

```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard

# 릴리즈 APK 빌드
flutter build apk --release
```

빌드된 APK는 `build/app/outputs/flutter-apk/app-release.apk`에 생성됩니다.

### App Bundle 빌드 (Google Play Store용)

```bash
# App Bundle 빌드
flutter build appbundle --release
```

빌드된 AAB는 `build/app/outputs/bundle/release/app-release.aab`에 생성됩니다.

## 📝 보안 주의사항

1. **키스토어 파일 보관**
   - `key.jks` 파일을 안전한 곳에 백업하세요
   - 여러 곳에 백업 보관 권장

2. **비밀번호 보관**
   - 키스토어 비밀번호와 키 비밀번호를 안전하게 보관하세요
   - 비밀번호 관리자 사용 권장

3. **Git에 커밋 금지**
   - `key.jks` 파일은 절대 Git에 커밋하지 마세요
   - `key.properties` 파일도 Git에 커밋하지 않는 것을 권장 (환경 변수 사용 권장)

## 🔄 환경 변수 사용 (권장)

### `.gitignore`에 추가

```bash
# android/key.properties
android/key.properties
```

### 환경 변수로 설정

```bash
# .env 파일 생성 (Git에 커밋하지 말 것)
echo "KEYSTORE_PASSWORD=<키스토어_비밀번호>" >> .env
echo "KEY_PASSWORD=<키_비밀번호>" >> .env
```

또는 CI/CD 환경에서는 환경 변수로 설정:

```bash
export KEYSTORE_PASSWORD=<키스토어_비밀번호>
export KEY_PASSWORD=<키_비밀번호>
```

## ✅ 다음 단계

1. 서명 키 생성 완료
2. `build.gradle.kts` 설정 완료
3. 릴리즈 빌드 테스트
4. Google Play Console에서 앱 등록
5. AAB 파일 업로드

