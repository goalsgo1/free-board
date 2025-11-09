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
    final scaled = base.apply(fontSizeFactor: _textScale);
    if (!_boldText) {
      return scaled;
    }

    TextStyle? applyWeight(TextStyle? style) {
      if (style == null) return null;
      return style.copyWith(fontWeight: FontWeight.w600);
    }

    return scaled.copyWith(
      displayLarge: applyWeight(scaled.displayLarge),
      displayMedium: applyWeight(scaled.displayMedium),
      displaySmall: applyWeight(scaled.displaySmall),
      headlineLarge: applyWeight(scaled.headlineLarge),
      headlineMedium: applyWeight(scaled.headlineMedium),
      headlineSmall: applyWeight(scaled.headlineSmall),
      titleLarge: applyWeight(scaled.titleLarge),
      titleMedium: applyWeight(scaled.titleMedium),
      titleSmall: applyWeight(scaled.titleSmall),
      bodyLarge: applyWeight(scaled.bodyLarge),
      bodyMedium: applyWeight(scaled.bodyMedium),
      bodySmall: applyWeight(scaled.bodySmall),
      labelLarge: applyWeight(scaled.labelLarge),
      labelMedium: applyWeight(scaled.labelMedium),
      labelSmall: applyWeight(scaled.labelSmall),
    );
  }
}

