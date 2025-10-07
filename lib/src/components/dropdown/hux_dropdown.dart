import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../theme/hux_tokens.dart';
import '../buttons/hux_button.dart';

/// A dropdown/select component with overlay-based options list.
class HuxDropdown<T> extends StatefulWidget {
  /// Creates a dropdown component.
  ///
  /// The [items] parameter must not be null and should contain at least one item.
  /// Use [value] to control the selected item, [onChanged] to handle selection changes,
  /// and [placeholder] to show text when no item is selected.
  const HuxDropdown({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.placeholder = 'Select option',
    this.variant = HuxButtonVariant.outline,
    this.size = HuxButtonSize.medium,
    this.primaryColor,
    this.enabled = true,
    this.maxHeight = 200,
  });

  /// List of dropdown items
  final List<HuxDropdownItem<T>> items;

  /// Currently selected value
  final T? value;

  /// Called when selection changes
  final ValueChanged<T>? onChanged;

  /// Placeholder text when no value selected
  final String placeholder;

  /// Visual style of the trigger button
  final HuxButtonVariant variant;

  /// Size of the trigger button
  final HuxButtonSize size;

  /// Optional primary color override
  final Color? primaryColor;

  /// Whether the dropdown is enabled
  final bool enabled;

  /// Maximum height of the dropdown panel
  final double maxHeight;

  @override
  State<HuxDropdown<T>> createState() => _HuxDropdownState<T>();
}

class _HuxDropdownState<T> extends State<HuxDropdown<T>> {
  final GlobalKey _buttonKey = GlobalKey();
  bool _isOpen = false;

  @override
  void dispose() {
    super.dispose();
  }

  /// Toggles the dropdown panel open/closed state
  void _toggleDropdown() {
    _openDropdown();
  }

  Future<void> _openDropdown() async {
    if (!widget.enabled || widget.items.isEmpty) return;

    final RenderBox? button =
        _buttonKey.currentContext?.findRenderObject() as RenderBox?;
    if (button == null) return;

    final buttonPosition = button.localToGlobal(Offset.zero);
    final buttonSize = button.size;
    final screenSize = MediaQuery.of(context).size;

    setState(() => _isOpen = true);

    final T? selectedValue = await showDialog<T>(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(color: Colors.transparent),
              ),
            ),
            Positioned(
              left: buttonPosition.dx,
              top: buttonPosition.dy + buttonSize.height + 4,
              width: buttonSize.width,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: widget.maxHeight,
                    maxWidth: screenSize.width - buttonPosition.dx - 8,
                  ),
                  decoration: BoxDecoration(
                    color: HuxTokens.surfaceElevated(context),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: HuxTokens.borderPrimary(context),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(26),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(4),
                    shrinkWrap: true,
                    itemCount: widget.items.length,
                    itemBuilder: (context, index) {
                      final item = widget.items[index];
                      final isSelected = item.value == widget.value;

                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashFactory: NoSplash.splashFactory,
                          overlayColor: WidgetStateProperty.resolveWith<Color?>(
                            (Set<WidgetState> states) {
                              if (states.contains(WidgetState.hovered)) {
                                return HuxTokens.surfaceHover(context);
                              }
                              return null;
                            },
                          ),
                          borderRadius: BorderRadius.circular(4),
                          onTap: () => Navigator.pop(context, item.value),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: isSelected
                                  ? HuxTokens.primary(context).withAlpha(26)
                                  : null,
                            ),
                            child: Row(
                              children: [
                                Expanded(child: item.child),
                                if (isSelected)
                                  Icon(
                                    LucideIcons.check,
                                    size: 16,
                                    color: HuxTokens.primary(context),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    if (mounted) {
      setState(() => _isOpen = false);
      if (selectedValue != null) {
        widget.onChanged?.call(selectedValue);
      }
    }
  }

  String get _displayText {
    if (widget.value == null) return widget.placeholder;

    final item = widget.items.firstWhere(
      (item) => item.value == widget.value,
      orElse: () => HuxDropdownItem(
          value: widget.value as T, child: Text('${widget.value}')),
    );

    if (item.child is Text) {
      return (item.child as Text).data ?? '';
    }
    return widget.value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return HuxButton(
      key: _buttonKey,
      onPressed: widget.enabled ? _toggleDropdown : null,
      variant: widget.variant,
      size: widget.size,
      primaryColor: widget.primaryColor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              _displayText,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: widget.variant == HuxButtonVariant.primary
                    ? _getContrastingTextColor(
                        widget.primaryColor ?? HuxTokens.primary(context),
                        context)
                    : widget.value == null
                        ? HuxTokens.textSecondary(context)
                        : HuxTokens.textPrimary(context),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            _isOpen ? LucideIcons.chevronUp : LucideIcons.chevronDown,
            size: 16,
            color: widget.variant == HuxButtonVariant.primary
                ? _getContrastingTextColor(
                    widget.primaryColor ?? HuxTokens.primary(context), context)
                : HuxTokens.iconSecondary(context),
          ),
        ],
      ),
    );
  }
}

/// Individual dropdown item
class HuxDropdownItem<T> {
  /// Creates a dropdown item with a [value] and [child] widget to display.
  const HuxDropdownItem({
    required this.value,
    required this.child,
  });

  /// The value associated with this item.
  final T value;

  /// The widget to display for this item.
  final Widget child;
}

/// Determines the appropriate text color based on WCAG AA contrast requirements
Color _getContrastingTextColor(Color backgroundColor, BuildContext context) {
  // Calculate contrast ratios for both white and black text
  final whiteContrast =
      _calculateContrastRatio(backgroundColor, HuxTokens.textInvert(context));
  final blackContrast =
      _calculateContrastRatio(backgroundColor, HuxTokens.textPrimary(context));

  // Choose the text color with better contrast ratio
  // WCAG AA requires minimum 4.5:1 contrast ratio for normal text
  return whiteContrast > blackContrast
      ? HuxTokens.textInvert(context)
      : HuxTokens.textPrimary(context);
}

/// Calculates the contrast ratio between two colors according to WCAG guidelines
/// Returns a value between 1 and 21, where higher values indicate better contrast
double _calculateContrastRatio(Color color1, Color color2) {
  final luminance1 = _getRelativeLuminance(color1);
  final luminance2 = _getRelativeLuminance(color2);

  final lighter = luminance1 > luminance2 ? luminance1 : luminance2;
  final darker = luminance1 > luminance2 ? luminance2 : luminance1;

  return (lighter + 0.05) / (darker + 0.05);
}

/// Calculates the relative luminance of a color according to WCAG guidelines
/// Returns a value between 0 and 1
double _getRelativeLuminance(Color color) {
  // Convert RGB values to 0-1 range
  final r = color.r / 255.0;
  final g = color.g / 255.0;
  final b = color.b / 255.0;

  // Apply gamma correction
  final rLinear = r <= 0.03928 ? r / 12.92 : pow((r + 0.055) / 1.055, 2.4);
  final gLinear = g <= 0.03928 ? g / 12.92 : pow((g + 0.055) / 1.055, 2.4);
  final bLinear = b <= 0.03928 ? b / 12.92 : pow((b + 0.055) / 1.055, 2.4);

  // Calculate relative luminance using ITU-R BT.709 coefficients
  return 0.2126 * rLinear + 0.7152 * gLinear + 0.0722 * bLinear;
}
