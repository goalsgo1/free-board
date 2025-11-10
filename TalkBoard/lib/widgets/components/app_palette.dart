import 'package:flutter/material.dart';

/// Global color palette shared across the app.
class AppPalette {
  static const Color warmBrown = Color(0xFF8B7355);
  static const Color softCream = Color(0xFFFFF8F0);
  static const Color warmBeige = Color(0xFFF5F1E8);
  static const Color gentlePink = Color(0xFFFFE5E5);
  static const Color softLavender = Color(0xFFEDE7F6);
  static const Color softMint = Color(0xFFE8F5E9);
  static const Color deepBlue = Color(0xFF1E3A5F);
  static const Color ink = Color(0xFF4C4C4C);
  static const Color caption = Color(0xFF6D6D6D);
  static const Color accentPink = Color(0xFFD64B71);
  static const Color accentLavender = Color(0xFF5C6BC0);
  static const Color accentMint = Color(0xFF3B7A57);
  static const Color accentGold = Color(0xFFB77A1E);

  /// Ensures accent colors maintain sufficient contrast by nudging
  /// very bright tones darker and very dark tones lighter.
  static Color accessibleAccent(Color color) {
    final double luminance = color.computeLuminance();
    if (luminance > 0.8) {
      return Color.lerp(color, AppPalette.warmBrown, 0.45)!;
    }
    if (luminance > 0.65) {
      return Color.lerp(color, AppPalette.warmBrown, 0.3)!;
    }
    if (luminance < 0.18) {
      return Color.lerp(color, Colors.white, 0.55)!;
    }
    return color;
  }

  /// Returns an appropriate foreground color against the given background.
  static Color foregroundOn(Color background) {
    return background.computeLuminance() > 0.5 ? AppPalette.warmBrown : Colors.white;
  }
}

