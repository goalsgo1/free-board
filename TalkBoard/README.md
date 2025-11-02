# 톡보드

**톡보드**는 Firebase 백엔드를 활용한 크로스 플랫폼 자유 게시판 애플리케이션입니다.

## 📱 주요 기능

- 🔐 Firebase Authentication을 통한 이메일/비밀번호 로그인
- 📝 게시글 CRUD (작성, 읽기, 수정, 삭제)
- 💬 댓글 및 대댓글 기능
- 📊 실시간 조회수 업데이트
- 📝 게시글/댓글 수정 히스토리
- 🗑️ 소프트 삭제 및 복원 기능
- 📋 삭제된 게시글 관리 (자신이 삭제한 게시글만 확인)
- 🔒 개인정보처리방침 제공
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
cd free-board
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
