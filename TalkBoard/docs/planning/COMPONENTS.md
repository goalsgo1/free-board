# 🧩 공통 컴포넌트 가이드

## 📋 개요

앱 전반에서 재사용할 수 있는 공통 컴포넌트, 레이아웃, 유틸리티를 정의합니다.

## 🎨 공통 컴포넌트 목록

### 1. 버튼 (Buttons)

#### 1.1 PrimaryButton
- **용도**: 주요 액션 버튼
- **스타일**: 파란색 배경, 흰색 텍스트, 둥근 모서리
- **사용 예**: 로그인, 저장, 제출
- **Props**: 
  - `text`: 버튼 텍스트
  - `onPressed`: 클릭 핸들러
  - `isLoading`: 로딩 상태
  - `isDisabled`: 비활성화 상태

#### 1.2 SecondaryButton
- **용도**: 보조 액션 버튼
- **스타일**: 투명 배경, 파란색 텍스트, 테두리
- **사용 예**: 취소, 뒤로가기
- **Props**: 
  - `text`: 버튼 텍스트
  - `onPressed`: 클릭 핸들러

#### 1.3 DangerButton
- **용도**: 위험한 액션 버튼
- **스타일**: 빨간색 배경, 흰색 텍스트
- **사용 예**: 삭제, 취소
- **Props**: 
  - `text`: 버튼 텍스트
  - `onPressed`: 클릭 핸들러
  - `requireConfirmation`: 확인 필요 여부

#### 1.4 IconButton
- **용도**: 아이콘만 있는 버튼
- **스타일**: 원형 또는 사각형, 아이콘 중심
- **사용 예**: 좋아요, 공유, 더보기
- **Props**: 
  - `icon`: 아이콘
  - `onPressed`: 클릭 핸들러
  - `color`: 아이콘 색상

#### 1.5 FloatingActionButton
- **용도**: 플로팅 액션 버튼
- **스타일**: 원형, 하단 우측 고정
- **사용 예**: 글 작성, 추모관 만들기
- **Props**: 
  - `icon`: 아이콘
  - `onPressed`: 클릭 핸들러
  - `tooltip`: 툴팁 텍스트

### 2. 입력 폼 (Input Forms)

#### 2.1 TextInputField
- **용도**: 텍스트 입력 필드
- **스타일**: 둥근 모서리, 부드러운 그림자, 라벨 위 표시
- **사용 예**: 이름, 이메일, 제목
- **Props**: 
  - `label`: 라벨 텍스트
  - `hint`: 힌트 텍스트
  - `controller`: 텍스트 컨트롤러
  - `validator`: 유효성 검사 함수
  - `obscureText`: 비밀번호 모드
  - `prefixIcon`: 앞 아이콘
  - `suffixIcon`: 뒤 아이콘
  - `textInputAction`: 키보드 액션
  - `onFieldSubmitted`: 제출 핸들러

#### 2.2 TextAreaField
- **용도**: 여러 줄 텍스트 입력
- **스타일**: TextInputField와 동일, 높이 조절 가능
- **사용 예**: 편지, 댓글, 내용
- **Props**: 
  - `label`: 라벨 텍스트
  - `hint`: 힌트 텍스트
  - `controller`: 텍스트 컨트롤러
  - `maxLines`: 최대 줄 수
  - `minLines`: 최소 줄 수

#### 2.3 DatePickerField
- **용도**: 날짜 선택 필드
- **스타일**: TextInputField와 동일, 날짜 선택기 열기
- **사용 예**: 기념일, 생일
- **Props**: 
  - `label`: 라벨 텍스트
  - `selectedDate`: 선택된 날짜
  - `onDateSelected`: 날짜 선택 핸들러
  - `firstDate`: 선택 가능한 최소 날짜
  - `lastDate`: 선택 가능한 최대 날짜

#### 2.4 ImagePickerField
- **용도**: 이미지 선택 및 업로드
- **스타일**: 업로드 버튼 + 미리보기 그리드
- **사용 예**: 사진 업로드
- **Props**: 
  - `label`: 라벨 텍스트
  - `images`: 이미지 리스트
  - `maxImages`: 최대 이미지 수
  - `onImagesSelected`: 이미지 선택 핸들러
  - `onImageRemoved`: 이미지 제거 핸들러

