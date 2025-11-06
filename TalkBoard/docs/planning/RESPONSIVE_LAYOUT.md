# 📱 반응형 레이아웃 가이드라인

## 📋 개요

모든 화면은 다양한 모바일 기기 크기에서도 레이아웃이 깨지지 않도록 반응형으로 설계되어야 합니다. 특히 작은 화면(최소 320px 너비)에서도 텍스트 오버플로우, 제목 잘림, 레이아웃 깨짐이 발생하지 않아야 합니다.

## 🎯 목표

1. **모든 화면 크기 지원**: 320px ~ 480px (작은 화면) ~ 768px 이상 (태블릿)
2. **텍스트 오버플로우 방지**: 모든 텍스트가 화면 밖으로 나가지 않도록
3. **제목 잘림 방지**: 제목이 화면 밖으로 나가지 않도록
4. **레이아웃 깨짐 방지**: 모든 요소가 올바른 위치에 배치되도록
5. **입력 필드 최적화**: 작은 화면에서도 입력이 편리하도록
6. **버튼 크기 최적화**: 터치하기 쉬운 크기 유지

---

## 📐 화면 크기 기준

### 모바일 화면 크기 분류

| 화면 크기 | 너비 범위 | 기기 예시 | 우선순위 |
|---------|---------|---------|---------|
| **작은 화면** | 320px ~ 375px | iPhone SE, 작은 안드로이드 | 최우선 |
| **중간 화면** | 376px ~ 414px | iPhone 12/13/14, 일반 안드로이드 | 높음 |
| **큰 화면** | 415px ~ 480px | iPhone Pro Max, 큰 안드로이드 | 중간 |
| **태블릿** | 481px ~ 768px | iPad Mini | 낮음 |

### 최소 화면 크기
- **최소 너비**: 320px (iPhone SE 기준)
- **최소 높이**: 568px (iPhone SE 기준)

---

## 🎨 반응형 레이아웃 원칙

### 1. 텍스트 처리

#### 제목 (Title)
- **최대 길이**: 화면 너비의 80% 이하
- **폰트 크기**: 
  - 작은 화면 (320px): 16px ~ 18px
  - 중간 화면 (375px): 18px ~ 20px
  - 큰 화면 (414px+): 20px ~ 24px
- **오버플로우 처리**: 
  - `TextOverflow.ellipsis` 사용
  - 최대 2줄까지 표시
  - 필요시 "..." 표시
- **예시**:
```dart
Text(
  title,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
  style: TextStyle(
    fontSize: MediaQuery.of(context).size.width < 375 ? 16 : 18,
  ),
)
```

#### 본문 텍스트 (Body Text)
- **폰트 크기**: 
  - 작은 화면: 12px ~ 14px
  - 중간 화면: 14px ~ 16px
  - 큰 화면: 16px
- **줄 간격**: 1.4 ~ 1.6
- **오버플로우 처리**: 
  - `Flexible` 또는 `Expanded` 위젯 사용
  - 스크롤 가능하도록
- **예시**:
```dart
Flexible(
  child: Text(
    content,
    style: TextStyle(
      fontSize: MediaQuery.of(context).size.width < 375 ? 12 : 14,
      height: 1.5,
    ),
  ),
)
```

#### 긴 텍스트 처리
- **최대 줄 수**: 3~5줄
- **"더 보기" 버튼**: 긴 텍스트는 접기/펼치기 기능 제공
- **스크롤**: 필요시 `SingleChildScrollView` 사용

### 2. 입력 필드 (Input Fields)

#### 텍스트 입력 필드
- **최소 높이**: 44px (터치하기 쉬운 크기)
- **패딩**: 좌우 12px, 상하 12px
- **폰트 크기**: 최소 16px (iOS 자동 줌 방지)
- **너비**: 화면 너비 - 32px (좌우 여백 16px)
- **예시**:
```dart
Container(
  width: MediaQuery.of(context).size.width - 32,
  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
  child: TextField(
    style: TextStyle(fontSize: 16),
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    ),
  ),
)
```

