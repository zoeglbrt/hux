import 'package:flutter/material.dart';

/// HuxContextMenuItem is a single item within a context menu
///
/// Provides consistent styling and behavior for menu items with support for
/// icons, text, disabled states, and destructive actions.
///
/// Example:
/// ```dart
/// HuxContextMenuItem(
///   text: 'Copy',
///   icon: Icons.copy,
///   onTap: () => print('Copy action'),
/// )
/// ```
class HuxContextMenuItem extends StatelessWidget {
  /// Creates a HuxContextMenuItem widget.
  ///
  /// The [text] and [onTap] parameters are required unless [isDisabled] is true.
  const HuxContextMenuItem({
    super.key,
    required this.text,
    this.onTap,
    this.icon,
    this.isDisabled = false,
    this.isDestructive = false,
  });

  /// The text to display in the menu item
  final String text;

  /// Callback triggered when the menu item is tapped
  final VoidCallback? onTap;

  /// Optional icon to display before the text
  final IconData? icon;

  /// Whether the menu item is disabled
  final bool isDisabled;

  /// Whether this is a destructive action (uses error color)
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    // This widget is now just a data holder
    // The actual rendering is handled by _HuxContextMenuItemWrapper
    return const SizedBox.shrink();
  }
}