#### 2.5 AudioRecorderField
- **용도**: 오디오 녹음 필드
- **스타일**: 녹음 버튼 + 재생 컨트롤
- **사용 예**: 음성 편지
- **Props**: 
  - `label`: 라벨 텍스트
  - `audioUrl`: 오디오 URL
  - `onRecorded`: 녹음 완료 핸들러
  - `onDeleted`: 삭제 핸들러

### 3. 카드 (Cards)

#### 3.1 MemorialCard
- **용도**: 추모관 카드
- **스타일**: 사진 + 텍스트, 부드러운 그림자
- **사용 예**: 추모관 목록, 추천 추모관
- **Props**: 
  - `memorial`: 추모관 데이터
  - `onTap`: 탭 핸들러
  - `showActions`: 액션 버튼 표시 여부

#### 3.2 CommentCard
- **용도**: 댓글 카드
- **스타일**: 프로필 이미지 + 텍스트, 말풍선 스타일
- **사용 예**: 댓글 리스트
- **Props**: 
  - `comment`: 댓글 데이터
  - `onEdit`: 수정 핸들러
  - `onDelete`: 삭제 핸들러
  - `canEdit`: 수정 가능 여부

#### 3.3 PrayerCard
- **용도**: 기도 요청 카드
- **스타일**: 제목 + 내용 + 기도 카운트
- **사용 예**: 기도 요청 리스트
- **Props**: 
  - `prayer`: 기도 요청 데이터
  - `onPray`: 기도 참여 핸들러
  - `onComment`: 댓글 작성 핸들러

#### 3.4 EmotionCard
- **용도**: 감정 공유 글 카드
- **스타일**: 제목 + 내용 요약 + 좋아요/댓글 수
- **사용 예**: 감정 공유 게시판
- **Props**: 
  - `emotion`: 감정 글 데이터
  - `onTap`: 탭 핸들러
  - `onLike`: 좋아요 핸들러

### 4. 리스트 (Lists)

#### 4.1 MemorialList
- **용도**: 추모관 리스트
- **스타일**: 가로 스크롤 또는 그리드
- **사용 예**: 홈 화면 추천 추모관
- **Props**: 
  - `memorials`: 추모관 리스트
  - `onItemTap`: 아이템 탭 핸들러
  - `scrollDirection`: 스크롤 방향

#### 4.2 CommentList
- **용도**: 댓글 리스트
- **스타일**: 세로 스크롤, 카드형
- **사용 예**: 추모관 상세 댓글
- **Props**: 
  - `comments`: 댓글 리스트
  - `onCommentAdded`: 댓글 추가 핸들러
  - `onCommentEdited`: 댓글 수정 핸들러
  - `onCommentDeleted`: 댓글 삭제 핸들러

#### 4.3 PhotoGallery
- **용도**: 사진 갤러리
- **스타일**: 그리드 또는 슬라이드
- **사용 예**: 추모관 상세 사진
- **Props**: 
  - `photos`: 사진 리스트
  - `onPhotoTap`: 사진 탭 핸들러 (확대)
  - `layout`: 그리드 또는 슬라이드

### 5. 레이아웃 (Layouts)

#### 5.1 AppScaffold
- **용도**: 앱 기본 스캐폴드
- **스타일**: AppBar + Body + BottomNavigationBar
- **사용 예**: 모든 화면의 기본 레이아웃
- **Props**: 
  - `title`: AppBar 제목
  - `body`: 본문 위젯
  - `actions`: AppBar 액션 버튼
  - `bottomNavigationBar`: 하단 네비게이션
  - `floatingActionButton`: 플로팅 액션 버튼

#### 5.2 StepIndicator
- **용도**: 단계 표시기
- **스타일**: 진행 바, 단계 번호
- **사용 예**: 추모관 생성 단계
- **Props**: 
  - `currentStep`: 현재 단계
  - `totalSteps`: 전체 단계 수
  - `stepTitles`: 단계 제목 리스트

#### 5.3 LoadingOverlay
- **용도**: 로딩 오버레이
- **스타일**: 반투명 배경 + 로딩 인디케이터
- **사용 예**: 데이터 로딩 중
- **Props**: 
  - `isLoading`: 로딩 상태
  - `message`: 로딩 메시지

