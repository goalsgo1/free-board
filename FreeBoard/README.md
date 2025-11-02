# FreeBoard

**FreeBoard**는 Firebase 백엔드를 활용한 크로스 플랫폼 자유 게시판 애플리케이션입니다.

## 📱 주요 기능

- 🔐 Firebase Authentication을 통한 이메일/비밀번호 로그인
- 📝 게시글 작성, 수정, 삭제
- 💬 게시글에 댓글 작성
- 🔍 게시글 검색 및 필터링
- 📋 삭제된 게시글 모아보기
- 🎨 Material Design 3를 활용한 현대적인 UI

## 🛠 기술 스택

- **프레임워크**: Flutter 3.8.1+
- **백엔드**: Firebase (Firestore, Authentication)
- **상태 관리**: Provider
- **언어**: Dart 3.8.1+

## 📦 설치 및 실행

### 사전 요구사항

- Flutter SDK 설치
- Firebase 프로젝트 생성
- Android Studio / Xcode (모바일 빌드용)

### 설치

1. 저장소 클론:
```bash
git clone https://github.com/goalsgo1/free-board.git
cd FreeBoard
```

2. 의존성 설치:
```bash
flutter pub get
```

3. Firebase 설정 파일 추가:
```bash
flutterfire configure
```

더 자세한 Firebase 설정 방법은 [FIREBASE_SETUP.md](FIREBASE_SETUP.md)를 참고하세요.

### 실행

```bash
# Android
flutter run

# iOS
flutter run -d ios

# Web
flutter run -d chrome
```

## 📚 문서

- [Firebase 설정 가이드](FIREBASE_SETUP.md)
- [Firebase 인증 설정](FIREBASE_AUTH_SETUP.md)
- [Firestore 인덱스 설정](FIRESTORE_INDEX_SETUP.md)
- [Firestore 보안 규칙](FIRESTORE_SECURITY_RULES.md)
- [레이아웃 디자인 컨셉](LAYOUT_DESIGN_CONCEPTS.md)
- [보안 가이드](SECURITY.md)

## 🔒 보안

이 프로젝트는 Firebase를 사용하므로 **반드시** [보안 가이드](SECURITY.md)를 읽고 설정하세요.

## 🤝 기여하기

버그 리포트나 기능 제안은 [Issues](https://github.com/goalsgo1/free-board/issues)에 등록해주세요.

## 📄 라이선스

이 프로젝트는 자유롭게 사용 가능합니다.

## 🔗 링크

- **GitHub 저장소**: https://github.com/goalsgo1/free-board
