# Firebase 설정 가이드

## 1. Firebase Console에서 프로젝트 생성

1. https://console.firebase.google.com 접속
2. "프로젝트 추가" 클릭
3. 프로젝트 이름: **톡보드** (또는 원하는 이름)
4. Google Analytics 사용 (선택 사항)
5. 프로젝트 생성 완료

## 2. FlutterFire CLI로 설정 파일 생성

터미널에서 다음 명령어 실행:

```bash
cd TalkBoard
export PATH="$PATH:$HOME/.pub-cache/bin"
flutterfire configure
```

실행하면:
- Firebase 프로젝트 목록이 나타남
- 방금 생성한 **톡보드** 프로젝트 선택
- 플랫폼 선택 (iOS, Android, Web 등)

이 명령어가 자동으로 `lib/firebase_options.dart` 파일을 업데이트합니다.

## 3. Firestore Database 생성

1. Firebase Console → 왼쪽 메뉴에서 **Firestore Database** 선택
2. "데이터베이스 만들기" 클릭
3. **테스트 모드로 시작** 선택 (개발용)
4. 위치 선택: **asia-northeast3 (서울)** 추천
5. 데이터베이스 생성 완료

## 4. Firestore 보안 규칙 설정 (선택 사항)

개발 중에는 다음 규칙을 사용할 수 있습니다 (주의: 프로덕션에서는 변경 필요):

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if true;
    }
  }
}
```

## 완료!

이제 앱을 실행할 수 있습니다:

```bash
flutter run
```

