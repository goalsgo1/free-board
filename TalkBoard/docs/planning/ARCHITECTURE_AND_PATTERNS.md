# 🧭 Architecture & Patterns Guide

## Summary
- **Current**: Provider 기반 MVVM 구조, `services`·`providers`·`screens`로 역할을 분리
- **Target**: Riverpod + Clean Architecture 조합을 채택해 확장성과 테스트 용이성을 강화
- **Goal**: 인증/게시물/알림 등 증가하는 도메인을 안정적으로 관리하고, 비동기 상태를 명확히 표현

## 선정 패턴 스택
- **Presentation**: Riverpod `StateNotifier` + `AsyncValue` 로 UI 상태 관리
- **Domain**: Use case 계층을 명시하고, 도메인 모델과 규칙을 정의
- **Data**: Repository 패턴으로 Firebase·로컬 소스를 추상화, `services` 는 I/O 중심
- **Cross-cutting**: `ProviderScope` + `ProviderObserver` 로 로깅, `Ref.listen`으로 사이드이펙트 제어

## Riverpod를 선택한 이유
- **Pros**
  - Provider 대비 명시적인 의존성 그래프, 전역 접근 제어, 테스트 더 간단
  - 코드 자동완성/리팩터링 친화적 (generator 없이도 타입 추적)
  - null-safe 이후 커뮤니티 성장, 문서화 및 샘플 풍부
- **Cons**
  - Provider보다 개념(ProviderFamily, AutoDispose 등)이 많아 학습이 필요
  - Provider와 혼용 시 의존성 순환을 주의해야 함
- **채택 근거**
  - 최신 Flutter 프로젝트에서 가장 빠르게 확산 중이며, 안정된 3.x 릴리즈와 활발한 유지보수
  - 앱 규모 확장(소셜 로그인, 전화 인증, 푸시 알림, 구독) 대비 구조적 대비 필요

## 레이어 구성
- **core/**
  - 공용 유틸, 에러/결과 타입, 앱 테마, ProviderObserver 등
- **features/**
  - 도메인별 서브모듈 (예: `auth`, `posts`, `notifications`)
  - 각 모듈은 `presentation/`, `application/`, `domain/`, `data/` 디렉터리를 보유
- **presentation**
  - Flutter 위젯과 `ConsumerWidget`, `HookConsumerWidget` 중심
  - 상태는 `StateNotifierProvider`, 단순 값은 `Provider` 또는 `FutureProvider`
- **application**
  - Use case (서비스 조합), 입력/출력 DTO 정리
- **domain**
  - 엔티티, Value Object, Repository 인터페이스
- **data**
  - Firebase/REST/로컬 구현, DTO ↔ 엔티티 매퍼

## 상태 관리 가이드
- UI는 `AsyncValue<T>` 또는 `StateNotifier<AsyncValue<T>>`로 비동기 상태를 표현
- 다단계 인증 플로우는 `StateNotifier`로 분기 상태를 명시
- 글로벌 싱글톤 대신 Provider를 통해 의존성 주입 (`ProviderScope` 확장)
- `ref.listen`을 활용해 스낵바, 네비게이션 등 사이드이펙트를 UI 레이어로 한정

## 샘플 구조
```
lib/
 ├─ core/
 │   ├─ configs/
 │   ├─ errors/
 │   ├─ logging/provider_observer.dart
 │   └─ router/
 ├─ features/
 │   └─ auth/
 │       ├─ presentation/
 │       │   ├─ login_screen.dart
│       │   └─ controllers/login_controller.dart  // StateNotifier
 │       ├─ application/
 │       │   └─ sign_in_with_google.dart          // use case
 │       ├─ domain/
 │       │   ├─ entities/user.dart
 │       │   └─ repositories/auth_repository.dart
 │       └─ data/
 │           ├─ datasources/firebase_auth_datasource.dart
 │           ├─ repositories/auth_repository_impl.dart
 │           └─ mappers/auth_mapper.dart
 └─ firebase_options.dart
```

## 테스트 전략
- **Unit**: StateNotifier, Use case, Repository 구현을 각각 테스트
- **Widget**: `ProviderScope.overrides` 로 목 주입 후 UI 흐름 검증
- **Integration**: Firebase Emulator Suite + golden test로 인증/DB 연계 확인

## 마이그레이션 체크리스트
- [ ] `lib/main.dart` 에 `ProviderScope` 추가, `RiverpodObserver` 도입
- [ ] `pubspec.yaml` 에 `flutter_riverpod`, (필요시) `hooks_riverpod` 추가
- [ ] 기존 `AuthProvider` → `AuthController extends StateNotifier<AuthState>` 로 변환
- [ ] Repository 인터페이스 추출 및 의존성 그래프 정의 (`Provider`, `Provider.autoDispose`)
- [ ] 화면별 Provider mapping 문서화 및 Storybook/Preview 업데이트
- [ ] 테스팅 템플릿 갱신 (`setUpProviderContainer`, `overrideWithValue`)
- [ ] Lint 규칙에 `prefer_final_locals`, `avoid_unused_constructor_parameters` 등 Riverpod 권장 규칙 반영

## 향후 보완 항목
- Riverpod Generator(`riverpod_annotation`) 도입 여부 검토
- Domain 이벤트 로깅을 `ProviderObserver` 기반으로 통합
- StateMachine(예: `state_machine` 패키지)과 연동해 복잡한 플로우 모델링
- 모듈별 README로 의존성, 프로바이더 구조, 테스팅 가이드 추가

## 참고 자료
- [Riverpod 공식 문서](https://riverpod.dev)
- [Flutter 공식 상태 관리 가이드](https://docs.flutter.dev/development/data-and-backend/state-mgmt/options)
- [Clean Architecture for Flutter (Reso Coder)](https://resocoder.com)

