# 🌱 초기 데이터 생성 가이드

## 📋 개요

앱 출시 시 초기 데이터가 없어 사용자 경험이 저하될 수 있습니다. AI를 활용하여 감성적이고 자연스러운 초기 추모 데이터를 생성합니다.

**⚠️ 중요**: AI로 생성한 초기 데이터는 사용자에게 불쾌감을 줄 수 있으므로, 나중에 실제 사용자 데이터가 많아지면 제거할 수 있도록 설계합니다.

## 🎯 목표

1. **사용자 경험 향상**: 앱 출시 시 바로 추모 콘텐츠를 확인할 수 있도록
2. **감성적 콘텐츠**: AI를 활용하여 진정성 있는 추모글 생성
3. **다양성**: 사람/애완동물, 다양한 연령대, 다양한 상황의 추모관 생성
4. **제거 가능성**: AI 생성 데이터를 식별하고 나중에 제거할 수 있도록 설계

## 🤖 AI 활용 방안

### 1. AI API 선택

#### 옵션 1: OpenAI GPT-4
- **장점**: 높은 품질의 한국어 생성, 감성적 텍스트 생성 우수
- **단점**: 비용 발생
- **API**: `openai` 패키지 사용

#### 옵션 2: Claude (Anthropic)
- **장점**: 긴 컨텍스트 처리, 감성적 텍스트 생성 우수
- **단점**: 비용 발생
- **API**: `anthropic` 패키지 사용

#### 옵션 3: 한국어 특화 AI
- **장점**: 한국어에 최적화, 비용 효율적
- **예시**: 네이버 클로바, 카카오 i, LG AI
- **단점**: API 제공 여부 확인 필요

#### 옵션 4: 로컬 LLM (선택)
- **장점**: 비용 없음, 프라이버시 보장
- **단점**: 서버 리소스 필요, 품질 제한
- **예시**: Llama 2, Mistral (한국어 파인튜닝 버전)

### 2. 생성할 초기 데이터

#### 추모관 (10-15개)
- **사람 추모관**: 7-10개
  - 다양한 연령대 (어린이, 청년, 중년, 노인)
  - 다양한 관계 (가족, 친구, 동료)
  - 다양한 상황 (질병, 사고, 자연사)
- **애완동물 추모관**: 3-5개
  - 강아지, 고양이, 기타 반려동물
  - 다양한 연령대와 품종

#### 편지 (각 추모관당 1-2개)
- **텍스트 편지**: 감성적이고 진정성 있는 내용
- **주제**: 추억, 감사, 사랑, 그리움, 위로

#### 댓글 (각 추모관당 3-5개)
- **위로 메시지**: 따뜻하고 공감적인 댓글
- **추억 공유**: 고인과의 추억을 나누는 댓글

#### 기도 요청 (3-5개)
- **기도 제목**: 다양한 상황의 기도 요청
- **기도 내용**: 진심 어린 기도 내용

#### 감정 공유 글 (5-8개)
- **슬픔, 그리움, 위로, 감사** 등 다양한 감정
- **공감을 불러일으키는 내용**

## 🛠️ 구현 방법

### 방법 1: Firebase Cloud Functions (권장)

#### 장점
- 서버리스, 자동 스케일링
- 보안 (API 키 관리)
- 일괄 생성 가능

#### 구현 단계

1. **Cloud Functions 설정**
```javascript
// functions/index.js
const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { OpenAI } = require('openai');

const openai = new OpenAI({
  apiKey: functions.config().openai.key,
});

// 초기 데이터 생성 함수
exports.generateInitialData = functions.https.onCall(async (data, context) => {
  // 관리자만 실행 가능
  if (!context.auth || !context.auth.token.admin) {
    throw new functions.https.HttpsError('permission-denied', '관리자만 실행 가능');
  }

  const memorials = await generateMemorials();
  const letters = await generateLetters(memorials);
  const comments = await generateComments(memorials);
  const prayers = await generatePrayers();
  const emotions = await generateEmotions();

  // 모든 생성된 데이터에 isAIGenerated: true 표시
  // (generateMemorials, generateComments 등 함수 내에서 처리)

  return {
    success: true,
    memorials: memorials.length,
    letters: letters.length,
    comments: comments.length,
    prayers: prayers.length,
    emotions: emotions.length,
  };
});
```

