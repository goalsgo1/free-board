# keytool 입력 가이드

## 📋 keytool 명령어 입력 필드 안내

서명 키 생성 시 다음 정보를 입력해야 합니다:

### 필수 입력 항목

1. **이름과 성 (First and Last Name)**
   ```
   haemin lee
   ```
   - 개발자의 실제 이름 입력
   - 인증서의 CN(Common Name) 필드가 됩니다
   - Google Play Store에 직접 영향은 없지만 인증서 정보에 포함됩니다

2. **조직 단위 (Organizational Unit)**
   ```
   Android Development
   ```
   또는
   ```
   Development
   ```
   - 선택사항이지만 입력 권장
   - 조직 내 부서나 팀 이름

3. **조직 이름 (Organization)**
   ```
   TalkBoard
   ```
   또는
   ```
   개인
   ```
   - 회사 이름 또는 "개인", "Personal" 등
   - 앱 이름 또는 개발자 이름도 가능

4. **구/군/시 (City or Locality)**
   ```
   Seoul
   ```
   또는
   ```
   서울
   ```
   - 거주 도시 입력

5. **시/도 (State or Province)**
   ```
   Seoul
   ```
   또는
   ```
   서울특별시
   ```
   - 거주 지역의 시/도

6. **두 자리 국가 코드 (Two-letter country code)**
   ```
   KR
   ```
   - 대한민국: KR
   - 미국: US
   - 일본: JP
   - ISO 3166-1 alpha-2 코드 사용

### 입력 예시

```
이름과 성을 입력하십시오.
  [Unknown]: haemin lee

조직 단위 이름을 입력하십시오.
  [Unknown]: Development

조직 이름을 입력하십시오.
  [Unknown]: TalkBoard

구/군/시 이름을 입력하십시오?
  [Unknown]: Seoul

시/도 이름을 입력하십시오?
  [Unknown]: Seoul

이 조직의 두 자리 국가 코드를 입력하십시오.
  [Unknown]: KR
```

## ⚠️ 중요 사항

1. **이름 필드**
   - 실제 이름 사용 가능
   - 개발자 닉네임 사용도 가능
   - Google Play Store에는 표시되지 않지만 인증서 정보에 포함됩니다

2. **빈 필드 입력**
   - Enter 키를 누르면 기본값 `[Unknown]`이 사용됩니다
   - 모든 필드를 입력하는 것을 권장하지만 필수는 아닙니다

3. **비밀번호**
   - 키스토어 비밀번호: 서명 키 파일 보호용
   - 키 비밀번호: 개별 키 보호용
   - 동일하게 설정하거나 다르게 설정 가능

## 💡 권장 입력 값

```
이름과 성: haemin lee
조직 단위: Development
조직 이름: TalkBoard (또는 개인)
구/군/시: Seoul
시/도: Seoul
국가 코드: KR
```

## 📝 참고

- 이 정보는 키스토어의 인증서 정보에 저장됩니다
- 나중에 `keytool -list -v -keystore key.jks` 명령으로 확인 가능합니다
- Google Play Store 등록에는 직접적인 영향을 주지 않습니다
- 하지만 정확한 정보를 입력하는 것이 좋습니다

