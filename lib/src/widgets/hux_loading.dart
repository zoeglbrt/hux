import 'package:flutter/material.dart';
import '../theme/hux_colors.dart';

/// HuxLoading is a customizable loading widget
class HuxLoading extends StatelessWidget {
  const HuxLoading({
    super.key,
    this.size = HuxLoadingSize.medium,
    this.color,
    this.strokeWidth,
  });

  final HuxLoadingSize size;
  final Color? color;
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

/// HuxLoadingOverlay provides a full-screen loading overlay
class HuxLoadingOverlay extends StatelessWidget {
  const HuxLoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
    this.backgroundColor,
  });

  final bool isLoading;
  final Widget child;
  final String? message;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
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

enum HuxLoadingSize { small, medium, large, extraLarge } 