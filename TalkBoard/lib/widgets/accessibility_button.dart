import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:free_board/providers/accessibility_provider.dart';
import 'package:free_board/widgets/components/app_palette.dart';

class AccessibilityButton extends StatelessWidget {
  const AccessibilityButton({super.key});

  Future<void> _openSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return const _AccessibilitySheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: '접근성 설정',
      onPressed: () => _openSheet(context),
      icon: const _AccessibilityIcon(),
    );
  }
}

class _AccessibilityIcon extends StatelessWidget {
  const _AccessibilityIcon();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarColor =
        theme.appBarTheme.backgroundColor ?? theme.colorScheme.primary;
    final brightness = ThemeData.estimateBrightnessForColor(appBarColor);
    final bool useLightForeground = brightness == Brightness.dark;
    final Color textColor =
        useLightForeground ? Colors.white : AppPalette.warmBrown;
    final Color borderColor =
        useLightForeground ? Colors.white70 : AppPalette.warmBrown.withAlpha((0.4 * 255).round());

    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Text(
        '가',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: textColor,
          fontSize: 16,
        ),
      ),
    );
  }
}

class _AccessibilitySheet extends StatelessWidget {
  const _AccessibilitySheet();

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: viewInsets.bottom + 20,
        top: 12,
      ),
      child: Consumer<AccessibilityProvider>(
        builder: (context, provider, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '접근성 설정',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppPalette.warmBrown,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                '글자 크기',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppPalette.ink,
                ),
              ),
              const SizedBox(height: 8),
              ...AccessibilityProvider.availableScales.map(
                (scale) => RadioListTile<double>(
                  value: scale,
                  groupValue: provider.textScale,
                  onChanged: (value) {
                    if (value != null) {
                      provider.setTextScale(value);
                    }
                  },
                  title: Text(
                    '${(scale * 100).toInt()}%',
                    style: const TextStyle(fontSize: 14),
                  ),
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                ),
              ),
              const SizedBox(height: 12),
              SwitchListTile.adaptive(
                value: provider.boldText,
                onChanged: provider.setBoldText,
                title: const Text(
                  '굵은 글씨 사용',
                  style: TextStyle(fontSize: 14),
                ),
                subtitle: const Text(
                  '텍스트를 더 선명하게 표시합니다.',
                  style: TextStyle(fontSize: 12),
                ),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppPalette.softCream,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppPalette.warmBeige, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '미리보기',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppPalette.warmBrown,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '가나다라마바사 ABCDE 12345',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '글자를 또렷하게 보고 싶다면 크기와 굵기를 조정해보세요.',
                      style: TextStyle(fontSize: 13, color: AppPalette.caption),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppPalette.warmBrown,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('닫기'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

