import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/hux_tokens.dart';

/// WCAG (Web Content Accessibility Guidelines) contrast calculation utilities.
///
/// Provides functions to calculate color contrast ratios and determine appropriate
/// text colors that meet WCAG AA accessibility requirements (minimum 4.5:1 contrast ratio).
///
/// These utilities follow the official WCAG 2.1 guidelines for calculating
/// relative luminance and contrast ratios.
class HuxWCAG {
  HuxWCAG._();

  /// Determines the appropriate text color based on WCAG AA contrast requirements.
  ///
  /// Compares white and black text against the background color and returns
  /// the color with better contrast ratio (minimum 4.5:1 required for WCAG AA).
  ///
  /// Example:
  /// ```dart
  /// final textColor = HuxWCAG.getContrastingTextColor(
  ///   backgroundColor: Colors.blue,
  ///   context: context,
  /// );
  /// ```
  static Color getContrastingTextColor({
    required Color backgroundColor,
    required BuildContext context,
  }) {
    // Calculate contrast ratios for both white and black text
    final whiteContrast = calculateContrastRatio(
      backgroundColor,
      HuxTokens.textInvert(context),
    );
    final blackContrast = calculateContrastRatio(
      backgroundColor,
      HuxTokens.textPrimary(context),
    );

    // Choose the text color with better contrast ratio
    // WCAG AA requires minimum 4.5:1 contrast ratio for normal text
    return whiteContrast > blackContrast
        ? HuxTokens.textInvert(context)
        : HuxTokens.textPrimary(context);
  }

  /// Calculates the contrast ratio between two colors according to WCAG guidelines.
  ///
  /// Returns a value between 1 and 21, where higher values indicate better contrast.
  /// WCAG AA requires a minimum 4.5:1 ratio for normal text and 3:1 for large text.
  ///
  /// Example:
  /// ```dart
  /// final ratio = HuxWCAG.calculateContrastRatio(
  ///   Colors.blue,
  ///   Colors.white,
  /// );
  /// ```
  static double calculateContrastRatio(Color color1, Color color2) {
    final luminance1 = getRelativeLuminance(color1);
    final luminance2 = getRelativeLuminance(color2);

    final lighter = luminance1 > luminance2 ? luminance1 : luminance2;
    final darker = luminance1 > luminance2 ? luminance2 : luminance1;

    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Calculates the relative luminance of a color according to WCAG guidelines.
  ///
  /// Returns a value between 0 and 1, where 1 represents the lightest color (white)
  /// and 0 represents the darkest color (black).
  ///
  /// This implementation follows the WCAG 2.1 formula using ITU-R BT.709 coefficients
  /// and proper gamma correction for sRGB color space.
  ///
  /// Example:
  /// ```dart
  /// final luminance = HuxWCAG.getRelativeLuminance(Colors.blue);
  /// ```
  static double getRelativeLuminance(Color color) {
    // Convert RGB values to 0-1 range
    final r = color.r / 255.0;
    final g = color.g / 255.0;
    final b = color.b / 255.0;

    // Apply gamma correction for sRGB
    final rLinear = r <= 0.03928 ? r / 12.92 : pow((r + 0.055) / 1.055, 2.4);
    final gLinear = g <= 0.03928 ? g / 12.92 : pow((g + 0.055) / 1.055, 2.4);
    final bLinear = b <= 0.03928 ? b / 12.92 : pow((b + 0.055) / 1.055, 2.4);

    // Calculate relative luminance using ITU-R BT.709 coefficients
    return 0.2126 * rLinear + 0.7152 * gLinear + 0.0722 * bLinear;
  }

  /// Determines if two colors meet WCAG AA contrast requirements.
  ///
  /// Returns true if the contrast ratio is at least 4.5:1 (normal text) or
  /// optionally 3:1 for large text.
  ///
  /// Example:
  /// ```dart
  /// final meetsAA = HuxWCAG.meetsContrastAA(
  ///   foreground: Colors.black,
  ///   background: Colors.white,
  /// );
  /// ```
  static bool meetsContrastAA({
    required Color foreground,
    required Color background,
    bool isLargeText = false,
  }) {
    final ratio = calculateContrastRatio(foreground, background);
    final requiredRatio = isLargeText ? 3.0 : 4.5;
    return ratio >= requiredRatio;
  }
}
