#!/bin/bash

# Android 서명 키 생성 스크립트
# 이 스크립트는 Android 릴리즈 빌드용 서명 키를 생성합니다.

echo "=========================================="
echo "Android 서명 키 생성 스크립트"
echo "=========================================="
echo ""

# 작업 디렉토리 확인
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ANDROID_APP_DIR="$SCRIPT_DIR/android/app"

# 디렉토리 확인
if [ ! -d "$ANDROID_APP_DIR" ]; then
    echo "❌ 오류: android/app 디렉토리를 찾을 수 없습니다."
    exit 1
fi

# 키스토어 파일이 이미 존재하는지 확인
KEYSTORE_FILE="$ANDROID_APP_DIR/key.jks"
if [ -f "$KEYSTORE_FILE" ]; then
    echo "⚠️  경고: 이미 키스토어 파일이 존재합니다: $KEYSTORE_FILE"
    read -p "덮어쓰시겠습니까? (y/N): " overwrite
    if [ "$overwrite" != "y" ] && [ "$overwrite" != "Y" ]; then
        echo "취소되었습니다."
        exit 0
    fi
    rm -f "$KEYSTORE_FILE"
fi

# keytool 명령어 확인
if ! command -v keytool &> /dev/null; then
    echo "❌ 오류: keytool 명령어를 찾을 수 없습니다."
    echo "Java JDK가 설치되어 있는지 확인하세요."
    exit 1
fi

echo "서명 키를 생성합니다..."
echo ""
echo "⚠️  비밀번호 입력 시 주의사항:"
echo "   - 최소 20자 이상 권장"
echo "   - 대문자, 소문자, 숫자, 특수문자 포함 권장"
echo "   - 키스토어 비밀번호와 키 비밀번호는 서로 다르게 설정 가능"
echo ""

# 키스토어 생성 (비밀번호는 사용자 입력)
keytool -genkey -v \
    -keystore "$KEYSTORE_FILE" \
    -keyalg RSA \
    -keysize 2048 \
    -validity 10000 \
    -alias upload

# 키스토어 생성 결과 확인
if [ $? -eq 0 ]; then
    echo ""
    echo "✅ 키스토어가 성공적으로 생성되었습니다!"
    echo "   위치: $KEYSTORE_FILE"
    echo ""
    echo "📝 다음 단계:"
    echo "   1. key.properties 파일을 생성하세요:"
    echo "      android/key.properties"
    echo ""
    echo "   2. key.properties 파일 내용:"
    echo "      storePassword=<키스토어_비밀번호>"
    echo "      keyPassword=<키_비밀번호>"
    echo "      keyAlias=upload"
    echo "      storeFile=app/key.jks"
    echo ""
    echo "⚠️  중요:"
    echo "   - 키스토어 비밀번호와 키 비밀번호를 안전하게 보관하세요"
    echo "   - key.jks 파일을 Git에 커밋하지 마세요"
    echo "   - key.properties 파일도 Git에 커밋하지 않는 것을 권장합니다"
else
    echo ""
    echo "❌ 오류: 키스토어 생성에 실패했습니다."
    exit 1
fi