#### 다중 줄 입력 필드
- **최소 높이**: 100px
- **최대 높이**: 화면 높이의 30% 이하
- **스크롤**: 내용이 많을 경우 자동 스크롤

### 3. 버튼 (Buttons)

#### 주요 버튼 (Primary Button)
- **최소 높이**: 48px
- **최소 너비**: 120px
- **패딩**: 좌우 24px, 상하 12px
- **폰트 크기**: 14px ~ 16px
- **여백**: 버튼 간 최소 8px

#### 보조 버튼 (Secondary Button)
- **최소 높이**: 44px
- **최소 너비**: 100px
- **패딩**: 좌우 16px, 상하 10px
- **폰트 크기**: 12px ~ 14px

#### 작은 화면 대응
- **전체 너비 버튼**: 작은 화면에서는 버튼을 전체 너비로 표시
- **예시**:
```dart
SizedBox(
  width: MediaQuery.of(context).size.width < 375 
    ? double.infinity 
    : 200,
  child: ElevatedButton(...),
)
```

### 4. 카드 (Cards)

#### 카드 레이아웃
- **여백**: 좌우 16px
- **카드 간 간격**: 12px
- **패딩**: 내부 16px
- **최소 높이**: 콘텐츠에 따라 자동 조정
- **최대 너비**: 화면 너비 - 32px

#### 카드 내부 요소
- **이미지**: 
  - 최대 너비: 카드 너비
  - 비율 유지 (16:9 또는 4:3)
  - 작은 화면: 높이 120px ~ 150px
- **텍스트**: 
  - `Flexible` 또는 `Expanded` 사용
  - 오버플로우 방지
- **예시**:
```dart
Card(
  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
  child: Container(
    width: MediaQuery.of(context).size.width - 32,
    padding: EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Flexible(
          child: Text(
            content,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  ),
)
```

### 5. 이미지 (Images)

#### 이미지 크기
- **최대 너비**: 화면 너비 - 32px
- **비율 유지**: `BoxFit.cover` 또는 `BoxFit.contain`
- **작은 화면**: 
  - 썸네일: 80px × 80px
  - 카드 이미지: 120px × 120px
  - 전체 화면 이미지: 화면 너비에 맞춤

#### 이미지 갤러리
- **그리드 레이아웃**: 
  - 작은 화면: 2열
  - 중간 화면: 3열
  - 큰 화면: 4열
- **이미지 간격**: 4px ~ 8px

### 6. 리스트 (Lists)

#### 리스트 아이템
- **최소 높이**: 60px
- **패딩**: 좌우 16px, 상하 12px
- **아이콘 크기**: 24px ~ 32px
- **텍스트**: `Flexible` 사용하여 오버플로우 방지

#### 리스트 레이아웃
- **여백**: 좌우 0px (전체 너비)
- **구분선**: 아이템 간 구분선 표시
- **스크롤**: `ListView` 또는 `ListView.builder` 사용

### 7. 모달 (Modals)

#### 모달 크기
- **최대 너비**: 화면 너비 - 32px
- **최대 높이**: 화면 높이의 80%
- **패딩**: 16px ~ 20px
- **스크롤**: 내용이 많을 경우 `SingleChildScrollView` 사용

#### 모달 내부 요소
- **제목**: 최대 2줄, 오버플로우 처리
- **내용**: 스크롤 가능
- **버튼**: 하단 고정, 전체 너비 또는 적절한 크기

### 8. AppBar 및 BottomNavigationBar

#### AppBar
- **높이**: 56px (기본)
- **제목**: 
  - 최대 길이: 화면 너비의 60%
  - 오버플로우 처리
- **액션 버튼**: 최대 3개 (작은 화면에서는 2개)

#### BottomNavigationBar
- **높이**: 56px + SafeArea
- **아이콘 크기**: 24px
- **텍스트 크기**: 10px ~ 12px
- **아이템 수**: 5개 이하

