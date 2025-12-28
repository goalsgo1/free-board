import 'package:flutter/material.dart';

/// 통일된 디자인 토큰 시스템
/// 앱 전반에 걸쳐 일관된 디자인을 제공합니다.
class DesignTokens {
  DesignTokens._();

  // ==================== 색상 시스템 ====================
  
  /// 따뜻한 브라운 (주요 색상)
  static const Color warmBrown = Color(0xFF8B7355);
  
  /// 부드러운 크림 (배경)
  static const Color softCream = Color(0xFFFFF8F0);
  
  /// 따뜻한 베이지 (배경, 테두리)
  static const Color warmBeige = Color(0xFFF5F1E8);
  
  /// 부드러운 핑크 (강조)
  static const Color gentlePink = Color(0xFFFFE5E5);
  
  /// 부드러운 라벤더 (강조)
  static const Color softLavender = Color(0xFFEDE7F6);
  
  /// 부드러운 민트 (강조)
  static const Color softMint = Color(0xFFE8F5E9);
  
  /// 깊은 블루 (텍스트, 강조)
  static const Color deepBlue = Color(0xFF1E3A5F);
  
  /// 잉크 (주요 텍스트)
  static const Color ink = Color(0xFF4C4C4C);
  
  /// 캡션 (보조 텍스트)
  static const Color caption = Color(0xFF6D6D6D);
  
  /// 액센트 핑크
  static const Color accentPink = Color(0xFFD64B71);
  
  /// 액센트 라벤더
  static const Color accentLavender = Color(0xFF5C6BC0);
  
  /// 액센트 민트
  static const Color accentMint = Color(0xFF3B7A57);
  
  /// 액센트 골드
  static const Color accentGold = Color(0xFFB77A1E);
  
  /// 흰색
  static const Color white = Colors.white;
  
  /// 검정색
  static const Color black = Colors.black;

  // ==================== 간격 시스템 ====================
  
  /// xs: 4
  static const double spacingXS = 4.0;
  
  /// sm: 8
  static const double spacingSM = 8.0;
  
  /// md: 12
  static const double spacingMD = 12.0;
  
  /// lg: 16
  static const double spacingLG = 16.0;
  
  /// xl: 20
  static const double spacingXL = 20.0;
  
  /// 2xl: 24
  static const double spacing2XL = 24.0;
  
  /// 3xl: 32
  static const double spacing3XL = 32.0;
  
  /// 4xl: 40
  static const double spacing4XL = 40.0;
  
  /// 5xl: 48
  static const double spacing5XL = 48.0;

  // ==================== 둥근 모서리 ====================
  
  /// sm: 8
  static const double radiusSM = 8.0;
  
  /// md: 12
  static const double radiusMD = 12.0;
  
  /// lg: 16
  static const double radiusLG = 16.0;
  
  /// xl: 20
  static const double radiusXL = 20.0;
  
  /// 2xl: 24
  static const double radius2XL = 24.0;
  
  /// full: 999 (완전히 둥근 모서리)
  static const double radiusFull = 999.0;

  // ==================== 그림자 ====================
  
  /// 부드러운 그림자 (카드용)
  static List<BoxShadow> get shadowSoft => [
        BoxShadow(
          color: black.withOpacity(0.04),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];
  
  /// 중간 그림자 (카드 호버/강조용)
  static List<BoxShadow> get shadowMedium => [
        BoxShadow(
          color: black.withOpacity(0.06),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];
  
  /// 강한 그림자 (모달, 플로팅 요소용)
  static List<BoxShadow> get shadowStrong => [
        BoxShadow(
          color: black.withOpacity(0.1),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ];
  
  /// 부드러운 그림자 (상단)
  static List<BoxShadow> get shadowTop => [
        BoxShadow(
          color: black.withOpacity(0.04),
          blurRadius: 8,
          offset: const Offset(0, -2),
        ),
      ];

  // ==================== 타이포그래피 ====================
  
  /// 제목 1 (32px, bold)
  static TextStyle heading1(BuildContext context) => Theme.of(context).textTheme.headlineLarge!.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: ink,
        height: 1.2,
        letterSpacing: -0.5,
      );
  
  /// 제목 2 (24px, bold)
  static TextStyle heading2(BuildContext context) => Theme.of(context).textTheme.headlineMedium!.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: ink,
        height: 1.3,
        letterSpacing: -0.3,
      );
  
  /// 제목 3 (20px, semibold)
  static TextStyle heading3(BuildContext context) => Theme.of(context).textTheme.titleLarge!.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: ink,
        height: 1.4,
      );
  
  /// 본문 (16px, regular)
  static TextStyle body(BuildContext context) => Theme.of(context).textTheme.bodyLarge!.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: ink,
        height: 1.6,
      );
  
  /// 본문 강조 (16px, semibold)
  static TextStyle bodyBold(BuildContext context) => Theme.of(context).textTheme.bodyLarge!.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: ink,
        height: 1.6,
      );
  
  /// 캡션 (14px, regular)
  static TextStyle captionText(BuildContext context) => Theme.of(context).textTheme.bodySmall!.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: DesignTokens.caption,
        height: 1.5,
      );
  
  /// 작은 텍스트 (12px, regular)
  static TextStyle small(BuildContext context) => Theme.of(context).textTheme.bodySmall!.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: DesignTokens.caption,
        height: 1.4,
      );

  // ==================== 테두리 ====================
  
  /// 기본 테두리 (Border)
  static Border get borderDefault => Border.all(
        color: warmBeige,
        width: 1.5,
      );
  
  /// 강조 테두리 (Border)
  static Border get borderAccent => Border.all(
        color: warmBrown,
        width: 2.0,
      );
  
  /// 얇은 테두리 (Border)
  static Border get borderThin => Border.all(
        color: warmBeige,
        width: 1.0,
      );
  
  /// 기본 테두리 사이드 (BorderSide)
  static BorderSide get borderSideDefault => BorderSide(
        color: warmBeige,
        width: 1.5,
      );
  
  /// 강조 테두리 사이드 (BorderSide)
  static BorderSide get borderSideAccent => BorderSide(
        color: warmBrown,
        width: 2.0,
      );
  
  /// 얇은 테두리 사이드 (BorderSide)
  static BorderSide get borderSideThin => BorderSide(
        color: warmBeige,
        width: 1.0,
      );

  // ==================== 그라데이션 ====================
  
  /// 따뜻한 그라데이션 (베이지 → 크림)
  static LinearGradient get gradientWarm => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [warmBeige, softCream],
      );
  
  /// 부드러운 핑크 그라데이션
  static LinearGradient get gradientPink => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [gentlePink.withOpacity(0.3), softCream],
      );
  
  /// 부드러운 라벤더 그라데이션
  static LinearGradient get gradientLavender => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [softLavender.withOpacity(0.3), softCream],
      );
  
  /// 부드러운 민트 그라데이션
  static LinearGradient get gradientMint => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [softMint.withOpacity(0.3), softCream],
      );

  // ==================== 애니메이션 ====================
  
  /// 기본 애니메이션 지속 시간
  static const Duration durationFast = Duration(milliseconds: 150);
  
  /// 중간 애니메이션 지속 시간
  static const Duration durationNormal = Duration(milliseconds: 300);
  
  /// 느린 애니메이션 지속 시간
  static const Duration durationSlow = Duration(milliseconds: 500);
  
  /// 기본 애니메이션 커브
  static const Curve curveDefault = Curves.easeInOut;
  
  /// 부드러운 애니메이션 커브
  static const Curve curveSmooth = Curves.easeOutCubic;
}