#### 5.4 EmptyState
- **용도**: 빈 상태 표시
- **스타일**: 아이콘 + 메시지 + 액션 버튼
- **사용 예**: 리스트가 비어있을 때
- **Props**: 
  - `icon`: 아이콘
  - `title`: 제목
  - `message`: 메시지
  - `actionText`: 액션 버튼 텍스트
  - `onAction`: 액션 핸들러

### 6. 모달 (Modals)

#### 6.1 ConfirmationDialog
- **용도**: 확인 다이얼로그
- **스타일**: 제목 + 내용 + 확인/취소 버튼
- **사용 예**: 삭제 확인, 취소 확인
- **Props**: 
  - `title`: 제목
  - `message`: 메시지
  - `confirmText`: 확인 버튼 텍스트
  - `cancelText`: 취소 버튼 텍스트
  - `onConfirm`: 확인 핸들러
  - `onCancel`: 취소 핸들러
  - `isDanger`: 위험한 액션 여부

#### 6.2 DonationModal
- **용도**: 추모금 전달 모달
- **스타일**: 금액 입력 + 수수료 안내 + 결제 수단 선택
- **사용 예**: 추모금 전달
- **Props**: 
  - `memorialId`: 추모관 ID
  - `onDonationComplete`: 추모금 완료 핸들러

#### 6.3 ImageViewerModal
- **용도**: 이미지 뷰어 모달
- **스타일**: 전체 화면, 확대/축소, 스와이프
- **사용 예**: 사진 확대 보기
- **Props**: 
  - `images`: 이미지 리스트
  - `initialIndex`: 초기 인덱스
  - `onClose`: 닫기 핸들러

### 7. 유틸리티 (Utilities)

#### 7.1 Validators
- **용도**: 입력 유효성 검사
- **함수**:
  - `validateEmail`: 이메일 형식 검사
  - `validatePassword`: 비밀번호 강도 검사
  - `validateRequired`: 필수 입력 검사
  - `validateMinLength`: 최소 길이 검사
  - `validateMaxLength`: 최대 길이 검사

#### 7.2 Formatters
- **용도**: 데이터 포맷팅
- **함수**:
  - `formatDate`: 날짜 포맷팅 (YYYY-MM-DD)
  - `formatDateTime`: 날짜시간 포맷팅
  - `formatCurrency`: 통화 포맷팅 (₩1,000)
  - `formatNumber`: 숫자 포맷팅 (1,000)
  - `formatRelativeTime`: 상대 시간 (방금 전, 1시간 전)

#### 7.3 ImageUtils
- **용도**: 이미지 처리
- **함수**:
  - `resizeImage`: 이미지 리사이징
  - `compressImage`: 이미지 압축
  - `getImageSize`: 이미지 크기 가져오기
  - `validateImageFormat`: 이미지 형식 검사

#### 7.4 AudioUtils
- **용도**: 오디오 처리
- **함수**:
  - `recordAudio`: 오디오 녹음
  - `playAudio`: 오디오 재생
  - `stopAudio`: 오디오 정지
  - `getAudioDuration`: 오디오 길이 가져오기

#### 7.5 StorageUtils
- **용도**: 파일 저장소 처리
- **함수**:
  - `uploadImage`: 이미지 업로드
  - `uploadVideo`: 동영상 업로드
  - `uploadAudio`: 오디오 업로드
  - `deleteFile`: 파일 삭제
  - `getDownloadUrl`: 다운로드 URL 가져오기

#### 7.6 NavigationUtils
- **용도**: 네비게이션 유틸리티
- **함수**:
  - `navigateTo`: 화면 이동
  - `navigateBack`: 뒤로가기
  - `showSnackBar`: 스낵바 표시
  - `showDialog`: 다이얼로그 표시

#### 7.7 PermissionUtils
- **용도**: 권한 처리
- **함수**:
  - `requestCameraPermission`: 카메라 권한 요청
  - `requestStoragePermission`: 저장소 권한 요청
  - `requestMicrophonePermission`: 마이크 권한 요청
  - `checkPermission`: 권한 확인

### 8. 상수 (Constants)

