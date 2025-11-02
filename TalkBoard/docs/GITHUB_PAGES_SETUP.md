# GitHub Pages 개인정보처리방침 호스팅 가이드

## 📋 개요

GitHub Pages를 사용하여 개인정보처리방침을 무료로 호스팅하는 방법입니다.

## 🚀 방법 1: 같은 저장소에 호스팅 (추천)

### 단계 1: GitHub 저장소 생성 또는 확인

1. GitHub에 로그인
2. 새 저장소 생성 (또는 기존 저장소 사용)
   - 저장소 이름: 예) `talkboard-docs` 또는 `talkboard-privacy`
   - Public으로 설정 (GitHub Pages는 Public 저장소에서만 무료)

### 단계 2: 파일 업로드

1. `docs/privacy-policy.html` 파일을 저장소에 업로드
   - 저장소 루트에 `docs/` 폴더 생성
   - `privacy-policy.html` 파일 업로드

### 단계 3: GitHub Pages 활성화

1. GitHub 저장소 페이지에서 **Settings** 클릭
2. 왼쪽 메뉴에서 **Pages** 클릭
3. **Source** 섹션에서:
   - Branch: `main` (또는 `master`) 선택
   - Folder: `/docs` 선택
4. **Save** 클릭

### 단계 4: URL 확인

5-10분 후 다음 URL에서 접근 가능:
- `https://[사용자명].github.io/[저장소명]/privacy-policy.html`
- 예: `https://yourname.github.io/talkboard-docs/privacy-policy.html`

---

## 🚀 방법 2: 별도 저장소로 호스팅

### 단계 1: 새 저장소 생성

1. GitHub에 새 저장소 생성
   - 저장소 이름: `talkboard-privacy-policy` (권장)
   - Public으로 설정

### 단계 2: 파일 업로드

1. 저장소 루트에 `index.html` 파일 업로드
   - `privacy-policy.html` 파일 내용을 `index.html`로 복사

### 단계 3: GitHub Pages 활성화

1. GitHub 저장소 페이지에서 **Settings** 클릭
2. 왼쪽 메뉴에서 **Pages** 클릭
3. **Source** 섹션에서:
   - Branch: `main` (또는 `master`) 선택
   - Folder: `/ (root)` 선택
4. **Save** 클릭

### 단계 4: URL 확인

5-10분 후 다음 URL에서 접근 가능:
- `https://[사용자명].github.io/talkboard-privacy-policy/`
- 예: `https://yourname.github.io/talkboard-privacy-policy/`

---

## 📝 커밋 및 푸시 (터미널 사용 시)

### 저장소 초기화 (처음 한 번만)

```bash
# 새 디렉토리로 이동
cd ~/Documents/GitHub

# 새 저장소 생성 (또는 기존 저장소 클론)
mkdir talkboard-privacy-policy
cd talkboard-privacy-policy
git init

# privacy-policy.html 파일 복사
cp ../project/TalkBoard/docs/privacy-policy.html index.html

# 커밋 및 푸시
git add index.html
git commit -m "Add privacy policy"
git branch -M main
git remote add origin https://github.com/[사용자명]/talkboard-privacy-policy.git
git push -u origin main
```

---

## ✅ 확인 사항

### 개인정보 보호책임자 정보 업데이트 필요

`privacy-policy.html` 파일에서 다음 부분을 수정하세요:

```html
<li>연락처: [이메일 주소 또는 연락처를 입력하세요]</li>
<li>담당부서: [담당 부서명을 입력하세요]</li>
```

예시:
```html
<li>연락처: support@talkboard.com</li>
<li>담당부서: 고객지원팀</li>
```

---

## 🔗 URL 사용 방법

생성된 URL을 앱 스토어 등록 시 사용:

### Google Play Store
- **개인정보처리방침 URL** 필드에 입력
- 예: `https://yourname.github.io/talkboard-privacy-policy/`

### Apple App Store
- **개인정보처리방침 URL** 필드에 입력
- 예: `https://yourname.github.io/talkboard-privacy-policy/`

---

## 🎯 최종 체크리스트

- [ ] GitHub 저장소 생성 또는 확인
- [ ] `privacy-policy.html` 파일 업로드
- [ ] GitHub Pages 활성화
- [ ] URL 확인 및 접근 테스트
- [ ] 개인정보 보호책임자 정보 업데이트
- [ ] URL 복사하여 앱 스토어 등록 준비

---

## 💡 추가 팁

### 사용자 정의 도메인 (선택사항)

GitHub Pages는 사용자 정의 도메인도 지원합니다:

1. 도메인 구매 (예: `talkboard.com`)
2. DNS 설정
3. GitHub Pages 설정에서 Custom domain 추가

---

## 📚 관련 문서

- [GitHub Pages 공식 문서](https://docs.github.com/en/pages)
- [개인정보처리방침 파일](../docs/privacy-policy.html)

