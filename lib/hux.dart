/// Hux UI - A modern Flutter UI package with beautiful, customizable components
///
/// Hux provides a comprehensive set of UI components designed for clean and
/// consistent user interfaces. Features include:
///
/// - Modern button components with multiple variants and WCAG AA contrast
/// - Flexible card components with semantic tokens
/// - Enhanced text input fields with validation support
/// - Customizable loading indicators with theme awareness
/// - Beautiful data visualization charts with cristalyse integration
/// - Right-click context menus with smart positioning
/// - Pre-configured light and dark themes
/// - Design token system for consistent theming
/// - Optimized web experience with clean context menus
///
/// ## Usage
///
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'package:hux/hux.dart';
///
/// class MyApp extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return MaterialApp(
///       theme: HuxTheme.lightTheme,
///       darkTheme: HuxTheme.darkTheme,
///       home: Scaffold(
///         body: Column(
///           children: [
///             HuxButton(
///               onPressed: () {},
///               child: Text('Primary Button'),
///             ),
///             HuxInput(label: 'Email'),
///             HuxCard(title: 'Card Title'),
///           ],
///         ),
///       ),
///     );
///   }
/// }
/// ```
library;

// Export all components
export 'src/components/buttons/hux_button.dart';
export 'src/components/cards/hux_card.dart';
export 'src/components/inputs/hux_input.dart';
export 'src/components/inputs/hux_date_input.dart';
export 'src/components/inputs/hux_checkbox.dart';
export 'src/components/switch/hux_switch.dart';
export 'src/components/badge/hux_badge.dart';
export 'src/components/feedback/hux_alert.dart';
export 'src/components/avatar/hux_avatar.dart';
export 'src/components/avatar/hux_avatar_group.dart';
export 'src/components/tooltip/hux_tooltip.dart';
export 'src/theme/hux_theme.dart';
export 'src/theme/hux_colors.dart';
export 'src/theme/hux_tokens.dart';
export 'src/widgets/hux_loading.dart';
export 'src/widgets/hux_chart.dart';
export 'src/widgets/hux_context_menu/hux_context_menu.dart';
export 'src/widgets/hux_context_menu/hux_context_menu_item.dart';
export 'src/widgets/hux_context_menu/hux_context_menu_divider.dart';
export 'src/widgets/hux_date_picker.dart';
export 'src/widgets/hux_time_picker.dart';

// Export external dependencies
/// FeatherIcons - Beautiful icon set for Flutter applications
///
/// Provides access to over 280+ beautiful, customizable SVG icons.
/// Use FeatherIcons.iconName to access any icon.
///
/// Example:
/// ```dart
/// Icon(FeatherIcons.heart)
/// Icon(FeatherIcons.user)
/// ```
export 'package:flutter_feather_icons/flutter_feather_icons.dart';
