import 'package:flutter/material.dart';
import '../../theme/hux_colors.dart';

/// HuxTextField is a customizable text input component
class HuxTextField extends StatelessWidget {
  const HuxTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.size = HuxTextFieldSize.medium,
    this.iconSize,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final int maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;
  final HuxTextFieldSize size;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: isDark ? HuxColors.white60 : HuxColors.black80,
            ),
          ),
          const SizedBox(height: 6),
        ],
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          enabled: enabled,
          maxLines: maxLines,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          validator: validator,
          style: TextStyle(
            fontSize: _getFontSize(),
            height: 1.4,
          ),
                      decoration: InputDecoration(
              hintText: hint,
              prefixIcon: prefixIcon != null ? _buildIcon(prefixIcon!, isPrefix: true) : null,
              suffixIcon: suffixIcon != null ? _buildIcon(suffixIcon!, isPrefix: false) : null,
              prefixIconConstraints: prefixIcon != null ? BoxConstraints(
                minWidth: _getIconConstraintWidth(),
                maxWidth: _getIconConstraintWidth(),
              ) : null,
              suffixIconConstraints: suffixIcon != null ? BoxConstraints(
                minWidth: _getIconConstraintWidth(),
                maxWidth: _getIconConstraintWidth(),
              ) : null,
              errorText: errorText,
              helperText: helperText,
              contentPadding: EdgeInsets.symmetric(
                horizontal: _getHorizontalPadding(),
                vertical: _getVerticalPadding(),
              ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isDark ? HuxColors.white20 : HuxColors.black60,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isDark ? HuxColors.white20 : HuxColors.black60,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: HuxColors.white40,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: HuxColors.error,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: HuxColors.error,
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isDark ? HuxColors.white50 : HuxColors.black20,
              ),
            ),
            filled: true,
            fillColor: enabled
                ? (isDark ? HuxColors.black90 : HuxColors.white)
                : (isDark ? HuxColors.black70 : HuxColors.white5),
          ),
        ),
      ],
    );
  }

  Widget _buildIcon(Widget icon, {required bool isPrefix}) {
    final effectiveIconSize = iconSize ?? _getDefaultIconSize();
    final outerPadding = _getIconHorizontalPadding();
    final innerPadding = 4.0; // Small gap between icon and text
    
    return Padding(
      padding: EdgeInsets.only(
        left: isPrefix ? outerPadding : innerPadding,
        right: isPrefix ? innerPadding : outerPadding,
      ),
      child: SizedBox(
        width: effectiveIconSize,
        height: effectiveIconSize,
        child: Center(
          child: IconTheme(
            data: IconThemeData(
              size: effectiveIconSize,
              color: HuxColors.white,
            ),
            child: icon,
          ),
        ),
      ),
    );
  }

  double _getIconConstraintWidth() {
    final effectiveIconSize = iconSize ?? _getDefaultIconSize();
    final outerPadding = _getIconHorizontalPadding();
    final innerPadding = 5.0;
    return effectiveIconSize + outerPadding + innerPadding;
  }

  double _getIconHorizontalPadding() {
    switch (size) {
      case HuxTextFieldSize.small:
        return 12;
      case HuxTextFieldSize.medium:
        return 14;
      case HuxTextFieldSize.large:
        return 12;
    }
  }

  double _getDefaultIconSize() {
    switch (size) {
      case HuxTextFieldSize.small:
        return 16;
      case HuxTextFieldSize.medium:
        return 18;
      case HuxTextFieldSize.large:
        return 20;
    }
  }

  double _getFontSize() {
    switch (size) {
      case HuxTextFieldSize.small:
        return 14;
      case HuxTextFieldSize.medium:
        return 16;
      case HuxTextFieldSize.large:
        return 18;
    }
  }

  double _getHorizontalPadding() {
    switch (size) {
      case HuxTextFieldSize.small:
        return 16;
      case HuxTextFieldSize.medium:
        return 18;
      case HuxTextFieldSize.large:
        return 20;
    }
  }

  double _getVerticalPadding() {
    switch (size) {
      case HuxTextFieldSize.small:
        return 8;
      case HuxTextFieldSize.medium:
        return 12;
      case HuxTextFieldSize.large:
        return 16;
    }
  }
}

enum HuxTextFieldSize { small, medium, large } 