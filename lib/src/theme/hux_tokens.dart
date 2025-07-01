import 'package:flutter/material.dart';
import 'hux_colors.dart';

/// HuxTokens provides semantic design tokens that adapt to light and dark themes.
///
/// This follows design system best practices by separating primitive colors
/// (HuxColors) from semantic color tokens that have meaning and context.
///
/// Usage:
/// ```dart
/// Text(
///   'Hello',
///   style: TextStyle(color: HuxTokens.textPrimary(context)),
/// )
/// ```
class HuxTokens {
  HuxTokens._();

  // TEXT TOKENS
  /// Primary text color that adapts to light/dark theme
  static Color textPrimary(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? HuxColors.white : HuxColors.black;
  }

  /// Secondary text color with reduced opacity
  static Color textSecondary(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? HuxColors.white70 : HuxColors.black70;
  }

  /// Tertiary text color for less prominent content
  static Color textTertiary(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? HuxColors.white50 : HuxColors.black50;
  }

  /// Disabled text color with low opacity
  static Color textDisabled(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? HuxColors.white30 : HuxColors.black30;
  }

  /// Inverted text color (opposite of primary)
  static Color textInvert(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? HuxColors.black : HuxColors.white;
  }

  // SURFACE TOKENS
  /// Primary surface background color
  static Color surfacePrimary(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? HuxColors.black90 : HuxColors.white;
  }

  /// Secondary surface background color
  static Color surfaceSecondary(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? HuxColors.white10 : HuxColors.black10;
  }

  /// Elevated surface background color for cards and modals
  static Color surfaceElevated(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? HuxColors.black70 : HuxColors.white;
  }

  /// Surface color for hover states
  static Color surfaceHover(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? HuxColors.white20 : HuxColors.black5;
  }

  // BORDER TOKENS
  /// Primary border color for components
  static Color borderPrimary(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? HuxColors.white20 : HuxColors.black20;
  }

  /// Secondary border color for subtle divisions
  static Color borderSecondary(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? HuxColors.white20 : HuxColors.black10;
  }

  // BUTTON TOKENS
  /// Background color for secondary buttons
  static Color buttonSecondaryBackground(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? HuxColors.white20 : HuxColors.black10;
  }

  /// Text color for secondary buttons
  static Color buttonSecondaryText(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? HuxColors.white : HuxColors.black;
  }

  /// Border color for secondary buttons
  static Color buttonSecondaryBorder(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? HuxColors.white20 : HuxColors.black20;
  }

  // ICON TOKENS
  /// Primary icon color for normal importance
  static Color iconPrimary(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? HuxColors.white70 : HuxColors.black70;
  }

  /// Secondary icon color for lower importance
  static Color iconSecondary(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? HuxColors.white50 : HuxColors.black50;
  }

  // CHART TOKENS
  /// Grid line color for charts
  static Color chartGrid(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? HuxColors.white20 : HuxColors.black10;
  }

  /// Axis line color for charts
  static Color chartAxis(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? HuxColors.white30 : HuxColors.black20;
  }

  /// Axis text color for charts
  static Color chartAxisText(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark
        ? HuxColors.white
        : HuxColors.black80; // Full white in dark mode for maximum visibility
  }

  // PRIMARY TOKENS
  /// Primary brand color that adapts to theme
  static Color primary(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? HuxColors.white : HuxColors.black;
  }

  // UTILITY TOKENS
  /// Overlay color for modals and backdrops
  static Color overlay(BuildContext context) {
    return HuxColors.black.withValues(alpha: 0.5);
  }

  /// Shadow color for elevated components
  static Color shadowColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark
        ? HuxColors.black.withValues(alpha: 0.5)
        : HuxColors.black.withValues(alpha: 0.1);
  }

  /// Alert color for warnings and destructive actions
  static Color alert(BuildContext context) {
    return HuxColors
        .red; // Red color for alert/warning/destructive states - same in both light and dark mode
  }

  /// Focus color for keyboard navigation
  static Color focus(BuildContext context) {
    return primary(context);
  }
}