2. **AI 프롬프트 예시**
```javascript
async function generateMemorialLetter(memorialType, deceasedName, relationship) {
  const prompt = `당신은 ${relationship}의 입장에서 ${deceasedName}님께 보내는 추모 편지를 작성해주세요.
  
요구사항:
- 진정성 있고 감성적인 내용
- 구체적인 추억이나 에피소드 포함
- 위로와 감사의 마음 표현
- 200-300자 정도의 분량
- 한국어로 작성

${memorialType === 'human' ? '사람을 추모하는' : '애완동물을 추모하는'} 편지로 작성해주세요.`;

  const response = await openai.chat.completions.create({
    model: 'gpt-4',
    messages: [
      {
        role: 'system',
        content: '당신은 감성적이고 진정성 있는 추모 편지를 작성하는 전문가입니다.',
      },
      {
        role: 'user',
        content: prompt,
      },
    ],
    temperature: 0.8,
    max_tokens: 500,
  });

  return response.choices[0].message.content;
}
```

### 방법 2: Flutter 앱 내 생성 (개발 모드)

#### 장점
- 빠른 테스트 가능
- 개발 중 즉시 확인

#### 단점
- API 키 노출 위험
- 클라이언트 측 처리 부담

#### 구현 단계

1. **패키지 추가**
```yaml
dependencies:
  http: ^1.1.0
  # 또는
  openai_dart: ^0.3.0
```

2. **서비스 클래스 생성**
```dart
// lib/services/ai_data_generator.dart
import 'package:openai_dart/openai_dart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AIDataGenerator {
  final OpenAI _openai;
  final FirebaseFirestore _firestore;

  AIDataGenerator({
    required String apiKey,
  }) : _openai = OpenAI(apiKey: apiKey),
       _firestore = FirebaseFirestore.instance;

  Future<String> generateMemorialLetter({
    required String memorialType,
    required String deceasedName,
    required String relationship,
  }) async {
    final prompt = '''
당신은 ${relationship}의 입장에서 ${deceasedName}님께 보내는 추모 편지를 작성해주세요.

요구사항:
- 진정성 있고 감성적인 내용
- 구체적인 추억이나 에피소드 포함
- 위로와 감사의 마음 표현
- 200-300자 정도의 분량
- 한국어로 작성

${memorialType == 'human' ? '사람을 추모하는' : '애완동물을 추모하는'} 편지로 작성해주세요.
''';

    final response = await _openai.chat.create(
      model: 'gpt-4',
      messages: [
        ChatMessage(
          role: ChatMessageRole.system,
          content: '당신은 감성적이고 진정성 있는 추모 편지를 작성하는 전문가입니다.',
        ),
        ChatMessage(
          role: ChatMessageRole.user,
          content: prompt,
        ),
      ],
      temperature: 0.8,
      maxTokens: 500,
    );

    return response.choices.first.message.content ?? '';
  }

  Future<void> generateInitialData() async {
    // 추모관 생성
    final memorials = await _generateMemorials();
    
    // 각 추모관에 편지 생성
    for (final memorial in memorials) {
      final letter = await generateMemorialLetter(
        memorialType: memorial['memorialType'],
        deceasedName: memorial['deceasedName'],
        relationship: memorial['relationship'],
      );
      
      // Firestore에 저장 (AI 생성 데이터 표시)
      await _firestore.collection('memorials').add({
        ...memorial,
        'isAIGenerated': true,  // AI 생성 데이터 식별 필드
        'aiGeneratedAt': FieldValue.serverTimestamp(),  // AI 생성 일시
        'letter': {
          'type': 'text',
          'content': letter,
          'isHomePublic': false,
          'isAIGenerated': true,  // 편지도 AI 생성 표시
          'createdAt': FieldValue.serverTimestamp(),
        },
      });
    }
  }
}
```

