import 'package:flutter/material.dart';

/// HuxColors defines a minimal, focused color palette for the Hux UI components
/// 
/// The primary color defaults to white but can be customized using preset colors
/// or any custom Color. Use HuxColors.getPresetColor('colorName') to get preset colors.
/// 
class HuxColors {
  HuxColors._();

  // Core colors
  static const Color primary = white;
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color error = Color(0xFFEF4444);

  // Essential preset colors for primary customization
  static const Map<String, Color> presetColors = {
    'white': Color(0xFFFFFFFF),
    'indigo': Color(0xFF6366F1),
    'green': Color(0xFF10B981),
    'red': Color(0xFFEF4444),
  };



  // Essential transparency levels (only the ones actually used)
  // Light theme overlays (black on white)
  static const Color black10 = Color(0x1A000000);  // 10% black
  static const Color black20 = Color(0x33000000);  // 20% black
  static const Color black30 = Color(0x4D000000);  // 30% black
  static const Color black40 = Color(0x66000000);  // 40% black (chart component)
  static const Color black50 = Color(0x80000000);  // 50% black
  static const Color black60 = Color(0x99000000);  // 60% black
  static const Color black70 = Color(0xB3000000);  // 70% black
  static const Color black80 = Color(0xCC000000);  // 80% black
  static const Color black90 = Color(0xE6000000);  // 90% black

  // Dark theme overlays (white on black)
  static const Color white5 = Color(0x0DFFFFFF);   // 5% white
  static const Color white20 = Color(0x33FFFFFF);  // 20% white
  static const Color white30 = Color(0x4DFFFFFF);  // 30% white
  static const Color white40 = Color(0x66FFFFFF);  // 40% white (chart component)
  static const Color white50 = Color(0x80FFFFFF);  // 50% white
  static const Color white60 = Color(0x99FFFFFF);  // 60% white
  static const Color white70 = Color(0xB3FFFFFF);  // 70% white
  static const Color white80 = Color(0xCCFFFFFF);  // 80% white



  /// Get a preset color by name, returns white if not found
  static Color getPresetColor(String colorName) {
    return presetColors[colorName.toLowerCase()] ?? white;
  }

  /// Get all available preset color names
  static List<String> get availablePresetColors => presetColors.keys.toList();
} 