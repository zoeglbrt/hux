import 'package:flutter/material.dart';
import '../../theme/hux_tokens.dart';

/// HuxSwitch is a toggle switch component with smooth animations that follows
/// the Hux design system patterns.
///
/// Provides a clean, modern toggle with subtle borders, consistent sizing,
/// and proper theme adaptation. Features smooth 200ms animations for state changes.
///
/// Example:
/// ```dart
/// HuxSwitch(
///   value: isSwitchedOn,
///   onChanged: (value) => setState(() => isSwitchedOn = value),
///   size: HuxSwitchSize.medium,
/// )
/// ```
class HuxSwitch extends StatelessWidget {
  /// Creates a HuxSwitch widget.
  const HuxSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.isDisabled = false,
    this.size = HuxSwitchSize.medium,
  });

  /// The current switch state
  final bool value;

  /// Called when the switch state changes
  final ValueChanged<bool>? onChanged;

  /// Whether the switch is disabled
  final bool isDisabled;

  /// Size variant of the switch
  final HuxSwitchSize size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled || onChanged == null
          ? null
          : () => onChanged?.call(!value),
      child: Padding(
        padding: const EdgeInsets.all(4), // Touch target padding
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: _getSwitchWidth(),
          height: _getSwitchHeight(),
          padding: EdgeInsets.all(_getPadding()),
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(10), // Consistent with Hux border radius
            color: _getBackgroundColor(context),
            border: Border.all(
              color: _getBorderColor(context),
              width: 1, // Consistent with Hux border width
            ),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: _getHandleSize(),
              height: _getHandleSize(),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(8), // Consistent rounded corners
                color: _getHandleColor(context),
                border: Border.all(
                  color: _getHandleBorderColor(context),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    if (isDisabled) {
      return HuxTokens.surfaceSecondary(context).withValues(alpha: 0.5);
    }
    return value
        ? HuxTokens.primary(context).withValues(alpha: 0.1)
        : HuxTokens.surfaceSecondary(context);
  }

  Color _getBorderColor(BuildContext context) {
    if (isDisabled) {
      return HuxTokens.borderSecondary(context);
    }
    return HuxTokens.borderPrimary(context);
  }

  Color _getHandleColor(BuildContext context) {
    if (isDisabled) {
      return HuxTokens.surfaceSecondary(context);
    }
    return value
        ? HuxTokens.primary(context)
        : HuxTokens.surfacePrimary(context);
  }

  Color _getHandleBorderColor(BuildContext context) {
    if (isDisabled) {
      return HuxTokens.borderSecondary(context);
    }
    return value
        ? HuxTokens.primary(context)
        : HuxTokens.borderPrimary(context);
  }

  double _getSwitchWidth() {
    switch (size) {
      case HuxSwitchSize.small:
        return 36;
      case HuxSwitchSize.medium:
        return 44;
      case HuxSwitchSize.large:
        return 52;
    }
  }

  double _getSwitchHeight() {
    switch (size) {
      case HuxSwitchSize.small:
        return 20;
      case HuxSwitchSize.medium:
        return 24;
      case HuxSwitchSize.large:
        return 28;
    }
  }

  double _getHandleSize() {
    switch (size) {
      case HuxSwitchSize.small:
        return 14;
      case HuxSwitchSize.medium:
        return 18;
      case HuxSwitchSize.large:
        return 22;
    }
  }

  double _getPadding() {
    return 2.0;
  }
}

/// Size variants for HuxSwitch
enum HuxSwitchSize {
  /// Small switch for compact layouts
  small,

  /// Medium switch for standard use
  medium,

  /// Large switch for emphasis
  large
}