### 방법 3: 사전 생성된 데이터 (하이브리드)

#### 장점
- 비용 절감
- 일관된 품질
- 빠른 로딩

#### 구현
1. AI로 사전에 데이터 생성
2. JSON 파일로 저장
3. 앱 출시 시 Firestore에 일괄 업로드

## 📝 생성할 데이터 상세

### 추모관 템플릿

#### 사람 추모관 예시
```json
{
  "memorialType": "human",
  "deceasedName": "김 할머니",
  "lifeSummary": "1920년생, 4남매를 키우며 평생을 가족을 위해 살아온 따뜻한 어머니",
  "relationship": "할머니",
  "anniversary": {
    "birthday": "1920-03-15",
    "memorialDay": "2023-11-20"
  },
  "photos": [],
  "isPublic": true,
  "isAIGenerated": true,
  "aiGeneratedAt": "2024-01-01T00:00:00Z"
}
```

#### 애완동물 추모관 예시
```json
{
  "memorialType": "pet",
  "deceasedName": "뽀삐",
  "lifeSummary": "2015년생 골든 리트리버, 가족의 소중한 반려동물로 8년간 함께한 친구",
  "relationship": "반려동물",
  "anniversary": {
    "birthday": "2015-05-10",
    "memorialDay": "2023-09-15"
  },
  "photos": [],
  "isPublic": true,
  "isAIGenerated": true,
  "aiGeneratedAt": "2024-01-01T00:00:00Z"
}
```

### AI 프롬프트 예시

#### 편지 생성 프롬프트
```
당신은 손녀의 입장에서 할머니께 보내는 추모 편지를 작성해주세요.

할머니 정보:
- 이름: 김 할머니
- 생년월일: 1920년 3월 15일
- 기일: 2023년 11월 20일
- 특징: 4남매를 키우며 평생을 가족을 위해 살아온 따뜻한 어머니

요구사항:
- 진정성 있고 감성적인 내용
- 구체적인 추억이나 에피소드 포함 (예: 할머니가 만들어주신 음식, 함께한 시간)
- 위로와 감사의 마음 표현
- 200-300자 정도의 분량
- 한국어로 작성
- 존댓말 사용
```

#### 댓글 생성 프롬프트
```
당신은 추모관을 방문한 지인의 입장에서 위로의 댓글을 작성해주세요.

고인 정보:
- 이름: 김 할머니
- 관계: 지인

요구사항:
- 따뜻하고 공감적인 내용
- 간단한 위로의 메시지
- 50-100자 정도의 분량
- 한국어로 작성
```

## 🔐 보안 고려사항

### API 키 관리
- **Firebase Functions**: `firebase functions:config:set openai.key="YOUR_KEY"`
- **환경 변수**: `.env` 파일 사용 (로컬 개발)
- **Firebase Remote Config**: 앱 내에서 동적 설정 (권장하지 않음)

### 비용 관리
- **사용량 제한**: 일일/월별 API 호출 제한 설정
- **캐싱**: 생성된 데이터는 재사용
- **모니터링**: Firebase Analytics로 사용량 추적

## 📊 생성 데이터 통계

### 목표 수량
- **추모관**: 10-15개
- **편지**: 10-15개
- **댓글**: 30-50개
- **기도 요청**: 3-5개
- **감정 공유 글**: 5-8개

### 예상 비용 (OpenAI GPT-4 기준)
- **편지 생성**: 15개 × $0.03 = $0.45
- **댓글 생성**: 50개 × $0.01 = $0.50
- **기도 요청**: 5개 × $0.02 = $0.10
- **감정 공유 글**: 8개 × $0.02 = $0.16
- **총 예상 비용**: 약 $1.21 (한 번만 생성)

