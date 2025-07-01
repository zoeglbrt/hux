import 'package:flutter/material.dart';
import '../../theme/hux_tokens.dart';

/// HuxContextMenuDivider is a visual separator for context menu items
///
/// Provides a subtle line to separate groups of menu items for better
/// organization and visual hierarchy.
///
/// Example:
/// ```dart
/// HuxContextMenu(
///   menuItems: [
///     HuxContextMenuItem(text: 'Copy', onTap: () {}),
///     HuxContextMenuItem(text: 'Paste', onTap: () {}),
///     HuxContextMenuDivider(),
///     HuxContextMenuItem(text: 'Delete', onTap: () {}),
///   ],
///   child: Widget(),
/// )
/// ```
class HuxContextMenuDivider extends StatelessWidget {
  /// Creates a HuxContextMenuDivider widget.
  const HuxContextMenuDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Divider(
        height: 1,
        thickness: 1,
        color: HuxTokens.borderSecondary(context),
      ),
    );
  }
}
