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
    return isDark ? HuxColors.black : HuxColors.white;
  }

  /// Surface color for hover states
  static Color surfaceHover(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? HuxColors.white10 : HuxColors.black5;
  }

  /// Overlay surface background color for snackbars and overlays
  static Color surfaceOverlay(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? HuxColors.black80 : HuxColors.white;
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
    return isDark ? HuxColors.white10 : HuxColors.black10;
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

  /// Hover overlay color for primary buttons
  static Color buttonPrimaryHover(BuildContext context) {
    return HuxColors.grey35;
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
  ///
  /// Supports both HuxTokens defaults and Material 3 seed colors:
  /// - If colorScheme is customized (via copyWith), uses theme.colorScheme.primary
  /// - Otherwise, uses HuxTokens defaults (black in light mode, white in dark mode)
  static Color primary(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Check if colorScheme has been customized from Hux default
    final defaultPrimary = ColorScheme.fromSeed(
      seedColor: HuxColors.primary,
      brightness: theme.brightness,
    ).primary;

    // If custom seed color is used, respect it
    if (theme.colorScheme.primary != defaultPrimary) {
      return theme.colorScheme.primary;
    }

    // Otherwise use HuxTokens default
    return isDark ? HuxColors.white : HuxColors.black;
  }

  // UTILITY TOKENS
  /// Overlay color for modals and backdrops
  static Color overlay(BuildContext context) {
    return HuxColors.black50;
  }

  /// Shadow color for elevated components
  static Color shadowColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? HuxColors.black50 : HuxColors.black10;
  }

  // DESTRUCTIVE TOKENS
  /// Primary destructive color for warnings, errors, and dangerous actions
  static Color destructive(BuildContext context) {
    return HuxColors
        .red; // Dark red color for destructive states - same in both light and dark mode
  }

  /// Surface color for destructive backgrounds
  static Color surfaceDestructive(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark
        ? HuxColors.red60 // Dark mode: dark red with 60% opacity
        : HuxColors.red10; // Light mode: light red with 10% opacity
  }

  /// Text color for destructive content
  static Color textDestructive(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark
        ? HuxColors.redLight // Dark mode: light red for contrast
        : HuxColors.red; // Light mode: dark red for better contrast
  }

  // SUCCESS TOKENS
  /// Primary success color for positive states and confirmations
  static Color success(BuildContext context) {
    return HuxColors
        .green; // Dark green color for success states - same in both light and dark mode
  }

  /// Surface color for success backgrounds
  static Color surfaceSuccess(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark
        ? HuxColors.green60 // Dark mode: dark green with 60% opacity
        : HuxColors.green10; // Light mode: light green with 10% opacity
  }

  /// Text color for success content
  static Color textSuccess(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark
        ? HuxColors.greenLight // Dark mode: light green for contrast
        : HuxColors.green; // Light mode: dark green for better contrast
  }

  /// Focus color for keyboard navigation
  static Color focus(BuildContext context) {
    return primary(context);
  }
}
