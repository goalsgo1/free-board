# 🛠️ 기술 스택 및 아키텍처 설계

## 📱 프론트엔드

### Flutter
- **버전**: 3.8.1+
- **언어**: Dart 3.8.1+
- **플랫폼**: iOS, Android, Web

### 주요 패키지

#### 상태 관리
- **provider**: ^6.1.2 - 상태 관리
- **riverpod**: (선택) - 더 강력한 상태 관리

#### Firebase
- **firebase_core**: ^3.6.0 - Firebase 초기화
- **cloud_firestore**: ^5.4.3 - 데이터베이스
- **firebase_auth**: ^5.3.1 - 인증
- **firebase_storage**: ^12.0.0 - 파일 저장
- **firebase_messaging**: ^15.0.0 - 푸시 알림
- **firebase_analytics**: ^11.0.0 - 분석

#### UI/UX
- **flutter_svg**: ^2.0.0+ - SVG 이미지
- **cached_network_image**: ^3.3.0 - 이미지 캐싱
- **image_picker**: ^1.0.0+ - 이미지 선택
- **video_player**: ^2.8.0 - 동영상 재생
- **youtube_player_flutter**: ^8.0.0+ - YouTube 재생
- **audioplayers**: ^5.0.0+ - 오디오 재생
- **record**: ^5.0.0+ - 오디오 녹음
- **flutter_markdown**: ^0.6.0+ - 마크다운 렌더링

#### 결제
- **in_app_purchase**: ^3.1.0+ - 인앱 결제 (iOS/Android)
- **flutter_pay**: ^1.0.0+ - 간편결제

#### 유틸리티
- **intl**: ^0.19.0 - 날짜 포맷팅
- **uuid**: ^4.0.0+ - UUID 생성
- **path_provider**: ^2.1.0+ - 파일 경로
- **shared_preferences**: ^2.2.0+ - 로컬 저장소
- **url_launcher**: ^6.2.0+ - URL 열기
- **share_plus**: ^7.0.0+ - 공유 기능

#### AI (초기 데이터 생성용, 선택)
- **http**: ^1.1.0 - HTTP 요청 (AI API 호출)
- **openai_dart**: ^0.3.0 - OpenAI API 클라이언트 (선택)
- 또는 **anthropic_dart**: ^0.1.0 - Claude API 클라이언트 (선택)

#### 개발 도구
- **flutter_lints**: ^5.0.0 - 린터 규칙
- **flutter_test**: SDK - 테스트

## 🔥 백엔드

### Firebase Services

#### Authentication
- **이메일/비밀번호**: 기본 인증
- **소셜 로그인**: (향후) Google, Apple, Kakao

#### Firestore
- **NoSQL 데이터베이스**: 실시간 동기화
- **컬렉션 구조**: 13개 컬렉션 (데이터 구조 문서 참조)
- **인덱스**: 복합 인덱스 설정

#### Storage
- **파일 저장**: 이미지, 동영상, 오디오
- **경로 구조**: memorials/{memorialId}/...

#### Cloud Functions
- **서버리스 함수**: 
  - 기념일 알림 스케줄링
  - 추모금 처리
  - 이미지 리사이징
  - 푸시 알림 전송
  - AI를 활용한 초기 데이터 생성 (선택)

#### Cloud Messaging
- **푸시 알림**: 기념일 알림, 댓글 알림

#### Analytics
- **사용자 분석**: 이벤트 추적, 사용자 행동 분석

## 💳 결제 시스템

### 인앱 결제
- **iOS**: App Store In-App Purchase
- **Android**: Google Play Billing

### 웹 결제
- **PG사 연동**: 
  - 토스페이먼츠
  - 아임포트
  - 카카오페이
  - 네이버페이

### 결제 플로우
1. 사용자 결제 요청
2. 결제 수단 선택
3. PG사 결제 API 호출
4. 결제 승인
5. Cloud Functions에서 수수료 차감
6. Firestore에 결제 기록 저장
7. 수령자에게 알림

