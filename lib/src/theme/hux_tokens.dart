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
        ? HuxColors.red
            .withValues(alpha: 0.60) // Dark mode: dark red with transparency
        : HuxColors.redLight.withValues(
            alpha: 0.15); // Light mode: light red with low transparency
  }

  /// Border color for destructive components
  static Color borderDestructive(BuildContext context) {
    return HuxColors.redLight; // Lighter red color for borders
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
        ? HuxColors.green
            .withValues(alpha: 0.60) // Dark mode: dark green with transparency
        : HuxColors.greenLight.withValues(
            alpha: 0.15); // Light mode: light green with low transparency
  }

  /// Border color for success components
  static Color borderSuccess(BuildContext context) {
    return HuxColors.greenLight; // Lighter green color for borders
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
