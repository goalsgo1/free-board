import 'package:flutter/material.dart';
import 'package:free_board/utils/design_tokens.dart';
import 'package:free_board/utils/responsive.dart';

int _alphaFromOpacity(double opacity) {
  return (opacity.clamp(0.0, 1.0) * 255).round();
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    required this.label,
    this.hint,
    this.enabled = true,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onChanged,
    this.validator,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
  });

  final TextEditingController? controller;
  final String label;
  final String? hint;
  final bool enabled;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String value)? onFieldSubmitted;
  final void Function(String value)? onChanged;
  final String? Function(String? value)? validator;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final int maxLines;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      maxLines: obscureText ? 1 : maxLines,
      readOnly: readOnly,
      onTap: onTap,
      style: DesignTokens.body(context),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: DesignTokens.white.withAlpha(_alphaFromOpacity(0.95)),
        contentPadding: EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingXL,
          vertical: DesignTokens.spacingLG,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMD),
          borderSide: DesignTokens.borderSideDefault,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMD),
          borderSide: BorderSide(
            color: DesignTokens.warmBrown,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMD),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMD),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMD),
          borderSide: BorderSide(
            color: DesignTokens.warmBeige.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        labelStyle: DesignTokens.body(context).copyWith(
          fontWeight: FontWeight.w500,
          color: DesignTokens.ink,
        ),
        hintStyle: DesignTokens.captionText(context),
      ),
    );
  }
}

class AppChecklist extends StatelessWidget {
  const AppChecklist({
    super.key,
    required this.items,
  });

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: DesignTokens.spacingSM),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    size: 18,
                    color: DesignTokens.accentMint,
                  ),
                  SizedBox(width: DesignTokens.spacingSM),
                  Expanded(
                    child: Text(
                      item,
                      style: DesignTokens.captionText(context).copyWith(
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

