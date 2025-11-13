import 'package:flutter/material.dart';

class AppSurfaceCard extends StatelessWidget {
  const AppSurfaceCard({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.accentColor = Colors.black,
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
    final Color resolvedTitleColor = titleColor ?? Colors.black;
    final Color subtitleColor = Colors.black.withValues(alpha: 0.7);
    final Color borderColor = Colors.black.withValues(alpha: 0.08);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
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
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: borderColor, width: 1.2),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor ?? Colors.black87,
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
                              color: subtitleColor,
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

