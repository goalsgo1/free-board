# Provider 패턴 적용 커밋 메시지

## 짧은 버전 (Short)

```
feat: Provider 패턴 적용하여 상태 관리 개선

- AuthProvider, PostProvider, CommentProvider 추가
- 화면들을 Provider 기반으로 리팩토링
- 상태 관리 중앙화 및 코드 재사용성 향상
```

## 상세 버전 (Detailed)

```
feat: Provider 패턴 적용하여 상태 관리 개선

### 주요 변경 사항

#### Provider 클래스 추가
- AuthProvider: 인증 상태 관리 (로그인/회원가입/로그아웃)
- PostProvider: 게시글 상태 관리 (CRUD, 실시간 목록)
- CommentProvider: 댓글 상태 관리 (게시글별 댓글 목록)

#### main.dart 개선
- MultiProvider로 모든 Provider 등록
- AuthWrapper를 Consumer<AuthProvider>로 변경

#### 화면 리팩토링
- AuthScreen: AuthProvider 사용으로 변경
- PostListScreen: PostProvider, AuthProvider 사용 (StreamBuilder → Consumer)
- PostDetailScreen: 기존 코드와 호환 유지

### 개선 효과
- 상태 관리 중앙화
- 코드 재사용성 향상
- 테스트 가능성 향상
- 성능 최적화 (Consumer로 선택적 업데이트)

### 추가 파일
- PROVIDER_REFACTORING_SUMMARY.md: 리팩토링 요약 문서
- ARCHITECTURE_ANALYSIS.md: 아키텍처 분석 문서
```

## Conventional Commits 형식

```
feat(state-management): Provider 패턴 적용

Provider 패턴을 적용하여 상태 관리를 개선하고 코드 구조를 개선했습니다.

BREAKING CHANGE: 없음 (기존 기능 모두 유지)

Changes:
- Add: AuthProvider, PostProvider, CommentProvider
- Update: main.dart (MultiProvider 추가)
- Refactor: AuthScreen, PostListScreen (Provider 사용)
- Docs: Provider 리팩토링 문서 추가

Co-authored-by: FreeBoard Development Team
```

