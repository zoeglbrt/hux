import 'dart:math';
import 'package:flutter/material.dart';
import '../../theme/hux_tokens.dart';

/// HuxButton is a customizable button component
///
/// The primary button uses theme-aware colors by default, adapting to light/dark mode.
/// Can be customized using the primaryColor parameter with any custom Color.
///
/// Examples:
/// ```dart
/// // Default theme-aware primary button
/// HuxButton(onPressed: () {}, child: Text('Default'))
///
/// // Using custom colors
/// HuxButton(primaryColor: Colors.deepOrange, ...)
/// HuxButton(primaryColor: Color(0xFF6366F1), ...)
/// ```
class HuxButton extends StatelessWidget {
  /// Creates a HuxButton widget.
  ///
  /// The [onPressed] and [child] parameters are required.
  const HuxButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.variant = HuxButtonVariant.primary,
    this.size = HuxButtonSize.medium,
    this.width,
    this.widthValue,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.primaryColor,
  });

  /// Callback triggered when the button is pressed
  final VoidCallback? onPressed;

  /// The child widget to display inside the button
  final Widget child;

  /// Visual variant of the button
  final HuxButtonVariant variant;

  /// Size variant of the button
  final HuxButtonSize size;

  /// Whether to show a loading indicator instead of the child
  final bool isLoading;

  /// Whether the button is disabled
  final bool isDisabled;

  /// Optional icon to display before the text
  final IconData? icon;

  /// Primary color used for styling the button (optional, defaults to theme primary)
  final Color? primaryColor;

  /// Width behavior of the button (optional)
  /// - null: Hug content (default)
  /// - HuxButtonWidth.expand: Full width
  /// - HuxButtonWidth.fixed: Fixed width (requires widthValue)
  final HuxButtonWidth? width;

  /// Specific width value when using HuxButtonWidth.fixed
  final double? widthValue;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _getButtonStyle(context);
    final buttonChild = _buildButtonChild(context);

    return SizedBox(
      height: _getHeight(),
      width: _getWidth(),
      child: ElevatedButton(
        onPressed: isDisabled || isLoading ? null : onPressed,
        style: buttonStyle,
        child: buttonChild,
      ),
    );
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    Color backgroundColor;
    Color foregroundColor;
    BorderSide borderSide = BorderSide.none;

    switch (variant) {
      case HuxButtonVariant.primary:
        // Use theme-aware primary color by default, or custom color if provided
        final effectivePrimaryColor =
            primaryColor ?? HuxTokens.primary(context);
        backgroundColor = effectivePrimaryColor;
        foregroundColor =
            _getContrastingTextColor(effectivePrimaryColor, context);
        borderSide = BorderSide(
            color: _getContrastingBorderColor(effectivePrimaryColor, context));
        break;
      case HuxButtonVariant.secondary:
        backgroundColor = HuxTokens.buttonSecondaryBackground(context);
        foregroundColor = HuxTokens.buttonSecondaryText(context);
        borderSide =
            BorderSide(color: HuxTokens.buttonSecondaryBorder(context));
        break;
      case HuxButtonVariant.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = HuxTokens.buttonSecondaryText(context);
        borderSide =
            BorderSide(color: HuxTokens.buttonSecondaryBorder(context));
        break;
      case HuxButtonVariant.ghost:
        backgroundColor = Colors.transparent;
        foregroundColor = HuxTokens.buttonSecondaryText(context);
        break;
    }

    // Check if this is an icon-only button to adjust padding
    final isIconOnly = child is SizedBox && (child as SizedBox).width == 0;
    final horizontalPadding = isIconOnly ? 0.0 : _getHorizontalPadding();
    final verticalPadding = isIconOnly ? 0.0 : _getVerticalPadding();

    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(backgroundColor),
      foregroundColor: WidgetStateProperty.all(foregroundColor),
      elevation: WidgetStateProperty.all(0),
      shadowColor: WidgetStateProperty.all(Colors.transparent),
      surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
      splashFactory: NoSplash.splashFactory, // Removes the round ripple effect
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: borderSide,
        ),
      ),
      // Custom hover effect only (no press effect)
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.hovered)) {
            // Enhanced hover effect for primary buttons
            if (variant == HuxButtonVariant.primary) {
              return HuxTokens.buttonPrimaryHover(
                  context); // Use HuxTokens for primary button hover
            }
            // Use consistent hover color for other variants
            return HuxTokens.surfaceHover(context);
          }
          return null; // No press effect
        },
      ),
    );
  }

  Widget _buildButtonChild(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    if (icon != null) {
      final foregroundColor = _getForegroundColor(context);

      // Check if this should be an icon-only button (when child has zero width)
      if (child is SizedBox && (child as SizedBox).width == 0) {
        return IconTheme(
          data: IconThemeData(
            color: foregroundColor,
            size: _getIconSize(),
          ),
          child: Icon(icon, size: _getIconSize()),
        );
      }

      // Regular icon + text button
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

  Color _getForegroundColor(BuildContext context) {
    switch (variant) {
      case HuxButtonVariant.primary:
        final effectivePrimaryColor =
            primaryColor ?? HuxTokens.primary(context);
        return _getContrastingTextColor(effectivePrimaryColor, context);
      case HuxButtonVariant.secondary:
      case HuxButtonVariant.outline:
      case HuxButtonVariant.ghost:
        return HuxTokens.buttonSecondaryText(context);
    }
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

  double? _getWidth() {
    // For icon-only buttons, ensure they are square by matching height
    if (icon != null && child is SizedBox && (child as SizedBox).width == 0) {
      return _getHeight(); // Make icon-only buttons square
    }
    
    if (width == null) return null; // Hug content (default)

    switch (width!) {
      case HuxButtonWidth.hug:
        return null; // Hug content
      case HuxButtonWidth.expand:
        return double.infinity; // Full width
      case HuxButtonWidth.fixed:
        return widthValue; // Specific width
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

  /// Determines the appropriate text color based on WCAG AA contrast requirements
  Color _getContrastingTextColor(Color backgroundColor, BuildContext context) {
    // Calculate contrast ratios for both white and black text
    final whiteContrast =
        _calculateContrastRatio(backgroundColor, HuxTokens.textInvert(context));
    final blackContrast = _calculateContrastRatio(
        backgroundColor, HuxTokens.textPrimary(context));

    // Choose the text color with better contrast ratio
    // WCAG AA requires minimum 4.5:1 contrast ratio for normal text
    return whiteContrast > blackContrast
        ? HuxTokens.textInvert(context)
        : HuxTokens.textPrimary(context);
  }

  /// Calculates the contrast ratio between two colors according to WCAG guidelines
  /// Returns a value between 1 and 21, where higher values indicate better contrast
  double _calculateContrastRatio(Color color1, Color color2) {
    final luminance1 = _getRelativeLuminance(color1);
    final luminance2 = _getRelativeLuminance(color2);

    final lighter = luminance1 > luminance2 ? luminance1 : luminance2;
    final darker = luminance1 > luminance2 ? luminance2 : luminance1;

    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Calculates the relative luminance of a color according to WCAG guidelines
  /// Returns a value between 0 and 1
  double _getRelativeLuminance(Color color) {
    // Convert RGB values to 0-1 range
    final r = color.r / 255.0;
    final g = color.g / 255.0;
    final b = color.b / 255.0;

    // Apply gamma correction
    final rLinear = r <= 0.03928 ? r / 12.92 : pow((r + 0.055) / 1.055, 2.4);
    final gLinear = g <= 0.03928 ? g / 12.92 : pow((g + 0.055) / 1.055, 2.4);
    final bLinear = b <= 0.03928 ? b / 12.92 : pow((b + 0.055) / 1.055, 2.4);

    // Calculate relative luminance using ITU-R BT.709 coefficients
    return 0.2126 * rLinear + 0.7152 * gLinear + 0.0722 * bLinear;
  }

  /// Determines the appropriate border color based on background color brightness
  Color _getContrastingBorderColor(
      Color backgroundColor, BuildContext context) {
    // Use consistent theme-aware border color for primary buttons
    return HuxTokens.borderSecondary(context);
  }
}

/// Visual variants for HuxButton
enum HuxButtonVariant {
  /// Solid button with primary color background
  primary,

  /// Solid button with secondary styling
  secondary,

  /// Button with transparent background and border
  outline,

  /// Button with transparent background and no border
  ghost
}

/// Size variants for HuxButton
enum HuxButtonSize {
  /// Small button with compact padding
  small,

  /// Medium button with standard padding
  medium,

  /// Large button with generous padding
  large
}

/// Width behavior variants for HuxButton
enum HuxButtonWidth {
  /// Button width adapts to content
  hug,

  /// Button expands to fill available width
  expand,

  /// Button uses specific width (set via widthValue parameter)
  fixed,
}
