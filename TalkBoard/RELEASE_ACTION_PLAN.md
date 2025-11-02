# 🚀 앱 출시 액션 플랜

## ✅ 현재 완료 상태

### 기술 준비 (완료)
- ✅ Android keystore 생성 완료 (`android/app/key.jks`)
- ✅ 스크린샷 준비 완료 (Android 7개 + iOS 7개)
- ✅ 앱 아이콘 생성 완료
- ✅ Firebase 연결 완료 (talkboard-b93dd)
- ✅ 패키지명 및 Bundle ID 설정 완료 (com.talkboard.app)
- ✅ 기본 기능 모두 구현 완료

---

## ⚠️ 출시 전 필수 작업

### 🔴 우선순위 1: 법적 요구사항 (필수)

#### 1. 개인정보처리방침 작성 ⚠️ **필수**
- **필수 이유**: Google Play Store 및 Apple App Store 필수 요구사항
- **작성 방법**:
  1. `lib/screens/privacy_policy_screen.dart` 파일 확인
  2. 웹 호스팅 필요 (GitHub Pages, Netlify 등 무료 서비스 이용)
  3. URL 생성 후 앱 스토어 등록 시 제공
- **포함 내용**:
  - 수집하는 개인정보 항목 (이메일, 사용자 이름)
  - 개인정보 수집 및 이용 목적
  - Firebase 서비스 이용에 대한 안내
  - 개인정보 보유 및 이용 기간
  - 개인정보 관리 책임자 연락처
- **예상 시간**: 2-3시간
- **무료 호스팅 추천**: 
  - GitHub Pages
  - Netlify
  - Vercel

#### 2. 이용약관 작성 (권장)
- 게시글 작성 규칙
- 금지 행위 명시
- 서비스 제공 중단 조건
- 면책 조항
- **예상 시간**: 1-2시간

---

### 🟡 우선순위 2: 앱 스토어 계정 및 설정

#### 1. Google Play Console 계정 생성
- **비용**: $25 (1회 등록비, 평생 유효)
- **필요 정보**:
  - 개발자 이름
  - 이메일 주소
  - 결제 정보 ($25 결제)
- **주소**: https://play.google.com/console
- **예상 시간**: 30분-1시간

#### 2. Apple App Store Connect 계정 설정
- **비용**: $99/년 (Apple Developer Program)
- **필요 정보**:
  - Apple ID
  - 결제 정보 ($99 결제)
  - 신분증 검증 (처음 등록 시)
- **주소**: https://developer.apple.com/programs/
- **예상 시간**: 1-2시간 (검증 포함)

---

### 🟢 우선순위 3: 앱 스토어 메타데이터 작성

#### Google Play Store

**필수 정보:**
- [ ] **앱 이름**: 톡보드 (30자 이내)
- [ ] **짧은 설명**: 140자 이내
  - 예: "자유롭게 소통하는 게시판 앱. 실시간 댓글과 대댓글로 활발한 커뮤니티를 만들어보세요."
- [ ] **긴 설명**: 4000자 이내
  - 앱 기능 상세 설명
  - 주요 특징 나열
  - 사용법 간단히 설명
- [ ] **앱 아이콘**: 512x512px PNG
  - ✅ 이미 생성됨 (`assets/icon/app_icon.png`)
- [ ] **피처 그래픽**: 1024x500px (선택사항)
  - Google Play Store 메인 이미지
- [ ] **스크린샷**: 최소 2개, 권장 3-5개
  - ✅ 준비 완료: 7개
  - 최소 2개: 스마트폰
  - 권장 2개: 태블릿
- [ ] **개인정보처리방침 URL**: 필수
- [ ] **이메일 연락처**: 필수
- [ ] **카테고리**: 커뮤니케이션 또는 소셜
- [ ] **콘텐츠 등급**: 전체 이용가
- **예상 시간**: 1-2시간

#### Apple App Store

**필수 정보:**
- [ ] **앱 이름**: 톡보드 (30자 이내)
- [ ] **서브타이틀**: 30자 이내
  - 예: "자유로운 소통의 게시판"
