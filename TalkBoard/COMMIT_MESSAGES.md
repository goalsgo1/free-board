# Git 커밋 메시지 제안

## 📋 변경사항 요약

### 수정된 파일
- `android/app/build.gradle.kts`: key.properties 경로 수정

### 새로 추가된 파일
- `docs/`: Google Play Console 출시 관련 가이드 문서들
- `PRIVACY_POLICY_SETUP.md`: 개인정보처리방침 설정 가이드
- `RELEASE_ACTION_PLAN.md`: 출시 액션 플랜
- `assets/icon/app_graphic.png`: Feature Graphic 이미지

---

## 💡 커밋 제안 (여러 커밋으로 분리)

### 커밋 1: Android 빌드 설정 수정
```bash
git add android/app/build.gradle.kts
git commit -m "fix: Android keystore 경로 수정

- key.properties 파일 경로를 ../key.properties에서 key.properties로 변경
- android/ 디렉토리 내에서 올바른 경로 참조하도록 수정"
```

### 커밋 2: Google Play Console 출시 문서 추가
```bash
git add docs/
git commit -m "docs: Google Play Console 출시 가이드 추가

- Google Play Console 설정 및 앱 등록 가이드 문서 추가
- 콘텐츠 등급, 데이터 보안, 데이터 유형 선택 가이드 추가
- 스토어 등록정보 작성 가이드 추가
- 스크린샷 및 자산 업로드 가이드 추가"
```

### 커밋 3: 출시 관련 설정 문서 추가
```bash
git add PRIVACY_POLICY_SETUP.md RELEASE_ACTION_PLAN.md
git commit -m "docs: 출시 관련 설정 문서 추가

- 개인정보처리방침 설정 가이드 추가
- 출시 액션 플랜 문서 추가"
```

### 커밋 4: Feature Graphic 이미지 추가
```bash
git add assets/icon/app_graphic.png
git commit -m "assets: Feature Graphic 이미지 추가

- Google Play Store용 Feature Graphic 이미지 추가 (1024x500px)"
```

---

## 🔄 통합 커밋 (한 번에 커밋하고 싶은 경우)

### 모든 변경사항을 한 번에 커밋:
```bash
git add .
git commit -m "docs: Google Play Console 출시 준비 문서 및 자산 추가

- Android keystore 경로 수정 (key.properties 경로 변경)
- Google Play Console 출시 가이드 문서 추가
  - 콘텐츠 등급, 데이터 보안, 데이터 유형 선택 가이드
  - 스토어 등록정보 작성 가이드
  - 스크린샷 및 자산 업로드 가이드
- 개인정보처리방침 설정 및 출시 액션 플랜 문서 추가
- Feature Graphic 이미지 추가 (1024x500px)"
```

---

## ✅ 권장 커밋 순서

**여러 커밋으로 분리하는 것을 권장합니다** (히스토리 관리에 유리):

1. **커밋 1:** Android 빌드 설정 수정
2. **커밋 2:** Google Play Console 출시 문서 추가
3. **커밋 3:** 출시 관련 설정 문서 추가
4. **커밋 4:** Feature Graphic 이미지 추가

또는

**통합 커밋** (모든 변경사항을 한 번에):

```bash
git add .
git commit -m "docs: Google Play Console 출시 준비 문서 및 자산 추가"
```

---

**위의 커밋 메시지 중 하나를 선택하여 사용하세요!**

