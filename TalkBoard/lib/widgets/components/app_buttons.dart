import 'package:flutter/material.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.accentColor = Colors.black,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final bool enabled = onPressed != null && !isLoading;
    assert(
      accentColor == Colors.black,
      'AppPrimaryButton now uses the monochrome design language. Remove custom accent overrides.',
    );
    const Color resolvedAccent = Colors.black;
    final TextStyle? labelStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: resolvedAccent,
          letterSpacing: 0.2,
        );
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.white,
          foregroundColor: resolvedAccent,
          side: BorderSide(color: resolvedAccent, width: 1.4),
          disabledBackgroundColor: Colors.white,
          disabledForegroundColor: Colors.grey.shade500,
        ),
        child: isLoading
            ? SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  valueColor: AlwaysStoppedAnimation<Color>(resolvedAccent),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 18, color: resolvedAccent),
                    const SizedBox(width: 6),
                  ],
                  Flexible(
                    child: Text(
                      label,
                      style: labelStyle,
                      maxLines: 2,
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
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
    this.color = Colors.black,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? leadingIcon;
  final String? badgeText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    assert(
      color == Colors.black,
      'AppOutlinedButton now uses the monochrome design language. Remove custom color overrides.',
    );
    const Color resolvedColor = Colors.black;
    final TextStyle? textStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: resolvedColor,
          letterSpacing: 0.2,
        );

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: resolvedColor,
        side: BorderSide(color: resolvedColor, width: 1.4),
        backgroundColor: Colors.white,
        overlayColor: resolvedColor.withValues(alpha: 0.1),
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
            Icon(leadingIcon, size: 20, color: resolvedColor),
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                badgeText!,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: resolvedColor,
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
    final Color resolvedColor = color ?? Colors.black87;
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

