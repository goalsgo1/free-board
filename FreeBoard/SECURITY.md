# 보안 가이드 (Security Guide)

## ⚠️ 중요: Firebase 설정 파일

이 프로젝트는 Firebase를 사용하므로, Firebase 설정 파일들이 포함되어 있을 수 있습니다:

- `android/app/google-services.json` (Android)
- `ios/Runner/GoogleService-Info.plist` (iOS)
- `lib/firebase_options.dart` (Flutter)

### 🔒 권장 사항

#### 공개 저장소인 경우
이미 이 파일들이 커밋되어 있다면, 다음 조치를 권장합니다:

1. **Firebase Console에서 API 키 제한 설정:**
   - Firebase Console → 프로젝트 설정 → API 키 → HTTP 리퍼러(웹사이트) 제한 추가
   - Android/iOS 앱의 패키지명으로 제한 설정

2. **Firestore 보안 규칙 강화:**
   - `FIRESTORE_SECURITY_RULES.md`의 보안 규칙을 반드시 적용하세요.
   - 인증되지 않은 사용자의 접근을 차단하세요.

3. **이미 커밋된 민감 파일 제거 (선택사항):**
   ```bash
   # Git 히스토리에서 파일 제거
   git filter-branch --force --index-filter \
     "git rm --cached --ignore-unmatch android/app/google-services.json ios/Runner/GoogleService-Info.plist" \
     --prune-empty --tag-name-filter cat -- --all
   
   # 강제 푸시 (주의: 다른 협업자가 있다면 조율 필요)
   git push origin --force --all
   ```

   ⚠️ **주의**: `git filter-branch`는 히스토리를 변경하므로 신중하게 사용하세요.

#### 더 안전한 방법: 새로운 Firebase 프로젝트 생성
1. 새로운 Firebase 프로젝트 생성
2. 기존 프로젝트에서 데이터 마이그레이션
3. 새로운 설정 파일로 교체
4. 이전 Firebase 프로젝트 삭제

## 🔐 Firebase 보안 체크리스트

- [ ] Firestore 보안 규칙 설정 완료
- [ ] Firebase Authentication 활성화
- [ ] API 키에 제한 설정 (HTTP 리퍼러, 앱 패키지명)
- [ ] Storage 보안 규칙 설정 (사용하는 경우)
- [ ] Firebase 프로젝트에 알림 설정
- [ ] 정기적인 보안 감사 수행

## 📚 추가 리소스

- [Firebase 보안 규칙 가이드](https://firebase.google.com/docs/rules)
- [Flutter Firebase 보안 모범 사례](https://firebase.google.com/docs/flutter/setup)

## ⚠️ 민감 정보 취급 시 주의사항

- 절대 API 키, 비밀번호, 토큰 등을 코드에 하드코딩하지 마세요.
- `.env` 파일을 사용하고 `.gitignore`에 추가하세요.
- 환경별 설정 파일을 분리하세요 (개발/프로덕션).

