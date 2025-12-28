import 'package:flutter/material.dart';
import 'package:free_board/utils/design_tokens.dart';
import 'package:free_board/utils/responsive.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.accentColor,
    this.fullWidth = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final Color? accentColor;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final bool enabled = onPressed != null && !isLoading;
    final Color resolvedAccent = accentColor ?? DesignTokens.warmBrown;
    final double buttonHeight = Responsive.responsiveButtonHeight(context);
    
    final TextStyle labelStyle = DesignTokens.bodyBold(context).copyWith(
      color: resolvedAccent,
      letterSpacing: 0.2,
    );

    Widget button = ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: Size(fullWidth ? double.infinity : 0, buttonHeight),
        padding: EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingXL,
          vertical: DesignTokens.spacingLG,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMD),
        ),
        backgroundColor: DesignTokens.white,
        foregroundColor: resolvedAccent,
        side: BorderSide(color: resolvedAccent, width: 2.0),
        disabledBackgroundColor: DesignTokens.warmBeige.withOpacity(0.5),
        disabledForegroundColor: DesignTokens.caption,
        shadowColor: Colors.transparent,
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
                  Icon(icon, size: 20, color: resolvedAccent),
                  SizedBox(width: DesignTokens.spacingSM),
                ],
                Flexible(
                  child: Text(
                    label,
                    style: labelStyle,
                    maxLines: 2,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
    );

    if (fullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }
}

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.leadingIcon,
    this.badgeText,
    this.color,
    this.fullWidth = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? leadingIcon;
  final String? badgeText;
  final Color? color;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final Color resolvedColor = color ?? DesignTokens.warmBrown;
    final double buttonHeight = Responsive.responsiveButtonHeight(context);
    
    final TextStyle textStyle = DesignTokens.bodyBold(context).copyWith(
      color: resolvedColor,
      letterSpacing: 0.2,
    );

    Widget button = OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: resolvedColor,
        side: BorderSide(color: resolvedColor, width: 2.0),
        backgroundColor: DesignTokens.white,
        overlayColor: resolvedColor.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMD),
        ),
        minimumSize: Size(fullWidth ? double.infinity : 0, buttonHeight),
        padding: EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingLG,
          vertical: DesignTokens.spacingMD,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null) ...[
            Icon(leadingIcon, size: 20, color: resolvedColor),
            SizedBox(width: DesignTokens.spacingSM),
          ],
          Flexible(
            child: Text(
              label,
              style: textStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (badgeText != null) ...[
            SizedBox(width: DesignTokens.spacingSM),
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: DesignTokens.spacingSM,
                  vertical: DesignTokens.spacingXS,
                ),
                decoration: BoxDecoration(
                  color: DesignTokens.warmBrown.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
                ),
                child: Text(
                  badgeText!,
                  style: DesignTokens.small(context).copyWith(
                    fontWeight: FontWeight.w600,
                    color: resolvedColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ],
      ),
    );

    if (fullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
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
    final Color resolvedColor = color ?? DesignTokens.caption;
    return Padding(
      padding: EdgeInsets.only(top: DesignTokens.spacingSM),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, color: resolvedColor, size: 18),
            SizedBox(width: DesignTokens.spacingSM),
          ],
          Expanded(
            child: Text(
              text,
              style: DesignTokens.captionText(context).copyWith(
                color: resolvedColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