- [ ] **설명**: 앱 기능 설명 (4000자 이내)
- [ ] **키워드**: 검색 키워드 (100자 이내, 쉼표 구분)
  - 예: "게시판,커뮤니티,소통,댓글,톡보드"
- [ ] **앱 아이콘**: 1024x1024px PNG
  - ✅ 이미 생성됨
- [ ] **스크린샷**: 최소 1개 (6.5인치 iPhone: 1284x2778px)
  - ✅ 준비 완료: 7개
  - 권장: 6.5인치 iPhone (1284x2778px)
- [ ] **개인정보처리방침 URL**: 필수
- [ ] **연락처 정보**: 필수
- [ ] **카테고리**: 소셜 네트워킹
- [ ] **연령 등급**: 4+
- **예상 시간**: 1-2시간

---

### 🔵 우선순위 4: 앱 빌드 및 테스트

#### Android App Bundle 빌드
```bash
cd /Users/haemin/Documents/GitHub/project/TalkBoard

# App Bundle 빌드 (Google Play Store용)
flutter build appbundle --release

# 빌드 파일 위치
# android/app/build/outputs/bundle/release/app-release.aab
```
- **예상 시간**: 5-10분
- **파일 크기**: 약 10-20MB

#### iOS Archive 빌드 (Xcode에서)
1. Xcode에서 프로젝트 열기:
   ```bash
   open ios/Runner.xcworkspace
   ```
2. Xcode에서:
   - Product → Destination → Any iOS Device 선택
   - Product → Archive 선택
   - Archive 완료 후 "Distribute App" 클릭
   - App Store Connect에 업로드
- **예상 시간**: 10-20분
- **필수**: Apple Developer 계정 ($99/년)

---

### 🟣 우선순위 5: 앱 스토어 업로드

#### Google Play Store 업로드
1. Google Play Console 접속
2. 앱 만들기 클릭
3. 앱 정보 입력 (우선순위 3에서 작성한 내용)
4. App Bundle 업로드:
   - Production 트랙 선택
   - `app-release.aab` 파일 업로드
5. 스크린샷 업로드
6. 개인정보처리방침 URL 입력
7. 콘텐츠 등급 설정
8. 검토 제출
- **검토 시간**: 1-3일
- **예상 시간**: 30분-1시간

#### Apple App Store 업로드
1. App Store Connect 접속
2. 앱 추가
3. 앱 정보 입력 (우선순위 3에서 작성한 내용)
4. Xcode에서 Archive 업로드
5. 스크린샷 업로드
6. 개인정보처리방침 URL 입력
7. 심사 제출
- **심사 시간**: 1-3일 (보통 1-2일)
- **예상 시간**: 30분-1시간

---

## 📋 작업 체크리스트 (우선순위별)

### 🔴 필수 (Must Have)

#### 1. 법적 요구사항
- [ ] 개인정보처리방침 작성
- [ ] 개인정보처리방침 웹 호스팅 및 URL 생성
- [ ] (권장) 이용약관 작성

#### 2. Google Play Store 계정
- [ ] Google Play Console 계정 생성 ($25 결제)
- [ ] 개발자 프로필 설정

#### 3. Apple App Store 계정
- [ ] Apple Developer Program 가입 ($99/년)
- [ ] App Store Connect 접속 권한 확인

#### 4. 앱 스토어 메타데이터
- [ ] 앱 이름 결정
- [ ] 앱 설명 작성 (Google Play + App Store)
- [ ] 키워드 작성 (App Store)

#### 5. 앱 빌드
- [ ] Android App Bundle 빌드
- [ ] iOS Archive 빌드 (Xcode)

#### 6. 앱 스토어 업로드
- [ ] Google Play Store 업로드 및 제출
- [ ] Apple App Store 업로드 및 심사 제출

---

### 🟡 권장 (Should Have)

- [ ] 이용약관 작성
- [ ] 피처 그래픽 생성 (Google Play Store)
- [ ] 앱 설명 최적화 (SEO)
- [ ] 여러 디바이스 스크린샷 추가

---

### 🟢 선택 (Nice to Have)