## 🚀 실행 방법

### 1. Firebase Functions 사용 (권장)

```bash
# Firebase Functions 설정
cd functions
npm install openai

# API 키 설정
firebase functions:config:set openai.key="YOUR_OPENAI_API_KEY"

# 함수 배포
firebase deploy --only functions:generateInitialData

# 함수 실행 (Firebase Console 또는 Admin SDK)
```

### 2. Flutter 앱에서 실행 (개발 모드)

```dart
// lib/screens/admin_screen.dart (개발 모드에서만 접근)
import 'package:flutter/foundation.dart';
import '../services/ai_data_generator.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) {
      return Scaffold(
        body: Center(child: Text('접근 불가')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('초기 데이터 생성')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final generator = AIDataGenerator(
              apiKey: 'YOUR_API_KEY', // 환경 변수에서 가져오기
            );
            await generator.generateInitialData();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('초기 데이터 생성 완료')),
            );
          },
          child: Text('초기 데이터 생성'),
        ),
      ),
    );
  }
}
```

## ✅ 체크리스트

### 사전 준비
- [ ] AI API 키 발급 (OpenAI, Claude 등)
- [ ] Firebase Functions 설정
- [ ] API 키 보안 설정
- [ ] 비용 모니터링 설정

### 데이터 생성
- [ ] 추모관 템플릿 작성
- [ ] AI 프롬프트 최적화
- [ ] 생성 데이터 품질 검토
- [ ] 다양성 확인 (사람/애완동물, 연령대, 관계)
- [ ] 모든 AI 생성 데이터에 `isAIGenerated: true` 필드 추가
- [ ] AI 생성 일시 기록 (`aiGeneratedAt` 필드)

### 배포
- [ ] Firestore에 데이터 업로드
- [ ] 이미지/영상 플레이스홀더 추가
- [ ] 데이터 검증
- [ ] 사용자 테스트

## 📌 주의사항

1. **프라이버시**: 생성된 데이터는 실제 인물과 무관해야 함
2. **감성**: 추모 앱의 특성상 진정성 있는 내용이 중요
3. **다양성**: 다양한 상황과 관계를 포함해야 함
4. **품질 관리**: 생성된 데이터는 반드시 검토 후 사용
5. **비용 관리**: API 호출 비용을 모니터링하고 제한 설정
6. **AI 데이터 식별**: 모든 AI 생성 데이터에 `isAIGenerated: true` 필드를 반드시 추가
7. **제거 계획**: AI 데이터는 나중에 제거할 수 있도록 설계 (사용자 불쾌감 방지)

## 🔄 업데이트 계획

### 정기 업데이트
- **월 1회**: 새로운 추모관 2-3개 추가
- **분기 1회**: 기존 데이터 품질 검토 및 개선

### 사용자 피드백 반영
- 사용자가 보고한 부적절한 콘텐츠 제거
- 사용자 요청에 따른 새로운 카테고리 추가

## 🗑️ AI 생성 데이터 제거

### 제거 전략

AI로 생성한 초기 데이터는 사용자에게 불쾌감을 줄 수 있으므로, 실제 사용자 데이터가 충분히 많아지면 제거할 수 있습니다.

#### 제거 조건

1. **사용자 데이터 충분성**
   - 실제 사용자가 생성한 추모관이 일정 수 이상 (예: 50개 이상)
   - 실제 사용자 댓글이 일정 수 이상 (예: 200개 이상)
   - 실제 사용자 활동이 활발한 경우

2. **제거 시점 결정**
   - 사용자 데이터가 AI 데이터보다 많아질 때
   - 사용자 피드백에서 AI 데이터에 대한 불만이 많을 때
   - 앱 출시 후 3-6개월 경과 시