---

## 🔧 Flutter 반응형 레이아웃 구현

### 1. MediaQuery 사용

```dart
// 화면 크기 가져오기
final screenWidth = MediaQuery.of(context).size.width;
final screenHeight = MediaQuery.of(context).size.height;

// 작은 화면 여부 확인
final isSmallScreen = screenWidth < 375;
final isMediumScreen = screenWidth >= 375 && screenWidth < 414;
final isLargeScreen = screenWidth >= 414;
```

### 2. LayoutBuilder 사용

```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth < 375) {
      // 작은 화면 레이아웃
      return SmallScreenLayout();
    } else if (constraints.maxWidth < 414) {
      // 중간 화면 레이아웃
      return MediumScreenLayout();
    } else {
      // 큰 화면 레이아웃
      return LargeScreenLayout();
    }
  },
)
```

### 3. Flexible 및 Expanded 사용

```dart
Row(
  children: [
    Expanded(
      child: Text(
        longText,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    SizedBox(width: 8),
    Icon(Icons.arrow_forward),
  ],
)
```

### 4. SingleChildScrollView 사용

```dart
SingleChildScrollView(
  child: Column(
    children: [
      // 콘텐츠
    ],
  ),
)
```

### 5. ConstrainedBox 사용

```dart
ConstrainedBox(
  constraints: BoxConstraints(
    maxWidth: MediaQuery.of(context).size.width - 32,
    maxHeight: MediaQuery.of(context).size.height * 0.8,
  ),
  child: Container(
    // 콘텐츠
  ),
)
```

---

## 📱 화면별 반응형 레이아웃 규칙

### 1. 홈 화면

#### 작은 화면 (320px ~ 375px)
- **AppBar 제목**: "기억의 정원" → "기억의 정원" (최대 1줄)
- **앱의 목적과 마인드 섹션**:
  - 제목: 16px
  - 메인 메시지: 14px
  - 서브 메시지: 12px
  - 패딩: 12px
- **기념일 알림 카드**:
  - 높이: 100px
  - 패딩: 12px
  - 폰트 크기: 12px ~ 14px
- **추모글 카드**:
  - 높이: 180px
  - 이미지: 100px × 100px
  - 텍스트: 최대 2줄
- **최근 등록된 추모관**:
  - 카드 너비: 120px
  - 이미지: 80px × 80px

#### 중간 화면 (375px ~ 414px)
- **AppBar 제목**: 18px
- **앱의 목적과 마인드 섹션**:
  - 제목: 18px
  - 메인 메시지: 16px
  - 서브 메시지: 14px
  - 패딩: 16px
- **기념일 알림 카드**:
  - 높이: 120px
  - 패딩: 16px
- **추모글 카드**:
  - 높이: 200px
  - 이미지: 120px × 120px

#### 큰 화면 (414px+)
- **추모글 카드**: 높이 220px
- **이미지**: 140px × 140px

### 2. 추모관 목록 화면

#### 작은 화면
- **검색창**: 전체 너비 - 32px
- **리스트 아이템**:
  - 이미지: 60px × 60px
  - 텍스트 영역: `Expanded` 사용
  - 제목: 최대 1줄
  - 요약: 최대 2줄
- **필터 버튼**: 아이콘만 표시

#### 중간 화면
- **이미지**: 80px × 80px
- **제목**: 최대 2줄

### 3. 추모관 상세 화면

#### 작은 화면
- **고인 이름**: 18px, 최대 1줄
- **생애 요약**: 12px, 최대 3줄
- **영원한 시간**: 14px
- **사진 갤러리**: 2열 그리드
- **편지 영역**:
  - 최대 높이: 화면 높이의 40%
  - 스크롤 가능
- **댓글 카드**:
  - 패딩: 12px
  - 폰트 크기: 12px
- **하단 버튼**: 전체 너비, 세로 배치

