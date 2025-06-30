/// Hux UI - A modern Flutter UI package with beautiful, customizable components
///
/// Hux provides a comprehensive set of UI components designed for clean and
/// consistent user interfaces. Features include:
///
/// - Modern button components with multiple variants
/// - Flexible card components
/// - Enhanced text input fields
/// - Customizable loading indicators
/// - Beautiful data visualization charts
/// - Pre-configured light and dark themes
/// - Comprehensive color palette
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
///             HuxTextField(label: 'Email'),
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
export 'src/components/inputs/hux_text_field.dart';
export 'src/theme/hux_theme.dart';
export 'src/theme/hux_colors.dart';
export 'src/widgets/hux_loading.dart';
export 'src/widgets/hux_chart.dart';
export 'src/widgets/hux_context_menu/hux_context_menu.dart';
export 'src/widgets/hux_context_menu/hux_context_menu_item.dart';
export 'src/widgets/hux_context_menu/hux_context_menu_divider.dart';

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
