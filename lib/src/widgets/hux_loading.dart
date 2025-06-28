import 'package:flutter/material.dart';
import '../theme/hux_colors.dart';

/// HuxLoading is a customizable circular loading indicator that provides
/// consistent loading states across the application.
/// 
/// Supports different sizes and colors, and automatically adapts to the
/// current theme. Perfect for indicating loading states in buttons, cards,
/// or standalone usage.
/// 
/// Example:
/// ```dart
/// // Basic loading indicator
/// HuxLoading()
/// 
/// // Large loading indicator with custom color
/// HuxLoading(
///   size: HuxLoadingSize.large,
///   color: Colors.blue,
/// )
/// ```
class HuxLoading extends StatelessWidget {
  /// Creates a HuxLoading widget.
  const HuxLoading({
    super.key,
    this.size = HuxLoadingSize.medium,
    this.color,
    this.strokeWidth,
  });

  /// Size of the loading indicator
  final HuxLoadingSize size;
  
  /// Color of the loading indicator. Defaults to primary theme color
  final Color? color;
  
  /// Width of the loading indicator stroke. Auto-calculated based on size if null
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return SizedBox(
      width: _getSize(),
      height: _getSize(),
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth ?? _getStrokeWidth(),
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? (isDark ? HuxColors.primary : HuxColors.primary),
        ),
      ),
    );
  }

  double _getSize() {
    switch (size) {
      case HuxLoadingSize.small:
        return 16;
      case HuxLoadingSize.medium:
        return 24;
      case HuxLoadingSize.large:
        return 32;
      case HuxLoadingSize.extraLarge:
        return 48;
    }
  }

  double _getStrokeWidth() {
    switch (size) {
      case HuxLoadingSize.small:
        return 2;
      case HuxLoadingSize.medium:
        return 3;
      case HuxLoadingSize.large:
        return 4;
      case HuxLoadingSize.extraLarge:
        return 5;
    }
  }
}

/// HuxLoadingOverlay provides a full-screen loading overlay that can be
/// placed on top of any widget to indicate loading states.
/// 
/// When [isLoading] is true, displays a semi-transparent overlay with a
/// centered loading indicator and optional message. The underlying content
/// is still visible but dimmed and not interactive.
/// 
/// Example:
/// ```dart
/// HuxLoadingOverlay(
///   isLoading: _isLoading,
///   message: 'Loading data...',
///   child: ListView(
///     children: [
///       // Your content here
///     ],
///   ),
/// )
/// ```
class HuxLoadingOverlay extends StatelessWidget {
  /// Creates a HuxLoadingOverlay widget.
  const HuxLoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
    this.backgroundColor,
  });

  /// Whether to show the loading overlay
  final bool isLoading;
  
  /// The child widget to display underneath the overlay
  final Widget child;
  
  /// Optional message to display below the loading indicator
  final String? message;
  
  /// Background color of the overlay. Defaults to semi-transparent black
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          ColoredBox(
            color: backgroundColor ?? Colors.black.withValues(alpha: 0.5),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const HuxLoading(size: HuxLoadingSize.large),
                  if (message != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      message!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: HuxColors.white,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }
}

/// Size variants for HuxLoading indicators
enum HuxLoadingSize { 
  /// Small loading indicator (16px)
  small, 
  
  /// Medium loading indicator (24px) 
  medium, 
  
  /// Large loading indicator (32px)
  large, 
  
  /// Extra large loading indicator (48px)
  extraLarge 
} 