#### 중간 화면
- **사진 갤러리**: 3열 그리드
- **댓글 카드**: 패딩 16px

### 4. 추모관 생성/수정 화면

#### 작은 화면
- **Step Indicator**: 아이콘만 표시
- **입력 필드**: 전체 너비
- **이미지 업로드**:
  - 그리드: 2열
  - 이미지 크기: 80px × 80px
- **버튼**: 전체 너비, 세로 배치
- **저장 버튼**: 하단 고정

#### 중간 화면
- **Step Indicator**: 아이콘 + 텍스트
- **이미지 그리드**: 3열

### 5. 기도 요청 화면

#### 작은 화면
- **기도 카드**:
  - 패딩: 12px
  - 제목: 14px, 최대 2줄
  - 내용: 12px, 최대 3줄
- **댓글 입력창**: 전체 너비
- **댓글 카드**: 패딩 12px

### 6. 감정 공유 게시판

#### 작은 화면
- **글 카드**:
  - 패딩: 12px
  - 제목: 14px, 최대 2줄
  - 내용: 12px, 최대 3줄
- **필터 칩**: 가로 스크롤
- **FAB**: 오른쪽 하단 고정

### 7. 마이페이지

#### 작은 화면
- **프로필 영역**: 높이 120px
- **아바타**: 60px × 60px
- **섹션 제목**: 14px
- **리스트 아이템**: 최소 높이 56px
- **버튼**: 전체 너비

### 8. 검색 화면

#### 작은 화면
- **검색창**: 전체 너비
- **필터 칩**: 가로 스크롤
- **검색 결과 카드**: 
  - 패딩: 12px
  - 이미지: 60px × 60px
  - 텍스트: `Expanded` 사용

---

## 🛠️ 공통 반응형 위젯

### 1. 반응형 텍스트

```dart
class ResponsiveText extends StatelessWidget {
  final String text;
  final double smallSize;
  final double mediumSize;
  final double largeSize;
  final int maxLines;
  final TextOverflow overflow;

  ResponsiveText({
    required this.text,
    this.smallSize = 12,
    this.mediumSize = 14,
    this.largeSize = 16,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double fontSize = mediumSize;
    
    if (screenWidth < 375) {
      fontSize = smallSize;
    } else if (screenWidth >= 414) {
      fontSize = largeSize;
    }

    return Text(
      text,
      style: TextStyle(fontSize: fontSize),
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
```

### 2. 반응형 패딩

```dart
class ResponsivePadding extends StatelessWidget {
  final Widget child;
  final double smallPadding;
  final double mediumPadding;
  final double largePadding;

  ResponsivePadding({
    required this.child,
    this.smallPadding = 12,
    this.mediumPadding = 16,
    this.largePadding = 20,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double padding = mediumPadding;
    
    if (screenWidth < 375) {
      padding = smallPadding;
    } else if (screenWidth >= 414) {
      padding = largePadding;
    }

    return Padding(
      padding: EdgeInsets.all(padding),
      child: child,
    );
  }
}
```

### 3. 반응형 버튼

```dart
class ResponsiveButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isFullWidth;

  ResponsiveButton({
    required this.text,
    required this.onPressed,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 375;
    
    return SizedBox(
      width: isSmallScreen || isFullWidth 
        ? double.infinity 
        : null,
      height: isSmallScreen ? 48 : 44,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: isSmallScreen ? 14 : 16,
          ),
        ),
      ),
    );
  }
}
```

### 4. 반응형 카드

```dart
class ResponsiveCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  ResponsiveCard({
    required this.child,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 375;
    
    return Card(
      margin: margin ?? EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 12 : 16,
        vertical: isSmallScreen ? 6 : 8,
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.all(
          isSmallScreen ? 12 : 16,
        ),
        child: child,
      ),
    );
  }
}
```

---

## ✅ 반응형 레이아웃 체크리스트

