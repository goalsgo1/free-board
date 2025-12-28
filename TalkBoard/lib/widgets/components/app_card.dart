import 'package:flutter/material.dart';
import 'package:free_board/utils/design_tokens.dart';
import 'package:free_board/utils/responsive.dart';

class AppSurfaceCard extends StatelessWidget {
  const AppSurfaceCard({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.accentColor,
    this.titleColor,
    this.iconColor,
    required this.child,
    this.padding,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color? accentColor;
  final Color? titleColor;
  final Color? iconColor;
  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final Color resolvedAccentColor = accentColor ?? DesignTokens.warmBrown;
    final Color resolvedTitleColor = titleColor ?? DesignTokens.ink;
    final Color subtitleColor = DesignTokens.caption;
    final EdgeInsets resolvedPadding = padding ?? EdgeInsets.all(
      Responsive.responsiveSpacing(
        context,
        mobile: DesignTokens.spacingXL,
        tablet: DesignTokens.spacing2XL,
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: DesignTokens.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusLG),
        border: DesignTokens.borderDefault,
        boxShadow: DesignTokens.shadowMedium,
      ),
      padding: resolvedPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (icon != null)
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: resolvedAccentColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: resolvedAccentColor.withOpacity(0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor ?? resolvedAccentColor,
                    size: 24,
                  ),
                ),
              if (icon != null) SizedBox(width: DesignTokens.spacingMD),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: DesignTokens.heading3(context).copyWith(
                        color: resolvedTitleColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null && subtitle!.isNotEmpty) ...[
                      SizedBox(height: DesignTokens.spacingXS),
                      Text(
                        subtitle!,
                        style: DesignTokens.captionText(context).copyWith(
                          height: 1.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: DesignTokens.spacingXL),
          child,
        ],
      ),
    );
  }
}

