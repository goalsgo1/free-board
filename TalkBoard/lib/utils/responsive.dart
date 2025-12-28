import 'package:flutter/material.dart';

/// 반응형 디자인 유틸리티
/// 다양한 화면 크기에 대응하는 레이아웃을 제공합니다.
class Responsive {
  Responsive._();

  /// 화면 너비 기준 브레이크포인트
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;
  static const double desktopBreakpoint = 1440;

  /// 현재 화면 너비 가져오기
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// 현재 화면 높이 가져오기
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// 모바일 여부 확인
  static bool isMobile(BuildContext context) {
    return screenWidth(context) < mobileBreakpoint;
  }

  /// 태블릿 여부 확인
  static bool isTablet(BuildContext context) {
    final width = screenWidth(context);
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  /// 데스크톱 여부 확인
  static bool isDesktop(BuildContext context) {
    return screenWidth(context) >= tabletBreakpoint;
  }

  /// 작은 모바일 여부 확인 (320px ~ 375px)
  static bool isSmallMobile(BuildContext context) {
    return screenWidth(context) < 375;
  }

  /// 큰 모바일 여부 확인 (375px ~ 600px)
  static bool isLargeMobile(BuildContext context) {
    final width = screenWidth(context);
    return width >= 375 && width < mobileBreakpoint;
  }

  /// 반응형 패딩 가져오기
  static EdgeInsets responsivePadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
    } else if (isTablet(context)) {
      return const EdgeInsets.symmetric(horizontal: 32, vertical: 24);
    } else {
      return const EdgeInsets.symmetric(horizontal: 48, vertical: 32);
    }
  }

  /// 반응형 수평 패딩 가져오기
  static double responsiveHorizontalPadding(BuildContext context) {
    if (isMobile(context)) {
      return 16;
    } else if (isTablet(context)) {
      return 32;
    } else {
      return 48;
    }
  }

  /// 반응형 수직 패딩 가져오기
  static double responsiveVerticalPadding(BuildContext context) {
    if (isMobile(context)) {
      return 16;
    } else if (isTablet(context)) {
      return 24;
    } else {
      return 32;
    }
  }

  /// 반응형 폰트 크기 가져오기
  static double responsiveFontSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet ?? mobile * 1.1;
    } else {
      return desktop ?? mobile * 1.2;
    }
  }

  /// 반응형 간격 가져오기
  static double responsiveSpacing(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet ?? mobile * 1.2;
    } else {
      return desktop ?? mobile * 1.5;
    }
  }

  /// 반응형 컬럼 수 가져오기
  static int responsiveColumns(BuildContext context) {
    if (isMobile(context)) {
      return 1;
    } else if (isTablet(context)) {
      return 2;
    } else {
      return 3;
    }
  }

  /// 반응형 카드 너비 가져오기
  static double responsiveCardWidth(BuildContext context, {int columns = 1}) {
    final width = screenWidth(context);
    final padding = responsiveHorizontalPadding(context) * 2;
    final spacing = (columns - 1) * 16.0;
    return (width - padding - spacing) / columns;
  }

  /// 최대 콘텐츠 너비 (데스크톱에서 중앙 정렬용)
  static double maxContentWidth(BuildContext context) {
    if (isMobile(context)) {
      return double.infinity;
    } else if (isTablet(context)) {
      return 768;
    } else {
      return 1200;
    }
  }

  /// 반응형 아이콘 크기 가져오기
  static double responsiveIconSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet ?? mobile * 1.1;
    } else {
      return desktop ?? mobile * 1.2;
    }
  }

  /// 반응형 버튼 높이 가져오기
  static double responsiveButtonHeight(BuildContext context) {
    if (isSmallMobile(context)) {
      return 44;
    } else {
      return 48;
    }
  }

  /// 반응형 이미지 높이 가져오기
  static double responsiveImageHeight(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet ?? mobile * 1.2;
    } else {
      return desktop ?? mobile * 1.4;
    }
  }
}

