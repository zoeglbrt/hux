import 'package:flutter/material.dart';
import '../../theme/hux_tokens.dart';

/// HuxCard is a customizable card component that provides a consistent
/// container with optional header, title, subtitle, and actions.
///
/// The card automatically adapts to light and dark themes and provides
/// a clean, modern appearance with subtle borders and optional shadows.
///
/// Example:
/// ```dart
/// HuxCard(
///   title: 'User Profile',
///   subtitle: 'Manage your account settings',
///   action: IconButton(
///     icon: Icon(Icons.more_vert),
///     onPressed: () {},
///   ),
///   child: Column(
///     children: [
///       Text('Card content goes here'),
///       // ... more content
///     ],
///   ),
///   onTap: () => print('Card tapped'),
/// )
/// ```
class HuxCard extends StatelessWidget {
  /// Creates a HuxCard widget.
  ///
  /// The [child] parameter is required and contains the main content of the card.
  const HuxCard({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.action,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.elevation = 0,
    this.borderRadius = 12,
    this.onTap,
  });

  /// The main content widget to display inside the card
  final Widget child;

  /// Optional title text displayed in the card header
  final String? title;

  /// Optional subtitle text displayed below the title
  final String? subtitle;

  /// Optional action widget displayed in the top-right corner of the header
  final Widget? action;

  /// Padding around the main content. Defaults to 16px on all sides
  final EdgeInsetsGeometry padding;

  /// Margin around the entire card. Defaults to zero
  final EdgeInsetsGeometry margin;

  /// Elevation of the card shadow. Defaults to 0 for a flat appearance
  final double elevation;

  /// Border radius of the card corners. Defaults to 12px
  final double borderRadius;

  /// Callback triggered when the card is tapped. If null, the card is not interactive
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Material(
        elevation: elevation,
        borderRadius: BorderRadius.circular(borderRadius),
        color: HuxTokens.surfaceElevated(context),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: HuxTokens.borderPrimary(context),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null || subtitle != null || action != null)
                  _buildHeader(context),
                Padding(
                  padding: padding,
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: HuxTokens.textPrimary(context),
                        ),
                  ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: HuxTokens.textTertiary(context),
                        ),
                  ),
                ],
              ],
            ),
          ),
          if (action != null) action!,
        ],
      ),
    );
  }
}
