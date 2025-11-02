# 앱 아이콘 준비 가이드

## 📋 안내

이 폴더에 앱 아이콘 이미지를 추가하세요.

## 🖼️ 필요한 이미지

1. **원본 이미지**: `app_icon.png` (1024x1024px)
   - PNG 형식
   - 투명 배경 가능
   - 최소 1024x1024px 이상 권장

## 🚀 사용 방법

1. `app_icon.png` 파일을 이 폴더에 추가하세요
   - 크기: 1024x1024px (권장)
   - 형식: PNG

2. 아이콘 생성 명령 실행:
```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

3. 생성된 아이콘 확인:
   - Android: `android/app/src/main/res/mipmap-*/ic_launcher.png`
   - iOS: `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

## 💡 온라인 도구 추천

아이콘 이미지가 없으시다면 다음 도구를 사용하세요:

- [AppIcon.co](https://www.appicon.co/)
- [Icon Kitchen](https://icon.kitchen/)
- [MakeAppIcon](https://makeappicon.com/)

## 📝 참고

- 아이콘 이미지를 추가한 후 `flutter pub run flutter_launcher_icons` 명령을 실행하면 모든 플랫폼 아이콘이 자동으로 생성됩니다.
- 생성된 아이콘은 Git에 커밋하셔도 됩니다.

