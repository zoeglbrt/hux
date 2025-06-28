import 'package:flutter/material.dart';
import '../../theme/hux_colors.dart';

/// HuxButton is a customizable button component
/// 
/// The primary button uses HuxColors.primary by default (white), but can be customized
/// using the primaryColor parameter with preset colors or any custom Color.
/// 
/// Examples:
/// ```dart
/// // Default white primary button
/// HuxButton(onPressed: () {}, child: Text('Default'))
/// 
/// // Using preset colors
/// HuxButton(primaryColor: HuxColors.getPresetColor('purple'), ...)
/// HuxButton(primaryColor: HuxColors.presetColors['blue']!, ...)
/// 
/// // Using custom colors
/// HuxButton(primaryColor: Colors.deepOrange, ...)
/// ```
class HuxButton extends StatelessWidget {
  const HuxButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.variant = HuxButtonVariant.primary,
    this.size = HuxButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.primaryColor = HuxColors.primary,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final HuxButtonVariant variant;
  final HuxButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _getButtonStyle();
    final buttonChild = _buildButtonChild();

    return SizedBox(
      height: _getHeight(),
      child: ElevatedButton(
        onPressed: isDisabled || isLoading ? null : onPressed,
        style: buttonStyle,
        child: buttonChild,
      ),
    );
  }

  ButtonStyle _getButtonStyle() {
    Color backgroundColor;
    Color foregroundColor;
    
    switch (variant) {
      case HuxButtonVariant.primary:
        backgroundColor = primaryColor;
        foregroundColor = _getContrastingTextColor(primaryColor);
        break;
      case HuxButtonVariant.secondary:
        backgroundColor = HuxColors.white20;
        foregroundColor = HuxColors.white;
        break;
      case HuxButtonVariant.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = HuxColors.white;
        break;
      case HuxButtonVariant.ghost:
        backgroundColor = Colors.transparent;
        foregroundColor = HuxColors.white;
        break;
    }

    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: variant == HuxButtonVariant.primary ? 0 : 0,
      padding: EdgeInsets.symmetric(
        horizontal: _getHorizontalPadding(),
        vertical: _getVerticalPadding(),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: variant == HuxButtonVariant.outline
            ? const BorderSide(color: HuxColors.white20)
            : variant == HuxButtonVariant.primary
                ? BorderSide(color: _getContrastingBorderColor(primaryColor))
                : variant == HuxButtonVariant.secondary
                    ? const BorderSide(color: HuxColors.white20)
                    : BorderSide.none,
      ),
    );
  }

  Widget _buildButtonChild() {
    if (isLoading) {
      return const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    if (icon != null) {
      final foregroundColor = _getButtonForegroundColor();
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconTheme(
            data: IconThemeData(
              color: foregroundColor,
              size: _getIconSize(),
            ),
            child: Icon(icon, size: _getIconSize()),
          ),
          const SizedBox(width: 8),
          child,
        ],
      );
    }

    return child;
  }

  double _getHeight() {
    switch (size) {
      case HuxButtonSize.small:
        return 32;
      case HuxButtonSize.medium:
        return 40;
      case HuxButtonSize.large:
        return 48;
    }
  }

  double _getHorizontalPadding() {
    switch (size) {
      case HuxButtonSize.small:
        return 12;
      case HuxButtonSize.medium:
        return 16;
      case HuxButtonSize.large:
        return 24;
    }
  }

  double _getVerticalPadding() {
    switch (size) {
      case HuxButtonSize.small:
        return 6;
      case HuxButtonSize.medium:
        return 8;
      case HuxButtonSize.large:
        return 12;
    }
  }

  double _getIconSize() {
    switch (size) {
      case HuxButtonSize.small:
        return 16;
      case HuxButtonSize.medium:
        return 18;
      case HuxButtonSize.large:
        return 20;
    }
  }

  /// Determines the appropriate text color based on background color brightness
  Color _getContrastingTextColor(Color backgroundColor) {
    // Calculate relative luminance to determine if color is light or dark
    final luminance = backgroundColor.computeLuminance();
    // Use white text for dark backgrounds, black text for light backgrounds
    return luminance > 0.5 ? HuxColors.black : HuxColors.white;
  }

  /// Determines the appropriate border color based on background color brightness
  Color _getContrastingBorderColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    // Use dark border for light backgrounds, light border for dark backgrounds
    return luminance > 0.5 ? HuxColors.black20 : HuxColors.white20;
  }

  /// Get the foreground color for the current button variant
  Color _getButtonForegroundColor() {
    switch (variant) {
      case HuxButtonVariant.primary:
        return _getContrastingTextColor(primaryColor);
      case HuxButtonVariant.secondary:
        return HuxColors.white;
      case HuxButtonVariant.outline:
        return HuxColors.white;
      case HuxButtonVariant.ghost:
        return HuxColors.white;
    }
  }
}

enum HuxButtonVariant { primary, secondary, outline, ghost }

enum HuxButtonSize { small, medium, large } 