#### 8.1 AppColors
- **용도**: 앱 색상 상수
- **색상**:
  - `primary`: 파란색 (#2196F3)
  - `secondary`: 연한 파란색
  - `danger`: 빨간색 (#F44336)
  - `success`: 초록색 (#4CAF50)
  - `warning`: 노란색 (#FF9800)
  - `background`: 배경색 (베이지, 크림)
  - `textPrimary`: 텍스트 기본 색상
  - `textSecondary`: 텍스트 보조 색상

#### 8.2 AppSizes
- **용도**: 앱 크기 상수
- **크기**:
  - `padding`: 패딩 (16.0)
  - `margin`: 마진 (16.0)
  - `borderRadius`: 둥근 모서리 (8.0)
  - `cardElevation`: 카드 그림자 (2.0)
  - `buttonHeight`: 버튼 높이 (48.0)

#### 8.3 AppTextStyles
- **용도**: 앱 텍스트 스타일
- **스타일**:
  - `heading1`: 큰 제목 (32px, bold)
  - `heading2`: 중간 제목 (24px, bold)
  - `heading3`: 작은 제목 (20px, bold)
  - `body`: 본문 (16px, regular)
  - `caption`: 캡션 (14px, regular)
  - `button`: 버튼 텍스트 (16px, medium)

#### 8.4 AppLimits
- **용도**: 앱 제한 상수
- **제한**:
  - `maxPhotos`: 최대 사진 수 (5, 프리미엄: 무제한)
  - `maxPhotoSize`: 최대 사진 크기 (10MB)
  - `maxVideoSize`: 최대 동영상 크기 (100MB)
  - `maxAudioSize`: 최대 오디오 크기 (50MB)
  - `maxTextLength`: 최대 텍스트 길이 (5000자)

## 📁 폴더 구조

```
lib/
  ├── widgets/
  │   ├── buttons/
  │   │   ├── primary_button.dart
  │   │   ├── secondary_button.dart
  │   │   ├── danger_button.dart
  │   │   └── icon_button.dart
  │   ├── inputs/
  │   │   ├── text_input_field.dart
  │   │   ├── text_area_field.dart
  │   │   ├── date_picker_field.dart
  │   │   ├── image_picker_field.dart
  │   │   └── audio_recorder_field.dart
  │   ├── cards/
  │   │   ├── memorial_card.dart
  │   │   ├── comment_card.dart
  │   │   ├── prayer_card.dart
  │   │   └── emotion_card.dart
  │   ├── lists/
  │   │   ├── memorial_list.dart
  │   │   ├── comment_list.dart
  │   │   └── photo_gallery.dart
  │   ├── layouts/
  │   │   ├── app_scaffold.dart
  │   │   ├── step_indicator.dart
  │   │   ├── loading_overlay.dart
  │   │   └── empty_state.dart
  │   └── modals/
  │       ├── confirmation_dialog.dart
  │       ├── donation_modal.dart
  │       └── image_viewer_modal.dart
  ├── utils/
  │   ├── validators.dart
  │   ├── formatters.dart
  │   ├── image_utils.dart
  │   ├── audio_utils.dart
  │   ├── storage_utils.dart
  │   ├── navigation_utils.dart
  │   └── permission_utils.dart
  └── constants/
      ├── app_colors.dart
      ├── app_sizes.dart
      ├── app_text_styles.dart
      └── app_limits.dart
```

## 🎯 공용 컴포넌트 사용 가이드

### 1. 일관성 유지
- 모든 화면에서 동일한 컴포넌트 사용
- 스타일 통일로 사용자 경험 향상

### 2. 재사용성
- 자주 사용되는 UI 요소는 반드시 공용 컴포넌트로 만들기
- 중복 코드 제거

### 3. 유지보수성
- 한 곳에서 수정하면 전체 앱에 반영
- 버그 수정 및 기능 개선 용이

### 4. 확장성
- 새로운 기능 추가 시 기존 컴포넌트 재사용
- Props를 통한 커스터마이징 가능

## 📝 구현 우선순위

### Phase 1 (필수)
1. PrimaryButton, SecondaryButton
2. TextInputField, TextAreaField
3. MemorialCard, CommentCard
4. AppScaffold
5. Validators, Formatters
6. AppColors, AppSizes, AppTextStyles

### Phase 2 (중요)
1. DangerButton, IconButton
2. DatePickerField, ImagePickerField
3. PrayerCard, EmotionCard
4. StepIndicator, LoadingOverlay
5. ImageUtils, StorageUtils

### Phase 3 (선택)
1. AudioRecorderField
2. PhotoGallery
3. ConfirmationDialog, DonationModal
4. AudioUtils, PermissionUtils
5. EmptyState

