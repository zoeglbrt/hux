import 'package:flutter/material.dart';
import '../../theme/hux_tokens.dart';
import '../../utils/hux_wcag.dart';
import '../buttons/hux_button.dart';

/// HuxToggle is a two-state button component that can be toggled on/off.
/// Commonly used for formatting controls (bold, italic) or feature toggles.
///
/// Features:
/// - Icon-only or icon with text
/// - Smooth animations for state changes
/// - Proper theme adaptation
/// - Multiple size and style variants
///
/// Example:
/// ```dart
/// HuxToggle(
///   value: isBold,
///   onChanged: (value) => setState(() => isBold = value),
///   icon: Icons.format_bold,
///   label: 'Bold', // Optional
///   size: HuxToggleSize.medium,
///   variant: HuxButtonVariant.primary,
/// )
/// ```
class HuxToggle extends StatelessWidget {
  /// Creates a HuxToggle widget.
  const HuxToggle({
    super.key,
    required this.value,
    this.onChanged,
    required this.icon,
    this.label,
    this.size = HuxToggleSize.medium,
    this.variant = HuxButtonVariant.primary,
    this.isDisabled = false,
    this.primaryColor,
  });

  /// The current toggle state
  final bool value;

  /// Called when the toggle state changes
  final ValueChanged<bool>? onChanged;

  /// The icon to display
  final IconData icon;

  /// Optional label text to display next to the icon
  final String? label;

  /// Size variant of the toggle
  final HuxToggleSize size;

  /// Visual variant of the toggle
  final HuxButtonVariant variant;

  /// Whether the toggle is disabled
  final bool isDisabled;

  /// Primary color used for styling (optional, defaults to theme primary)
  final Color? primaryColor;

  @override
  Widget build(BuildContext context) {
    final height = size == HuxToggleSize.small
        ? 32.0
        : size == HuxToggleSize.medium
            ? 40.0
            : 48.0;
    final width = label == null ? height : null;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: isDisabled || onChanged == null
            ? null
            : () => onChanged?.call(!value),
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.hovered)) {
              if (value) {
                return switch (variant) {
                  HuxButtonVariant.primary =>
                    HuxTokens.buttonPrimaryHover(context),
                  HuxButtonVariant.secondary =>
                    HuxTokens.surfaceHover(context).withValues(alpha: 0.2),
                  HuxButtonVariant.outline ||
                  HuxButtonVariant.ghost =>
                    HuxTokens.surfaceHover(context),
                };
              }
              return HuxTokens.surfaceHover(context);
            }
            return null;
          },
        ),
        child: SizedBox(
          height: height,
          width: width,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(
              horizontal: _getHorizontalPadding(),
              vertical: _getVerticalPadding(),
            ),
            decoration: BoxDecoration(
              color: _getBackgroundColor(context),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _getBorderColor(context),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: _getIconSize(),
                  color: _getIconColor(context),
                ),
                if (label != null) ...[
                  SizedBox(width: 8),
                  Text(
                    label!,
                    style: TextStyle(
                      fontSize: _getFontSize(),
                      fontWeight: FontWeight.w500,
                      color: _getTextColor(context),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    if (isDisabled) {
      return HuxTokens.surfaceSecondary(context).withValues(alpha: 0.5);
    }

    if (!value) {
      return switch (variant) {
        HuxButtonVariant.primary ||
        HuxButtonVariant.secondary =>
          HuxTokens.surfacePrimary(context),
        HuxButtonVariant.outline ||
        HuxButtonVariant.ghost =>
          Colors.transparent,
      };
    }

    return switch (variant) {
      HuxButtonVariant.primary =>
        primaryColor ?? Theme.of(context).colorScheme.primary,
      HuxButtonVariant.secondary =>
        HuxTokens.buttonSecondaryBackground(context),
      HuxButtonVariant.outline ||
      HuxButtonVariant.ghost =>
        HuxTokens.surfaceSecondary(context),
    };
  }

  Color _getBorderColor(BuildContext context) {
    if (isDisabled) {
      return HuxTokens.borderSecondary(context);
    }

    if (!value) {
      return switch (variant) {
        HuxButtonVariant.primary ||
        HuxButtonVariant.secondary ||
        HuxButtonVariant.outline =>
          HuxTokens.borderPrimary(context),
        HuxButtonVariant.ghost => Colors.transparent,
      };
    }

    return switch (variant) {
      HuxButtonVariant.primary =>
        primaryColor ?? Theme.of(context).colorScheme.primary,
      HuxButtonVariant.secondary => HuxTokens.buttonSecondaryBorder(context),
      HuxButtonVariant.outline =>
        primaryColor ?? Theme.of(context).colorScheme.primary,
      HuxButtonVariant.ghost => Colors.transparent,
    };
  }

  Color _getIconColor(BuildContext context) {
    if (isDisabled) {
      return HuxTokens.iconSecondary(context);
    }

    if (!value) {
      return HuxTokens.iconPrimary(context);
    }

    final effectivePrimaryColor =
        primaryColor ?? Theme.of(context).colorScheme.primary;
    return switch (variant) {
      HuxButtonVariant.primary => HuxWCAG.getContrastingTextColor(
          backgroundColor: effectivePrimaryColor,
          context: context,
        ),
      HuxButtonVariant.secondary => HuxTokens.buttonSecondaryText(context),
      HuxButtonVariant.outline ||
      HuxButtonVariant.ghost =>
        effectivePrimaryColor,
    };
  }

  Color _getTextColor(BuildContext context) {
    if (isDisabled) {
      return HuxTokens.textDisabled(context);
    }

    if (!value) {
      return HuxTokens.textPrimary(context);
    }

    final effectivePrimaryColor =
        primaryColor ?? Theme.of(context).colorScheme.primary;
    return switch (variant) {
      HuxButtonVariant.primary => HuxWCAG.getContrastingTextColor(
          backgroundColor: effectivePrimaryColor,
          context: context,
        ),
      HuxButtonVariant.secondary => HuxTokens.buttonSecondaryText(context),
      HuxButtonVariant.outline ||
      HuxButtonVariant.ghost =>
        effectivePrimaryColor,
    };
  }

  double _getIconSize() {
    switch (size) {
      case HuxToggleSize.small:
        return 16;
      case HuxToggleSize.medium:
        return 18;
      case HuxToggleSize.large:
        return 20;
    }
  }

  double _getFontSize() {
    switch (size) {
      case HuxToggleSize.small:
        return 12;
      case HuxToggleSize.medium:
        return 14;
      case HuxToggleSize.large:
        return 16;
    }
  }

  double _getHorizontalPadding() {
    if (label == null) return 0; // Icon-only button
    switch (size) {
      case HuxToggleSize.small:
        return 12;
      case HuxToggleSize.medium:
        return 16;
      case HuxToggleSize.large:
        return 24;
    }
  }

  double _getVerticalPadding() {
    if (label == null) return 0; // Icon-only button
    switch (size) {
      case HuxToggleSize.small:
        return 6;
      case HuxToggleSize.medium:
        return 8;
      case HuxToggleSize.large:
        return 12;
    }
  }
}

/// Size variants for HuxToggle
enum HuxToggleSize {
  /// Small toggle for compact layouts
  small,

  /// Medium toggle for standard use
  medium,

  /// Large toggle for emphasis
  large,
}
