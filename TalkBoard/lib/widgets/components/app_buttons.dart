import 'package:flutter/material.dart';

import 'package:free_board/widgets/components/app_palette.dart';

int _alphaFromOpacity(double opacity) {
  return (opacity.clamp(0.0, 1.0) * 255).round();
}

Color _resolveAccent(Color color) => AppPalette.accessibleAccent(color);
Color _foregroundOn(Color background) => AppPalette.foregroundOn(background);

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.accentColor = AppPalette.warmBrown,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final bool enabled = onPressed != null && !isLoading;
    final Color resolvedAccent = _resolveAccent(accentColor);
    final Color resolvedForeground = _foregroundOn(resolvedAccent);
    final TextStyle? labelStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: resolvedForeground,
          letterSpacing: 0.2,
        );
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          elevation: 4,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: resolvedAccent,
          foregroundColor: resolvedForeground,
          disabledBackgroundColor:
              resolvedAccent.withAlpha(_alphaFromOpacity(0.4)),
          disabledForegroundColor: resolvedForeground.withAlpha(200),
          shadowColor: resolvedAccent.withAlpha(_alphaFromOpacity(0.35)),
        ),
        child: isLoading
            ? SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(resolvedForeground),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 18, color: resolvedForeground),
                    const SizedBox(width: 8),
                  ],
                  Text(label, style: labelStyle),
                ],
              ),
      ),
    );
  }
}

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.leadingIcon,
    this.badgeText,
    this.color = AppPalette.warmBrown,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? leadingIcon;
  final String? badgeText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final Color resolvedColor = _resolveAccent(color);
    final bool isLight = resolvedColor.computeLuminance() > 0.62;
    final Color textColor =
        isLight ? AppPalette.warmBrown : resolvedColor;
    final TextStyle? textStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: textColor,
          letterSpacing: 0.2,
        );

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: textColor,
        side: BorderSide(color: textColor.withAlpha(_alphaFromOpacity(0.6))),
        backgroundColor: Colors.white,
        overlayColor: textColor.withOpacity(0.12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null) ...[
            Icon(leadingIcon, size: 20, color: textColor),
            const SizedBox(width: 10),
          ],
          Flexible(
            child: Text(
              label,
              style: textStyle,
            ),
          ),
          if (badgeText != null) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppPalette.softLavender,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                badgeText!,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF5E35B1),
                    ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class AppHelperText extends StatelessWidget {
  const AppHelperText({
    super.key,
    required this.text,
    this.icon,
    this.color,
  });

  final String text;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final Color resolvedColor = color ?? AppPalette.ink;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, color: resolvedColor, size: 18),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                    color: resolvedColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