### 텍스트
- [ ] 모든 제목이 화면 밖으로 나가지 않음
- [ ] 긴 텍스트는 `TextOverflow.ellipsis` 처리
- [ ] 최대 줄 수 제한 (2~3줄)
- [ ] 폰트 크기가 화면 크기에 맞게 조정됨
- [ ] 작은 화면에서도 텍스트가 읽기 쉬움 (최소 12px)

### 입력 필드
- [ ] 입력 필드가 화면 너비를 초과하지 않음
- [ ] 최소 높이 44px (터치하기 쉬운 크기)
- [ ] 폰트 크기 최소 16px (iOS 자동 줌 방지)
- [ ] 다중 줄 입력 필드가 스크롤 가능

### 버튼
- [ ] 버튼이 화면 밖으로 나가지 않음
- [ ] 최소 높이 44px
- [ ] 작은 화면에서는 전체 너비 버튼 사용
- [ ] 버튼 간 간격 적절함

### 이미지
- [ ] 이미지가 화면 너비를 초과하지 않음
- [ ] 비율이 유지됨
- [ ] 작은 화면에서도 적절한 크기

### 카드
- [ ] 카드가 화면 너비를 초과하지 않음
- [ ] 카드 내부 요소가 오버플로우되지 않음
- [ ] 패딩이 화면 크기에 맞게 조정됨

### 리스트
- [ ] 리스트 아이템이 화면 너비를 초과하지 않음
- [ ] 텍스트가 `Flexible` 또는 `Expanded`로 처리됨
- [ ] 스크롤이 정상 작동함

### 모달
- [ ] 모달이 화면 크기를 초과하지 않음
- [ ] 내용이 많을 경우 스크롤 가능
- [ ] 버튼이 항상 보임

### 전체 레이아웃
- [ ] 모든 화면에서 `SingleChildScrollView` 사용
- [ ] 고정 높이 사용 시 최소값 설정
- [ ] `Flexible` 및 `Expanded` 적절히 사용
- [ ] 작은 화면 (320px)에서도 레이아웃이 깨지지 않음

---

## 🧪 테스트 방법

### 1. Flutter DevTools 사용
- **Device Preview**: 다양한 기기 크기로 테스트
- **Layout Explorer**: 레이아웃 구조 확인

### 2. 실제 기기 테스트
- **iPhone SE (320px)**: 최소 화면 크기
- **iPhone 12/13 (390px)**: 일반 화면 크기
- **iPhone Pro Max (428px)**: 큰 화면 크기
- **Android 기기**: 다양한 크기

### 3. 시뮬레이터 테스트
- **iOS Simulator**: 다양한 iPhone 모델
- **Android Emulator**: 다양한 화면 크기

### 4. 자동화 테스트
```dart
testWidgets('홈 화면 작은 화면 테스트', (WidgetTester tester) async {
  await tester.binding.setSurfaceSize(Size(320, 568));
  await tester.pumpWidget(MyApp());
  
  // 레이아웃 깨짐 확인
  expect(find.byType(Overflow), findsNothing);
});
```

---

## 📝 주의사항

1. **고정 너비 사용 금지**: `width: 400` 같은 고정값 사용 금지
2. **고정 높이 주의**: 최소값만 설정하고 `mainAxisSize: MainAxisSize.min` 사용
3. **텍스트 오버플로우**: 항상 `maxLines`와 `overflow` 처리
4. **이미지 크기**: `BoxFit` 적절히 사용
5. **스크롤**: 내용이 많을 경우 항상 스크롤 가능하도록
6. **터치 영역**: 최소 44px × 44px 유지
7. **폰트 크기**: 최소 12px (가독성), 입력 필드는 최소 16px

---

## 🔄 업데이트 계획

### 정기 검토
- **월 1회**: 새로운 화면 추가 시 반응형 레이아웃 확인
- **분기 1회**: 전체 화면 반응형 레이아웃 검토

### 사용자 피드백 반영
- 사용자가 보고한 레이아웃 깨짐 문제 즉시 수정
- 다양한 기기에서 테스트 후 개선

