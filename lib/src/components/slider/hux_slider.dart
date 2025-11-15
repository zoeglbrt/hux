import 'package:flutter/material.dart';
import '../../theme/hux_tokens.dart';

/// HuxSlider is a customizable slider component with smooth animations that follows
/// the Hux design system patterns.
///
/// Provides a clean, modern slider with consistent styling, proper theme adaptation,
/// and support for labels, divisions, and value display. Features smooth animations
/// for value changes.
///
/// Example:
/// ```dart
/// HuxSlider(
///   value: sliderValue,
///   onChanged: (value) => setState(() => sliderValue = value),
///   min: 0,
///   max: 100,
///   label: 'Volume',
///   showValue: true,
/// )
/// ```
class HuxSlider extends StatelessWidget {
  /// Creates a HuxSlider widget.
  const HuxSlider({
    super.key,
    required this.value,
    this.onChanged,
    this.min = 0.0,
    this.max = 100.0,
    this.divisions,
    this.label,
    this.showValue = false,
    this.isDisabled = false,
    this.size = HuxSliderSize.medium,
    this.activeColor,
  });

  /// The current value of the slider
  final double value;

  /// Called when the slider value changes
  final ValueChanged<double>? onChanged;

  /// Minimum value for the slider
  final double min;

  /// Maximum value for the slider
  final double max;

  /// Number of discrete divisions (null for continuous)
  final int? divisions;

  /// Optional label displayed above the slider
  final String? label;

  /// Whether to show the current value next to the label
  final bool showValue;

  /// Whether the slider is disabled
  final bool isDisabled;

  /// Size variant of the slider
  final HuxSliderSize size;

  /// Custom active color (uses primary color by default)
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null || showValue) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (label != null)
                Text(
                  label!,
                  style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.labelMedium?.fontSize ?? 12,
                    fontWeight: FontWeight.w300,
                    color: isDisabled
                        ? HuxTokens.textDisabled(context)
                        : HuxTokens.textSecondary(context),
                  ),
                ),
              if (showValue)
                Text(
                  value.toStringAsFixed(divisions != null ? 0 : 1),
                  style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.labelMedium?.fontSize ?? 12,
                    fontWeight: FontWeight.w400,
                    color: isDisabled
                        ? HuxTokens.textDisabled(context)
                        : HuxTokens.textSecondary(context),
                  ),
                ),
            ],
          ),
          SizedBox(height: _getLabelSpacing()),
        ],
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: _getActiveColor(context),
            inactiveTrackColor: _getInactiveColor(context),
            thumbColor: _getThumbColor(context),
            overlayColor: _getOverlayColor(context),
            trackHeight: _getTrackHeight(),
            thumbShape: _HuxSliderThumbShape(size: size),
            overlayShape: _HuxSliderOverlayShape(size: size),
            tickMarkShape: divisions != null
                ? _HuxSliderTickMarkShape(size: size)
                : const RoundSliderTickMarkShape(),
            activeTickMarkColor: _getActiveColor(context),
            inactiveTickMarkColor: _getInactiveColor(context),
          ),
          child: Slider(
            value: value.clamp(min, max),
            onChanged: isDisabled || onChanged == null
                ? null
                : (newValue) {
                    if (onChanged != null) {
                      onChanged!(newValue);
                    }
                  },
            min: min,
            max: max,
            divisions: divisions,
          ),
        ),
      ],
    );
  }

  Color _getActiveColor(BuildContext context) {
    if (isDisabled) {
      return HuxTokens.borderSecondary(context);
    }
    return activeColor ?? HuxTokens.primary(context);
  }

  Color _getInactiveColor(BuildContext context) {
    if (isDisabled) {
      return HuxTokens.surfaceSecondary(context).withValues(alpha: 0.5);
    }
    return HuxTokens.surfaceSecondary(context);
  }

  Color _getThumbColor(BuildContext context) {
    if (isDisabled) {
      return HuxTokens.surfaceSecondary(context);
    }
    return activeColor ?? HuxTokens.primary(context);
  }

  Color _getOverlayColor(BuildContext context) {
    if (isDisabled) {
      return Colors.transparent;
    }
    return (activeColor ?? HuxTokens.primary(context)).withValues(alpha: 0.1);
  }

  double _getTrackHeight() {
    switch (size) {
      case HuxSliderSize.small:
        return 2.0;
      case HuxSliderSize.medium:
        return 3.0;
      case HuxSliderSize.large:
        return 4.0;
    }
  }

  double _getLabelSpacing() {
    switch (size) {
      case HuxSliderSize.small:
        return 4.0;
      case HuxSliderSize.medium:
        return 6.0;
      case HuxSliderSize.large:
        return 8.0;
    }
  }
}

/// Custom thumb shape for HuxSlider
class _HuxSliderThumbShape extends SliderComponentShape {
  const _HuxSliderThumbShape({required this.size});

  final HuxSliderSize size;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    final thumbSize = _getThumbSize();
    return Size(thumbSize, thumbSize);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required Size sizeWithOverflow,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
  }) {
    final canvas = context.canvas;
    final thumbSize = _getThumbSize();

    // Draw thumb as a filled circle
    final thumbPaint = Paint()
      ..color = sliderTheme.thumbColor!
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      center,
      thumbSize / 2,
      thumbPaint,
    );
  }

  double _getThumbSize() {
    switch (size) {
      case HuxSliderSize.small:
        return 14.0;
      case HuxSliderSize.medium:
        return 18.0;
      case HuxSliderSize.large:
        return 22.0;
    }
  }
}

/// Custom overlay shape for HuxSlider
class _HuxSliderOverlayShape extends SliderComponentShape {
  const _HuxSliderOverlayShape({required this.size});

  final HuxSliderSize size;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    final overlaySize = _getOverlaySize();
    return Size(overlaySize, overlaySize);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required Size sizeWithOverflow,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
  }) {
    final canvas = context.canvas;
    final overlaySize = _getOverlaySize();

    final overlayPaint = Paint()
      ..color = sliderTheme.overlayColor ?? Colors.transparent
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      center,
      overlaySize / 2,
      overlayPaint,
    );
  }

  double _getOverlaySize() {
    switch (size) {
      case HuxSliderSize.small:
        return 28.0;
      case HuxSliderSize.medium:
        return 36.0;
      case HuxSliderSize.large:
        return 44.0;
    }
  }
}

/// Custom tick mark shape for HuxSlider
class _HuxSliderTickMarkShape extends SliderTickMarkShape {
  const _HuxSliderTickMarkShape({required this.size});

  final HuxSliderSize size;

  @override
  Size getPreferredSize({
    required SliderThemeData sliderTheme,
    required bool isEnabled,
  }) {
    final tickSize = _getTickSize();
    return Size(tickSize, tickSize);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    required bool isEnabled,
  }) {
    final canvas = context.canvas;
    final tickSize = _getTickSize();

    final tickPaint = Paint()
      ..color = sliderTheme.activeTickMarkColor ?? Colors.transparent
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      center,
      tickSize / 2,
      tickPaint,
    );
  }

  double _getTickSize() {
    switch (size) {
      case HuxSliderSize.small:
        return 2.0;
      case HuxSliderSize.medium:
        return 3.0;
      case HuxSliderSize.large:
        return 4.0;
    }
  }
}

/// Size variants for HuxSlider
enum HuxSliderSize {
  /// Small slider for compact layouts
  small,

  /// Medium slider for standard use
  medium,

  /// Large slider for emphasis
  large
}
