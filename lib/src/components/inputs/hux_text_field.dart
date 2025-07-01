import 'package:flutter/material.dart';
import '../../theme/hux_tokens.dart';

/// HuxTextField is a customizable text input component with consistent styling
/// and extensive customization options.
///
/// Provides a clean, modern text input with support for labels, hints,
/// validation, icons, and different sizes. Automatically adapts to light
/// and dark themes.
///
/// Example:
/// ```dart
/// HuxTextField(
///   label: 'Email Address',
///   hint: 'Enter your email',
///   prefixIcon: Icon(Icons.email),
///   keyboardType: TextInputType.emailAddress,
///   validator: (value) {
///     if (value?.isEmpty ?? true) return 'Email is required';
///     if (!value!.contains('@')) return 'Invalid email';
///     return null;
///   },
///   onChanged: (value) => print('Email: $value'),
/// )
/// ```
class HuxTextField extends StatelessWidget {
  /// Creates a HuxTextField widget.
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

  /// Controller for the text field
  final TextEditingController? controller;

  /// Label text displayed above the text field
  final String? label;

  /// Hint text displayed inside the text field when empty
  final String? hint;

  /// Helper text displayed below the text field
  final String? helperText;

  /// Error text displayed below the text field, overrides helperText
  final String? errorText;

  /// Widget displayed at the beginning of the text field
  final Widget? prefixIcon;

  /// Widget displayed at the end of the text field
  final Widget? suffixIcon;

  /// Whether to obscure the text (for passwords)
  final bool obscureText;

  /// Whether the text field is enabled for input
  final bool enabled;

  /// Maximum number of lines for the text field
  final int maxLines;

  /// The type of keyboard to use for editing the text
  final TextInputType? keyboardType;

  /// The type of action button to use for the keyboard
  final TextInputAction? textInputAction;

  /// Called when the text field value changes
  final ValueChanged<String>? onChanged;

  /// Called when the user submits the text field
  final ValueChanged<String>? onSubmitted;

  /// Validator function for form validation
  final String? Function(String?)? validator;

  /// Size variant of the text field
  final HuxTextFieldSize size;

  /// Custom size for the prefix and suffix icons
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: HuxTokens.textSecondary(context),
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
            prefixIcon: prefixIcon != null
                ? _buildIcon(prefixIcon!, isPrefix: true, context: context)
                : null,
            suffixIcon: suffixIcon != null
                ? _buildIcon(suffixIcon!, isPrefix: false, context: context)
                : null,
            prefixIconConstraints: prefixIcon != null
                ? BoxConstraints(
                    minWidth: _getIconConstraintWidth(),
                    maxWidth: _getIconConstraintWidth(),
                  )
                : null,
            suffixIconConstraints: suffixIcon != null
                ? BoxConstraints(
                    minWidth: _getIconConstraintWidth(),
                    maxWidth: _getIconConstraintWidth(),
                  )
                : null,
            errorText: errorText,
            helperText: helperText,
            contentPadding: EdgeInsets.symmetric(
              horizontal: _getHorizontalPadding(),
              vertical: _getVerticalPadding(),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: HuxTokens.borderPrimary(context),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: HuxTokens.borderPrimary(context),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: HuxTokens.primary(context).withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: HuxTokens.alert(context),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: HuxTokens.alert(context),
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: HuxTokens.borderSecondary(context),
              ),
            ),
            filled: true,
            fillColor: enabled
                ? HuxTokens.surfacePrimary(context)
                : HuxTokens.surfaceSecondary(context),
          ),
        ),
      ],
    );
  }

  Widget _buildIcon(Widget icon,
      {required bool isPrefix, required BuildContext context}) {
    final effectiveIconSize = iconSize ?? _getDefaultIconSize();
    final outerPadding = _getIconHorizontalPadding();
    const innerPadding = 4.0; // Small gap between icon and text

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
              color: HuxTokens.iconSecondary(context),
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
    const innerPadding = 5.0;
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

/// Size variants for HuxTextField
enum HuxTextFieldSize {
  /// Small text field with compact padding
  small,

  /// Medium text field with standard padding
  medium,

  /// Large text field with generous padding
  large
}
