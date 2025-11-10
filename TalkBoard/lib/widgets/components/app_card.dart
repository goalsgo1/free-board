import 'package:flutter/material.dart';

import 'package:free_board/widgets/components/app_palette.dart';

int _alphaFromOpacity(double opacity) {
  return (opacity.clamp(0.0, 1.0) * 255).round();
}

class AppSurfaceCard extends StatelessWidget {
  const AppSurfaceCard({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.accentColor = AppPalette.warmBrown,
    this.titleColor,
    this.iconColor,
    required this.child,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color accentColor;
  final Color? titleColor;
  final Color? iconColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Color resolvedAccent = AppPalette.accessibleAccent(accentColor);
    final Color resolvedTitleColor = titleColor ?? AppPalette.warmBrown;
    final Color gradientEnd = resolvedAccent.withAlpha(_alphaFromOpacity(0.12));
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            gradientEnd,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: resolvedAccent, width: 2),
        boxShadow: [
          BoxShadow(
            color: resolvedAccent.withAlpha(_alphaFromOpacity(0.16)),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (icon != null)
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: resolvedAccent.withAlpha(_alphaFromOpacity(0.14)),
                    shape: BoxShape.circle,
                    border: Border.all(color: resolvedAccent, width: 2),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor ?? resolvedAccent,
                    size: 22,
                  ),
                ),
              if (icon != null) const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: resolvedTitleColor,
                            fontSize: 18,
                          ),
                    ),
                    if (subtitle != null && subtitle!.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        subtitle!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              height: 1.45,
                              color: AppPalette.caption,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}