3. **제거 방법**
   - **점진적 제거**: 한 번에 모두 제거하지 않고 단계적으로 제거
   - **백업 후 제거**: 제거 전 데이터 백업 (필요시 복구 가능)
   - **소프트 삭제**: 완전 삭제 대신 `deletedAt` 필드 설정

#### 제거 구현

### 방법 1: Cloud Functions로 일괄 제거

```javascript
// functions/index.js
exports.removeAIGeneratedData = functions.https.onCall(async (data, context) => {
  // 관리자만 실행 가능
  if (!context.auth || !context.auth.token.admin) {
    throw new functions.https.HttpsError('permission-denied', '관리자만 실행 가능');
  }

  const batch = admin.firestore().batch();
  let count = 0;

  // AI 생성 추모관 찾기
  const memorialsSnapshot = await admin.firestore()
    .collection('memorials')
    .where('isAIGenerated', '==', true)
    .get();

  for (const doc of memorialsSnapshot.docs) {
    // 소프트 삭제 (완전 삭제 대신)
    batch.update(doc.ref, {
      deletedAt: admin.firestore.FieldValue.serverTimestamp(),
      deletedReason: 'ai_generated_data_removal',
    });
    count++;
  }

  // AI 생성 댓글 찾기
  const commentsSnapshot = await admin.firestore()
    .collection('comments')
    .where('isAIGenerated', '==', true)
    .get();

  for (const doc of commentsSnapshot.docs) {
    batch.update(doc.ref, {
      deletedAt: admin.firestore.FieldValue.serverTimestamp(),
      deletedReason: 'ai_generated_data_removal',
    });
    count++;
  }

  // AI 생성 기도 요청 찾기
  const prayersSnapshot = await admin.firestore()
    .collection('prayers')
    .where('isAIGenerated', '==', true)
    .get();

  for (const doc of prayersSnapshot.docs) {
    batch.update(doc.ref, {
      deletedAt: admin.firestore.FieldValue.serverTimestamp(),
      deletedReason: 'ai_generated_data_removal',
    });
    count++;
  }

  // AI 생성 감정 공유 글 찾기
  const emotionsSnapshot = await admin.firestore()
    .collection('emotions')
    .where('isAIGenerated', '==', true)
    .get();

  for (const doc of emotionsSnapshot.docs) {
    batch.update(doc.ref, {
      deletedAt: admin.firestore.FieldValue.serverTimestamp(),
      deletedReason: 'ai_generated_data_removal',
    });
    count++;
  }

  await batch.commit();

  return {
    success: true,
    removedCount: count,
  };
});
```

### 방법 2: 점진적 제거 (권장)

```javascript
// 점진적으로 AI 데이터 제거 (하루에 일정 수만 제거)
exports.removeAIGeneratedDataGradually = functions.pubsub
  .schedule('0 2 * * *')  // 매일 새벽 2시에 실행
  .timeZone('Asia/Seoul')
  .onRun(async (context) => {
    // 실제 사용자 데이터 수 확인
    const realMemorialsCount = await admin.firestore()
      .collection('memorials')
      .where('isAIGenerated', '==', false)
      .where('deletedAt', '==', null)
      .get()
      .then(snapshot => snapshot.size);

    // 실제 사용자 데이터가 충분하면 AI 데이터 제거 시작
    if (realMemorialsCount >= 50) {
      // 하루에 최대 5개씩 제거
      const aiMemorials = await admin.firestore()
        .collection('memorials')
        .where('isAIGenerated', '==', true)
        .where('deletedAt', '==', null)
        .limit(5)
        .get();

      const batch = admin.firestore().batch();
      aiMemorials.docs.forEach(doc => {
        batch.update(doc.ref, {
          deletedAt: admin.firestore.FieldValue.serverTimestamp(),
          deletedReason: 'ai_generated_data_removal',
        });
      });

      await batch.commit();
    }
  });
```

