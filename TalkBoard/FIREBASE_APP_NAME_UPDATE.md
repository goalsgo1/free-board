# 🔧 Firebase 앱 닉네임 변경 가이드

## 현재 상황

Firebase Console에서 앱 닉네임이 "free_board"로 표시되고 있습니다. 이를 "톡보드" 또는 "TalkBoard"로 변경해야 합니다.

## 해결 방법

### 방법 1: Firebase Console에서 직접 수정 (가장 쉬움) ⭐

1. **Firebase Console** → **프로젝트 설정** 접속
2. 왼쪽 **"내 앱"** 섹션에서 각 앱 선택:
   - Android 앱 (`com.talkboard.app`)
   - iOS 앱 (`com.talkboard.app`)
   - Web 앱 (`free_board`)

3. **각 앱의 "앱 닉네임" 필드**에서:
   - 연필 아이콘(✏️) 클릭
   - "free_board (android)" → **"톡보드 (Android)"** 또는 **"TalkBoard (Android)"** 로 변경
   - "free_board (ios)" → **"톡보드 (iOS)"** 또는 **"TalkBoard (iOS)"** 로 변경
   - "free_board (web)" → **"톡보드 (Web)"** 또는 **"TalkBoard (Web)"** 로 변경

4. **저장** 클릭

### 방법 2: FlutterFire CLI 재실행 (선택사항)

FlutterFire CLI를 다시 실행하여 앱 닉네임을 지정할 수도 있지만, 현재 설정 파일은 이미 올바르게 설정되어 있으므로 **방법 1을 권장**합니다.

## 주의사항

### 앱 닉네임 vs 패키지명

- **앱 닉네임**: Firebase Console에서 표시되는 이름 (편집 가능, 사용자가 보기 편하게 사용)
- **패키지명/Bundle ID**: 실제 앱 식별자 (`com.talkboard.app`) - 이미 올바르게 설정됨 ✅

**중요**: 패키지명이 이미 `com.talkboard.app`으로 올바르게 설정되어 있으므로, 앱 닉네임만 변경하면 됩니다.

## 확인 사항

변경 후 Firebase Console에서:
- [ ] Android 앱 닉네임: "톡보드 (Android)" 또는 "TalkBoard (Android)"
- [ ] iOS 앱 닉네임: "톡보드 (iOS)" 또는 "TalkBoard (iOS)"
- [ ] Web 앱 닉네임: "톡보드 (Web)" 또는 "TalkBoard (Web)"
- [ ] 패키지명은 여전히 `com.talkboard.app`인지 확인

## 참고사항

- 앱 닉네임은 Firebase Console에서만 표시되는 이름입니다
- 실제 앱 이름은 `AndroidManifest.xml`과 `Info.plist`에서 설정됩니다
- 앱 닉네임 변경은 앱 기능에 영향을 주지 않습니다