- [ ] 앱 미리보기 비디오 (App Store)
- [ ] 앱 소개 페이지 (웹사이트)
- [ ] 마케팅 자료 준비

---

## ⏱️ 예상 소요 시간

### 최소 시간 (핵심만)
- 개인정보처리방침 작성: 2시간
- Google Play Console 설정: 1시간
- 앱 메타데이터 작성: 1시간
- 앱 빌드: 30분
- 업로드 및 제출: 1시간
- **총 예상 시간**: 약 **5-6시간** (하루 작업)

### 권장 시간 (권장 사항 포함)
- 개인정보처리방침 + 이용약관: 4시간
- 스토어 계정 설정: 2시간
- 앱 메타데이터 최적화: 2시간
- 앱 빌드 및 테스트: 1시간
- 업로드 및 제출: 1시간
- **총 예상 시간**: 약 **10시간** (1-2일 작업)

---

## 💰 비용 요약

### 필수 비용
- **Google Play Console 등록**: $25 (1회, 평생 유효)
- **Apple Developer Program**: $99/년 (연간 갱신)

### 선택 비용
- 개인정보처리방침 호스팅: 무료 (GitHub Pages 등)
- 도메인 구매: 선택사항 ($10-15/년)

**총 필수 비용**: $124 (첫 해) → $99/년 (이후)

---

## 📝 다음 단계 (즉시 시작 가능)

### 오늘 할 수 있는 작업
1. **개인정보처리방침 작성** (2-3시간)
   - 템플릿 참고하여 작성
   - GitHub Pages에 호스팅
2. **앱 스토어 설명 작성** (1-2시간)
   - 앱 기능 설명
   - 키워드 정리

### 내일 할 수 있는 작업
1. **Google Play Console 계정 생성** (30분)
2. **Apple Developer Program 가입** (1-2시간, 검증 포함)
3. **Android App Bundle 빌드** (10분)
4. **앱 스토어 업로드 및 제출** (1시간)

---

## 🎯 완료 기준

### Google Play Store 출시 준비 완료
- ✅ Android keystore 생성
- ✅ 스크린샷 준비
- ✅ 앱 아이콘 준비
- ⏳ 개인정보처리방침 URL
- ⏳ Google Play Console 계정
- ⏳ App Bundle 빌드
- ⏳ 업로드 및 제출

### Apple App Store 출시 준비 완료
- ✅ 스크린샷 준비
- ✅ 앱 아이콘 준비
- ⏳ Apple Developer 계정
- ⏳ 개인정보처리방침 URL
- ⏳ iOS Archive 빌드
- ⏳ 업로드 및 심사 제출

---

## 📚 관련 문서

- [출시 체크리스트](RELEASE_CHECKLIST.md)
- [앱 스토어 준비도](APP_STORE_READINESS.md)
- [앱 스토어 리스팅 템플릿](STORE_LISTING_TEMPLATE.md)
- [스크린샷 체크리스트](SCREENSHOT_CHECKLIST.md)

---

## 💡 팁

### 개인정보처리방침 작성
- 이미 `lib/screens/privacy_policy_screen.dart`에 기본 템플릿 있음
- 웹 버전으로 변환하여 GitHub Pages에 호스팅
- 또는 간단한 HTML 페이지로 작성

### 앱 설명 작성
- `STORE_LISTING_TEMPLATE.md` 참고
- 주요 기능 위주로 작성
- 사용자 혜택 강조

### 빌드 오류 해결
- `flutter clean` 실행
- `flutter pub get` 실행
- 의존성 확인

---

## ✅ 최종 체크리스트

### 출시 준비 완료 체크
- [ ] 개인정보처리방침 작성 및 URL 생성
- [ ] Google Play Console 계정 생성 ($25 결제)
- [ ] Apple Developer Program 가입 ($99/년)
- [ ] 앱 스토어 메타데이터 작성
- [ ] Android App Bundle 빌드 완료
- [ ] iOS Archive 빌드 완료 (Xcode)
- [ ] Google Play Store 업로드 및 제출
- [ ] Apple App Store 업로드 및 심사 제출

---

**예상 출시일**: 준비 완료 후 1-3일 (스토어 검토 시간 포함)