### 방법 3: 사용자 데이터 비율 기반 제거

```javascript
// 실제 사용자 데이터 비율이 80% 이상이면 AI 데이터 제거
exports.removeAIGeneratedDataByRatio = functions.https.onCall(async (data, context) => {
  if (!context.auth || !context.auth.token.admin) {
    throw new functions.https.HttpsError('permission-denied', '관리자만 실행 가능');
  }

  // 전체 추모관 수
  const totalMemorials = await admin.firestore()
    .collection('memorials')
    .where('deletedAt', '==', null)
    .get()
    .then(snapshot => snapshot.size);

  // 실제 사용자 추모관 수
  const realMemorials = await admin.firestore()
    .collection('memorials')
    .where('isAIGenerated', '==', false)
    .where('deletedAt', '==', null)
    .get()
    .then(snapshot => snapshot.size);

  // 실제 사용자 데이터 비율
  const realDataRatio = realMemorials / totalMemorials;

  // 실제 사용자 데이터 비율이 80% 이상이면 AI 데이터 제거
  if (realDataRatio >= 0.8) {
    const aiMemorials = await admin.firestore()
      .collection('memorials')
      .where('isAIGenerated', '==', true)
      .where('deletedAt', '==', null)
      .get();

    const batch = admin.firestore().batch();
    aiMemorials.docs.forEach(doc => {
      batch.update(doc.ref, {
        deletedAt: admin.firestore.FieldValue.serverTimestamp(),
        deletedReason: 'ai_generated_data_removal',
      });
    });

    await batch.commit();

    return {
      success: true,
      removedCount: aiMemorials.size,
      realDataRatio: realDataRatio,
    };
  } else {
    return {
      success: false,
      message: `실제 사용자 데이터 비율이 ${(realDataRatio * 100).toFixed(1)}%입니다. 80% 이상이 되어야 제거할 수 있습니다.`,
      realDataRatio: realDataRatio,
    };
  }
});
```

### 제거 전 확인사항

1. **데이터 백업**
   - 제거 전 모든 AI 생성 데이터 백업
   - 필요시 복구 가능하도록

2. **사용자 알림**
   - AI 데이터 제거 전 사용자에게 공지
   - 제거 이유 설명

3. **점진적 제거**
   - 한 번에 모두 제거하지 않고 단계적으로 제거
   - 사용자 반응 확인 후 진행

4. **통계 확인**
   - 제거 후 실제 사용자 데이터 비율 확인
   - 제거가 사용자 경험에 미치는 영향 모니터링

### 제거 후 조치

1. **데이터 정리**
   - 삭제된 데이터의 관련 데이터도 정리 (댓글, 좋아요 등)
   - Storage에 저장된 이미지/영상도 삭제

2. **통계 업데이트**
   - 전체 추모관 수, 댓글 수 등 통계 업데이트
   - 홈 화면 추천 알고리즘 재계산

3. **사용자 피드백 수집**
   - AI 데이터 제거 후 사용자 피드백 수집
   - 필요시 추가 조치

## 📊 AI 데이터 제거 체크리스트

### 제거 전
- [ ] 실제 사용자 데이터 수 확인 (추모관 50개 이상, 댓글 200개 이상)
- [ ] 실제 사용자 데이터 비율 확인 (80% 이상)
- [ ] AI 생성 데이터 백업
- [ ] 사용자 공지 작성 및 발송
- [ ] 제거 스크립트 테스트 (테스트 환경)

### 제거 중
- [ ] 점진적 제거 실행 (하루에 일정 수만 제거)
- [ ] 제거 진행 상황 모니터링
- [ ] 사용자 피드백 확인

### 제거 후
- [ ] 삭제된 데이터 관련 데이터 정리
- [ ] Storage 이미지/영상 삭제
- [ ] 통계 업데이트
- [ ] 사용자 피드백 수집 및 분석

