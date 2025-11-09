import 'package:flutter/material.dart';

class AccessibilityProvider extends ChangeNotifier {
  static const List<double> availableScales = [1.0, 1.2, 1.4];

  double _textScale = availableScales.first;
  bool _boldText = false;

  double get textScale => _textScale;
  bool get boldText => _boldText;

  void setTextScale(double scale) {
    if (_textScale == scale) return;
    _textScale = scale;
    notifyListeners();
  }

  void setBoldText(bool value) {
    if (_boldText == value) return;
    _boldText = value;
    notifyListeners();
  }

  TextTheme modifyTextTheme(TextTheme base) {
    if (!_boldText) {
      return base;
    }

    TextStyle? applyWeight(TextStyle? style) {
      if (style == null) return null;
      return style.copyWith(fontWeight: FontWeight.w600);
    }

    return base.copyWith(
      displayLarge: applyWeight(base.displayLarge),
      displayMedium: applyWeight(base.displayMedium),
      displaySmall: applyWeight(base.displaySmall),
      headlineLarge: applyWeight(base.headlineLarge),
      headlineMedium: applyWeight(base.headlineMedium),
      headlineSmall: applyWeight(base.headlineSmall),
      titleLarge: applyWeight(base.titleLarge),
      titleMedium: applyWeight(base.titleMedium),
      titleSmall: applyWeight(base.titleSmall),
      bodyLarge: applyWeight(base.bodyLarge),
      bodyMedium: applyWeight(base.bodyMedium),
      bodySmall: applyWeight(base.bodySmall),
      labelLarge: applyWeight(base.labelLarge),
      labelMedium: applyWeight(base.labelMedium),
      labelSmall: applyWeight(base.labelSmall),
    );
  }
}