## 🏗️ 아키텍처

### 폴더 구조

```
lib/
  ├── main.dart
  ├── models/              # 데이터 모델
  │   ├── user.dart
  │   ├── memorial.dart
  │   ├── comment.dart
  │   ├── prayer.dart
  │   ├── donation.dart
  │   └── emotion.dart
  ├── providers/            # 상태 관리
  │   ├── auth_provider.dart
  │   ├── memorial_provider.dart
  │   ├── comment_provider.dart
  │   ├── prayer_provider.dart
  │   ├── donation_provider.dart
  │   └── emotion_provider.dart
  ├── services/             # 비즈니스 로직
  │   ├── auth_service.dart
  │   ├── memorial_service.dart
  │   ├── storage_service.dart
  │   ├── payment_service.dart
  │   ├── notification_service.dart
  │   └── ai_data_generator.dart  # AI 초기 데이터 생성 (선택)
  ├── screens/              # 화면
  │   ├── home_screen.dart
  │   ├── memorial_list_screen.dart
  │   ├── memorial_detail_screen.dart
  │   ├── memorial_create_screen.dart
  │   ├── prayer_screen.dart
  │   └── emotion_screen.dart
  ├── widgets/              # 재사용 위젯
  │   ├── memorial_card.dart
  │   ├── comment_item.dart
  │   ├── photo_gallery.dart
  │   └── donation_modal.dart
  └── utils/                # 유틸리티
      ├── constants.dart
      ├── validators.dart
      └── formatters.dart
```

### 상태 관리 패턴

#### Provider 패턴
```dart
// 예시: MemorialProvider
class MemorialProvider extends ChangeNotifier {
  final MemorialService _service = MemorialService();
  List<Memorial> _memorials = [];
  bool _isLoading = false;
  
  List<Memorial> get memorials => _memorials;
  bool get isLoading => _isLoading;
  
  Future<void> loadMemorials() async {
    _isLoading = true;
    notifyListeners();
    
    _memorials = await _service.getMemorials();
    
    _isLoading = false;
    notifyListeners();
  }
}
```

### 서비스 레이어

#### Repository 패턴
```dart
// 예시: MemorialService
class MemorialService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  
  Future<Memorial> createMemorial(Memorial memorial) async {
    // Firestore에 저장
    // Storage에 파일 업로드
    // 결과 반환
  }
  
  Future<List<Memorial>> getMemorials() async {
    // Firestore에서 조회
    // 결과 반환
  }
}
```

## 🔒 보안

### 인증
- **Firebase Authentication**: 이메일/비밀번호
- **토큰 관리**: 자동 갱신

### 데이터 보안
- **Firestore Security Rules**: 컬렉션별 접근 제어
- **Storage Rules**: 파일 업로드 제한

### 결제 보안
- **서버 검증**: Cloud Functions에서 결제 검증
- **암호화**: 민감 정보 암호화 저장

## 📊 모니터링 및 분석

### Firebase Analytics
- **이벤트 추적**: 
  - memorial_created
  - donation_completed
  - prayer_participated
  - premium_subscribed

### Crashlytics
- **크래시 리포팅**: 자동 크래시 수집 및 분석

### Performance Monitoring
- **성능 모니터링**: 네트워크 요청, 화면 렌더링 시간

## 🚀 배포

### iOS
- **App Store Connect**: 앱 등록 및 배포
- **TestFlight**: 베타 테스트

### Android
- **Google Play Console**: 앱 등록 및 배포
- **Internal Testing**: 내부 테스트

### Web
- **Firebase Hosting**: 웹 앱 호스팅
- **도메인**: 커스텀 도메인 연결

## 📦 CI/CD

### GitHub Actions
- **자동 빌드**: 코드 푸시 시 자동 빌드
- **자동 배포**: 태그 생성 시 자동 배포

### Fastlane
- **자동화**: iOS/Android 빌드 및 배포 자동화

