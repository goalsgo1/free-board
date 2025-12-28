import 'package:flutter/material.dart';
import 'package:free_board/utils/design_tokens.dart';

/// Global color palette shared across the app.
/// 디자인 토큰을 사용하도록 업데이트되었습니다.
@Deprecated('DesignTokens를 사용하세요. 이 클래스는 하위 호환성을 위해 유지됩니다.')
class AppPalette {
  AppPalette._();

  static const Color warmBrown = DesignTokens.warmBrown;
  static const Color softCream = DesignTokens.softCream;
  static const Color warmBeige = DesignTokens.warmBeige;
  static const Color gentlePink = DesignTokens.gentlePink;
  static const Color softLavender = DesignTokens.softLavender;
  static const Color softMint = DesignTokens.softMint;
  static const Color deepBlue = DesignTokens.deepBlue;
  static const Color ink = DesignTokens.ink;
  static const Color caption = DesignTokens.caption;
  static const Color accentPink = DesignTokens.accentPink;
  static const Color accentLavender = DesignTokens.accentLavender;
  static const Color accentMint = DesignTokens.accentMint;
  static const Color accentGold = DesignTokens.accentGold;

  /// Ensures accent colors maintain sufficient contrast by nudging
  /// very bright tones darker and very dark tones lighter.
  static Color accessibleAccent(Color color) {
    final double luminance = color.computeLuminance();
    if (luminance > 0.8) {
      return Color.lerp(color, DesignTokens.warmBrown, 0.45)!;
    }
    if (luminance > 0.65) {
      return Color.lerp(color, DesignTokens.warmBrown, 0.3)!;
    }
    if (luminance < 0.18) {
      return Color.lerp(color, Colors.white, 0.55)!;
    }
    return color;
  }

  /// Returns an appropriate foreground color against the given background.
  static Color foregroundOn(Color background) {
    return background.computeLuminance() > 0.5 ? DesignTokens.warmBrown : Colors.white;
  }
}

