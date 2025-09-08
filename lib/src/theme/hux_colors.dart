import 'package:flutter/material.dart';

/// HuxColors defines a minimal, focused color palette for the Hux UI components
///
/// The primary color defaults to white but can be customized using preset colors
/// or any custom Color. Use HuxColors.getPresetColor('colorName') to get preset colors.
///
class HuxColors {
  HuxColors._();

  // Core colors
  /// Primary color used throughout the theme
  static const Color primary = white;

  /// Pure white color
  static const Color white = Color(0xFFFFFFFF);

  /// Pure black color
  static const Color black = Color(0xFF000000);

  /// Neutral grey color for overlays and hover states
  static const Color grey = Color(0xFF6B7280);

  /// Destructive color for warnings, errors, and dangerous actions
  static const Color red = Color(0xFF7F1D1D);

  /// Lighter red color for destructive text and borders
  static const Color redLight = Color(0xFFEF6F6F);

  // Red color variants with different opacity levels
  /// Red with 10% opacity for subtle destructive backgrounds
  static const Color red10 = Color(0x1AEF4444); // 10% redLight

  /// Red with 60% opacity for destructive backgrounds
  static const Color red60 = Color(0x997F1D1D); // 60% red

  /// Grey with 35% opacity for subtle backgrounds
  static const Color grey35 = Color(0x596B7280); // 35% grey

  /// Success color for positive states and confirmations
  static const Color green = Color(0xFF166534);

  /// Lighter green color for success text and borders
  static const Color greenLight = Color(0xFF3CBD92);

  // Green color variants with different opacity levels
  /// Green with 10% opacity for subtle success backgrounds
  static const Color green10 = Color(0x1A10B981); // 10% greenLight

  /// Green with 60% opacity for success backgrounds
  static const Color green60 = Color(0x99166534); // 60% green

  // Essential preset colors for primary customization
  /// Preset colors available for theming
  static const Map<String, Color> presetColors = {
    'default': Color(
        0xFFFFFFFF), // Placeholder - actual color determined by theme context
    'indigo': Color(0xFF665CFF),
    'green': Color(0xFF2E7252),
    'pink': Color.fromARGB(255, 223, 29, 84),
  };

  // Essential transparency levels (only the ones actually used)
  // Light theme overlays (black on white)
  /// Black with 5% opacity for very subtle light theme overlays
  static const Color black5 = Color(0x0D000000); // 5% black

  /// Black with 10% opacity for light theme overlays
  static const Color black10 = Color(0x1A000000); // 10% black

  /// Black with 20% opacity for light theme overlays
  static const Color black20 = Color(0x33000000); // 20% black

  /// Black with 30% opacity for light theme overlays
  static const Color black30 = Color(0x4D000000); // 30% black

  /// Black with 40% opacity for chart components
  static const Color black40 = Color(0x66000000); // 40% black (chart component)

  /// Black with 50% opacity for light theme overlays
  static const Color black50 = Color(0x80000000); // 50% black

  /// Black with 60% opacity for light theme overlays
  static const Color black60 = Color(0x99000000); // 60% black

  /// Black with 70% opacity for light theme overlays
  static const Color black70 = Color(0xB3000000); // 70% black

  /// Black with 80% opacity for light theme overlays
  static const Color black80 = Color(0xCC000000); // 80% black

  /// Black with 90% opacity for dark backgrounds
  static const Color black90 = Color(0xE6000000); // 90% black

  // Dark theme overlays (white on black)
  /// White with 5% opacity for dark theme overlays
  static const Color white10 = Color(0x1AFFFFFF); // 5% white

  /// White with 20% opacity for dark theme overlays
  static const Color white20 = Color(0x33FFFFFF); // 20% white

  /// White with 30% opacity for dark theme overlays
  static const Color white30 = Color(0x4DFFFFFF); // 30% white

  /// White with 40% opacity for chart components
  static const Color white40 = Color(0x66FFFFFF); // 40% white (chart component)

  /// White with 50% opacity for dark theme overlays
  static const Color white50 = Color(0x80FFFFFF); // 50% white

  /// White with 60% opacity for dark theme overlays
  static const Color white60 = Color(0x99FFFFFF); // 60% white

  /// White with 70% opacity for dark theme overlays
  static const Color white70 = Color(0xB3FFFFFF); // 70% white

  /// White with 80% opacity for dark theme overlays
  static const Color white80 = Color(0xCCFFFFFF); // 80% white

  /// Get a preset color by name, returns white if not found
  /// Note: For 'default' theme, use HuxTokens.primary(context) instead for theme-aware colors
  static Color getPresetColor(String colorName) {
    return presetColors[colorName.toLowerCase()] ?? white;
  }

  /// Get all available preset color names
  static List<String> get availablePresetColors => presetColors.keys.toList();
}
