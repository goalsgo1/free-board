# GitHub 파일 업로드 가이드

## 📍 "Add file" 및 "Upload files" 버튼 위치

### 방법 1: 저장소 메인 페이지에서

1. **저장소 메인 페이지 상단**에 "Add file" 버튼이 있습니다
   - 위치: 저장소 이름 오른쪽, "Code" 탭 옆
   - 버튼 텍스트: "Add file" (드롭다운 메뉴)
   - 클릭하면 두 가지 옵션:
     - "Create new file" - 새 파일 생성
     - "Upload files" - 기존 파일 업로드

2. **또는 "Quick setup" 섹션**에서:
   - 페이지 중간에 "Quick setup — if you've done this kind of thing before" 섹션이 있습니다
   - 이 섹션 안에 다음과 같은 텍스트가 있습니다:
     - **"creating a new file"** (링크) - 새 파일 생성
     - **"uploading an existing file"** (링크) - 기존 파일 업로드
   - 이 링크들을 클릭하면 파일 업로드/생성 페이지로 이동합니다

### 방법 2: 단계별 안내

#### "Add file" 버튼 사용하기

1. 저장소 메인 페이지 (Code 탭)에서:
   ```
   [GitHub 로고] goalsgo1 / talkboard-privacy-policy  [Code ▼] [Issues] [Pull requests] ...
                                                              ↑
                                                    여기 오른쪽에 "Add file" 버튼
   ```

2. "Add file" 버튼 클릭
   - 드롭다운 메뉴가 나타남:
     - "Create new file"
     - "Upload files" ← 이걸 클릭

3. "Upload files" 클릭
   - 파일 업로드 페이지로 이동
   - 파일을 드래그 앤 드롭하거나 "choose your files" 클릭

#### "Quick setup" 섹션 링크 사용하기

1. 저장소 메인 페이지를 아래로 스크롤
2. "Quick setup" 섹션 찾기 (파란색 테두리)
3. "**uploading an existing file**" 링크 클릭 (링크 텍스트는 볼드 처리됨)

---

## 📝 파일 업로드 단계별 가이드

### Step 1: "Upload files" 페이지로 이동

**방법 A: "Add file" 버튼 사용**
1. 저장소 메인 페이지 우측 상단의 "Add file" 버튼 클릭
2. 드롭다운에서 "Upload files" 선택

**방법 B: "Quick setup" 섹션 사용**
1. 페이지를 아래로 스크롤
2. "Quick setup" 섹션의 "**uploading an existing file**" 링크 클릭

### Step 2: 파일 업로드

1. **파일 선택 방법**:
   - 방법 1: 파일을 드래그하여 "Drag files here" 영역에 드롭
   - 방법 2: "choose your files" 버튼 클릭하여 파일 선택

2. **파일 업로드**:
   - 로컬 컴퓨터에서 `docs/privacy-policy.html` 파일 선택
   - 파일명을 `index.html`로 변경 (중요!)
   - 또는 업로드 후 파일명 변경 가능

### Step 3: 파일명 변경 (중요!)

업로드한 파일의 파일명을 `index.html`로 변경:

1. 업로드된 파일 목록에서 파일명 클릭
2. `privacy-policy.html` → `index.html`로 변경
3. 또는 처음부터 `index.html`로 업로드

### Step 4: 커밋 및 저장

1. 페이지 하단의 "Commit changes" 섹션에서:
   - "Commit message" 입력 (예: "Add privacy policy")
   - "Commit directly to the main branch" 선택 (또는 새 브랜치 생성)
   
2. "Commit changes" 버튼 클릭

---

## 🎯 빠른 업로드 방법 (추천)

### 가장 빠른 방법:

1. 저장소 메인 페이지에서 **"Add file"** 버튼 클릭 (우측 상단)
2. 드롭다운에서 **"Upload files"** 선택
3. 파일 드래그 앤 드롭 또는 "choose your files" 클릭
4. `docs/privacy-policy.html` 파일 선택
5. 파일명을 `index.html`로 변경
6. "Commit changes" 버튼 클릭

---

## 📸 버튼 위치 시각적 설명

```
┌─────────────────────────────────────────────────────────┐
│ GitHub Logo  goalsgo1 / talkboard-privacy-policy       │
│              [Code▼][Issues][PR]...[Add file▼] ◄─── 여기!│
├─────────────────────────────────────────────────────────┤
│                                                         │
│  (저장소 내용)                                          │
│                                                         │
│  ┌─ Quick setup ──────────────────────────────────┐   │
│  │ ... or upload files by                            │   │
│  │ **creating a new file** or **uploading an        │   │
│  │ existing file** ◄──────── 여기 링크 클릭 가능!     │   │
│  └──────────────────────────────────────────────────┘   │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## ✅ 체크리스트

- [ ] 저장소 메인 페이지 접속
- [ ] "Add file" 버튼 찾기 (우측 상단)
- [ ] 또는 "Quick setup" 섹션에서 "uploading an existing file" 링크 찾기
- [ ] 파일 업로드 페이지로 이동
- [ ] `privacy-policy.html` 파일 업로드
- [ ] 파일명을 `index.html`로 변경
- [ ] "Commit changes" 클릭

---

## 💡 팁

- **"Add file" 버튼이 안 보이나요?**
  - 페이지를 새로고침해보세요 (F5 또는 Cmd+R)
  - 저장소에 대한 쓰기 권한이 있는지 확인하세요

- **파일 업로드가 느린가요?**
  - 인터넷 연결을 확인하세요
  - 파일 크기가 작으면(11KB) 보통 빠르게 업로드됩니다

---

## 🔗 다음 단계

파일 업로드가 완료되면:
1. GitHub Pages 활성화
2. URL 확인

