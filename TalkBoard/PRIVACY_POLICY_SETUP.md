# 개인정보처리방침 웹 호스팅 완료 가이드

## ✅ 완료된 작업

1. **개인정보처리방침 HTML 파일 생성 완료**
   - 파일 위치: `docs/privacy-policy.html`
   - 반응형 디자인 적용
   - 모바일 친화적 레이아웃

2. **GitHub Pages 호스팅 가이드 작성 완료**
   - 파일 위치: `docs/GITHUB_PAGES_SETUP.md`
   - 단계별 상세 가이드 제공

## 📋 다음 단계

### 1. GitHub에 파일 업로드

두 가지 방법 중 선택:

#### 방법 1: 웹 인터페이스 사용 (간단)

1. GitHub.com에 로그인
2. 새 저장소 생성:
   - 저장소 이름: `talkboard-privacy-policy` (또는 원하는 이름)
   - Public으로 설정
3. 저장소 페이지에서 "Upload files" 클릭
4. `docs/privacy-policy.html` 파일을 `index.html`로 이름 변경하여 업로드
5. "Commit changes" 클릭

#### 방법 2: 터미널 사용

```bash
# 1. 새 디렉토리 생성
cd ~/Documents/GitHub
mkdir talkboard-privacy-policy
cd talkboard-privacy-policy

# 2. Git 초기화
git init

# 3. 파일 복사
cp ~/Documents/GitHub/project/TalkBoard/docs/privacy-policy.html index.html

# 4. 커밋 및 푸시
git add index.html
git commit -m "Add privacy policy"
git branch -M main
git remote add origin https://github.com/[사용자명]/talkboard-privacy-policy.git
git push -u origin main
```

### 2. GitHub Pages 활성화

1. GitHub 저장소 페이지에서 **Settings** 클릭
2. 왼쪽 메뉴에서 **Pages** 클릭
3. **Source** 섹션에서:
   - Branch: `main` 선택
   - Folder: `/ (root)` 선택
4. **Save** 클릭

### 3. URL 확인

5-10분 후 다음 URL에서 접근 가능:
- `https://[사용자명].github.io/talkboard-privacy-policy/`

예시:
- `https://yourname.github.io/talkboard-privacy-policy/`

### 4. 개인정보 보호책임자 정보 업데이트

**중요**: `privacy-policy.html` 파일에서 다음 부분을 수정해야 합니다:

```html
<li>연락처: [이메일 주소 또는 연락처를 입력하세요]</li>
<li>담당부서: [담당 부서명을 입력하세요]</li>
```

수정 방법:
1. GitHub 저장소에서 `index.html` 파일 열기
2. "Edit this file" (연필 아이콘) 클릭
3. 위 두 줄을 실제 정보로 수정
4. "Commit changes" 클릭

---

## ✅ 완료 체크리스트

- [ ] GitHub 저장소 생성
- [ ] `privacy-policy.html` 파일 업로드
- [ ] GitHub Pages 활성화
- [ ] URL 확인 및 접근 테스트 (5-10분 후)
- [ ] 개인정보 보호책임자 정보 업데이트
- [ ] URL 복사하여 저장 (앱 스토어 등록 시 사용)

---

## 🔗 생성된 URL 사용 방법

생성된 URL을 다음 단계에서 사용:

1. **Google Play Console 등록 시**
   - "개인정보처리방침 URL" 필드에 입력

2. **Apple App Store Connect 등록 시**
   - "개인정보처리방침 URL" 필드에 입력

---

## 📝 현재 상태

### ✅ 완료
- [x] 개인정보처리방침 HTML 파일 생성
- [x] GitHub Pages 호스팅 가이드 작성

### ⏳ 진행 중
- [ ] GitHub에 파일 업로드
- [ ] GitHub Pages 활성화
- [ ] URL 확인 및 테스트

### 📌 다음 작업
1. GitHub에 파일 업로드 및 Pages 활성화
2. URL 확인 후 다음 단계 진행

---

## 💡 도움이 필요하신가요?

1. **GitHub 저장소 생성이 어려우신가요?**
   - `docs/GITHUB_PAGES_SETUP.md` 파일 참고

2. **URL이 작동하지 않나요?**
   - 5-10분 기다려보세요 (처음 활성화에는 시간이 걸립니다)
   - GitHub Pages 설정 확인 (Settings → Pages)

3. **다른 호스팅 방법을 원하시나요?**
   - Netlify: https://www.netlify.com (무료)
   - Vercel: https://vercel.com (무료)
   - 모두 간단한 드래그 앤 드롭으로 호스팅 가능

---

## 🎯 다음 단계

개인정보처리방침 URL이 준비되면:
1. URL 복사하여 저장
2. 다음 작업으로 진행: Google Play Console 계정 생성

