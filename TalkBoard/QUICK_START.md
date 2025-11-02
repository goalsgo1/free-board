# 빠른 시작 가이드

## 🚀 앱 출시까지 4단계

### 1단계: Android 서명 키 생성 (약 5분)

#### 방법 1: 스크립트 사용 (권장)
```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard
./create_keystore.sh
```

스크립트가 키스토어 생성 과정을 안내합니다.

#### 방법 2: 수동 생성
```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard/android/app

keytool -genkey -v \
  -keystore key.jks \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -alias upload
```

**비밀번호 권장사항:**
- 최소 20자 이상
- 대문자, 소문자, 숫자, 특수문자 각각 포함
- 예: `MySecurePassword123!@#`

#### key.properties 파일 생성
```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard/android

cat > key.properties << EOF
storePassword=<키스토어_비밀번호>
keyPassword=<키_비밀번호>
keyAlias=upload
storeFile=app/key.jks
EOF
```

**중요**: 키스토어 비밀번호와 키 비밀번호를 안전하게 보관하세요!

### 2단계: 앱 아이콘 생성 (약 1시간)

#### 준비
1. 1024x1024px 아이콘 이미지 준비
   - 온라인 도구 사용: [AppIcon.co](https://www.appicon.co/)

#### 이미지 추가
```bash
# assets/icon 폴더에 이미지 추가
# 파일명: app_icon.png (1024x1024px)
```

#### 아이콘 생성
```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard

# 아이콘 생성
flutter pub get
flutter pub run flutter_launcher_icons
```

생성된 아이콘 확인:
- Android: `android/app/src/main/res/mipmap-*/ic_launcher.png`
- iOS: `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

### 3단계: 스크린샷 촬영 (약 30분)

#### 앱 실행
```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard

# Android
flutter run --release

# iOS
flutter run --release -d ios
```

#### 촬영할 화면
1. 로그인 화면
2. 게시글 목록
3. 게시글 상세
4. 댓글 화면
5. 게시글 작성

#### 스크린샷 촬영
- **Android**: 전원 버튼 + 볼륨 다운
- **iOS**: 전원 버튼 + 볼륨 업
- 또는 ADB 명령어 사용 (자세한 내용은 `SCREENSHOT_GUIDE.md` 참고)

#### 크기 확인
- **Android**: 1080x1920px (9:16) 또는 1920x1080px (16:9)
- **iOS**: 1284x2778px (6.5인치 iPhone)

### 4단계: 앱 스토어 등록 (약 1시간)

#### 준비된 템플릿 사용
`STORE_LISTING_TEMPLATE.md` 파일을 참고하여:
1. 앱 이름 입력
2. 짧은 설명 입력 (80자 이내)
3. 긴 설명 입력 (4000자 이내)
4. 키워드 입력 (iOS, 100자 이내)
5. 스크린샷 업로드
6. 앱 아이콘 업로드

#### Google Play Store
1. [Google Play Console](https://play.google.com/console) 접속
2. 앱 생성
3. 스토어 등록 정보 입력
4. 개인정보처리방침 URL 제공
5. AAB 파일 업로드:
   ```bash
   flutter build appbundle --release
   ```

#### Apple App Store
1. [App Store Connect](https://appstoreconnect.apple.com/) 접속
2. 앱 생성
3. 스토어 등록 정보 입력
4. 개인정보처리방침 URL 제공
5. IPA 파일 업로드 (Xcode 사용)

## 📋 체크리스트

### 필수 작업
- [ ] Android 서명 키 생성
- [ ] key.properties 파일 생성
- [ ] 앱 아이콘 생성
- [ ] 스크린샷 2개 이상 (Android) / 1개 이상 (iOS)
- [ ] 앱 스토어 설명 작성

### 권장 작업
- [ ] 스크린샷 5개 이상
- [ ] Feature Graphic 생성 (Android)
- [ ] 개인정보처리방침 웹 호스팅

## 📚 상세 가이드

- `ANDROID_SIGNING_GUIDE.md`: 서명 키 생성 상세 가이드
- `APP_ICON_GUIDE.md`: 앱 아이콘 및 스크린샷 가이드
- `SCREENSHOT_GUIDE.md`: 스크린샷 촬영 가이드
- `STORE_LISTING_TEMPLATE.md`: 앱 스토어 등록용 템플릿

## ⚠️ 중요 사항

1. **서명 키 보관**
   - `key.jks` 파일을 안전한 곳에 백업
   - 비밀번호를 안전하게 보관
   - Git에 커밋하지 마세요

2. **개인정보처리방침 URL**
   - GitHub Pages 또는 Netlify 사용 권장
   - 앱 스토어 등록 시 필수

3. **테스트**
   - 릴리즈 빌드 테스트
   - 다양한 디바이스에서 테스트
   - 네트워크 오류 시나리오 테스트

## 🎯 예상 시간

- 서명 키 생성: 5분
- 앱 아이콘 생성: 1시간
- 스크린샷 촬영: 30분
- 스토어 등록 정보 작성: 1시간

**총 예상 시간**: 약 2-3시간

## 💡 팁

1. **아이콘 없을 때**: 온라인 도구 사용 (AppIcon.co 등)
2. **스크린샷**: 실제 디바이스에서 촬영 권장
3. **설명 작성**: 템플릿을 참고하여 수정

## 🚀 다음 단계

위의 4단계를 순서대로 진행하시면 앱 스토어에 출시할 수 있습니다!

각 단계에 대한 상세 가이드는 제공된 문서를 참고하세요.

