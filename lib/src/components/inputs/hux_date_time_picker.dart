import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../../theme/hux_tokens.dart';

/// HuxDateTimePicker is a customizable date and time picker component with clean,
/// modern styling that adapts to light and dark themes.
///
/// Supports date-only, time-only, and combined date-time selection with
/// extensive customization options and consistent HUX UI styling.
///
/// Examples:
/// ```dart
/// // Date picker only
/// HuxDateTimePicker(
///   mode: HuxDateTimePickerMode.date,
///   label: 'Select Date',
///   onChanged: (DateTime? date) => print('Selected: $date'),
/// )
///
/// // Time picker only  
/// HuxDateTimePicker(
///   mode: HuxDateTimePickerMode.time,
///   label: 'Select Time',
///   onChanged: (DateTime? time) => print('Selected: $time'),
/// )
///
/// // Combined date and time picker
/// HuxDateTimePicker(
///   mode: HuxDateTimePickerMode.dateTime,
///   label: 'Select Date & Time',
///   initialValue: DateTime.now(),
///   onChanged: (DateTime? dateTime) => print('Selected: $dateTime'),
/// )
/// ```
class HuxDateTimePicker extends StatefulWidget {
  /// Creates a HuxDateTimePicker widget.
  const HuxDateTimePicker({
    super.key,
    this.initialValue,
    this.mode = HuxDateTimePickerMode.date,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.enabled = true,
    this.onChanged,
    this.validator,
    this.size = HuxDateTimePickerSize.medium,
    this.firstDate,
    this.lastDate,
    this.dateFormat,
    this.timeFormat,
    this.use24HourFormat,
  });

  /// Initial date/time value
  final DateTime? initialValue;

  /// Mode determining what to pick (date, time, or both)
  final HuxDateTimePickerMode mode;

  /// Label text displayed above the picker
  final String? label;

  /// Hint text displayed when no value is selected
  final String? hint;

  /// Helper text displayed below the picker
  final String? helperText;

  /// Error text displayed below the picker, overrides helperText
  final String? errorText;

  /// Whether the picker is enabled for interaction
  final bool enabled;

  /// Called when the selected value changes
  final ValueChanged<DateTime?>? onChanged;

  /// Validator function for form validation
  final String? Function(DateTime?)? validator;

  /// Size variant of the picker
  final HuxDateTimePickerSize size;

  /// Earliest selectable date (defaults to 1900)
  final DateTime? firstDate;

  /// Latest selectable date (defaults to 2100)
  final DateTime? lastDate;

  /// Custom date formatting function
  final String Function(DateTime)? dateFormat;

  /// Custom time formatting function
  final String Function(DateTime)? timeFormat;

  /// Whether to use 24-hour format for time (null = use system default)
  final bool? use24HourFormat;

  @override
  State<HuxDateTimePicker> createState() => _HuxDateTimePickerState();
}

class _HuxDateTimePickerState extends State<HuxDateTimePicker> {
  DateTime? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  void didUpdateWidget(HuxDateTimePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _selectedValue = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: HuxTokens.textSecondary(context),
                ),
          ),
          const SizedBox(height: 6),
        ],
        _buildPickerField(context),
        if (widget.helperText != null || widget.errorText != null) ...[
          const SizedBox(height: 6),
          Text(
            widget.errorText ?? widget.helperText!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: widget.errorText != null
                      ? HuxTokens.textDestructive(context)
                      : HuxTokens.textSecondary(context),
                ),
          ),
        ],
      ],
    );
  }

  Widget _buildPickerField(BuildContext context) {
    final hasError = widget.errorText != null;

    return InkWell(
      onTap: widget.enabled ? _showPicker : null,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: _getHeight(),
        decoration: BoxDecoration(
          color: widget.enabled
              ? HuxTokens.surfacePrimary(context)
              : HuxTokens.surfaceSecondary(context),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: hasError
                ? HuxTokens.destructive(context)
                : HuxTokens.borderPrimary(context),
            width: hasError ? 1.5 : 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: _getHorizontalPadding(),
            vertical: _getVerticalPadding(),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _getDisplayText(),
                  style: TextStyle(
                    fontSize: _getFontSize(),
                    height: 1.4,
                    color: _selectedValue != null
                        ? HuxTokens.textPrimary(context)
                        : HuxTokens.textSecondary(context),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                _getIcon(),
                size: _getIconSize(),
                color: HuxTokens.iconSecondary(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getDisplayText() {
    if (_selectedValue == null) {
      return widget.hint ?? _getDefaultHint();
    }

    switch (widget.mode) {
      case HuxDateTimePickerMode.date:
        return widget.dateFormat?.call(_selectedValue!) ??
            _formatDate(_selectedValue!);
      case HuxDateTimePickerMode.time:
        return widget.timeFormat?.call(_selectedValue!) ??
            _formatTime(_selectedValue!);
      case HuxDateTimePickerMode.dateTime:
        final dateStr = widget.dateFormat?.call(_selectedValue!) ??
            _formatDate(_selectedValue!);
        final timeStr = widget.timeFormat?.call(_selectedValue!) ??
            _formatTime(_selectedValue!);
        return '$dateStr at $timeStr';
    }
  }

  String _getDefaultHint() {
    switch (widget.mode) {
      case HuxDateTimePickerMode.date:
        return 'Select date';
      case HuxDateTimePickerMode.time:
        return 'Select time';
      case HuxDateTimePickerMode.dateTime:
        return 'Select date and time';
    }
  }

  IconData _getIcon() {
    switch (widget.mode) {
      case HuxDateTimePickerMode.date:
        return FeatherIcons.calendar;
      case HuxDateTimePickerMode.time:
        return FeatherIcons.clock;
      case HuxDateTimePickerMode.dateTime:
        return FeatherIcons.calendar;
    }
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _formatTime(DateTime time) {
    final use24Hour = widget.use24HourFormat ?? 
        MediaQuery.of(context).alwaysUse24HourFormat;
    
    if (use24Hour) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else {
      final hour = time.hour == 0 ? 12 : (time.hour > 12 ? time.hour - 12 : time.hour);
      final period = time.hour >= 12 ? 'PM' : 'AM';
      return '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period';
    }
  }

  Future<void> _showPicker() async {
    DateTime? result;

    switch (widget.mode) {
      case HuxDateTimePickerMode.date:
        result = await _showDatePicker();
        break;
      case HuxDateTimePickerMode.time:
        result = await _showTimePicker();
        break;
      case HuxDateTimePickerMode.dateTime:
        result = await _showDateTimePicker();
        break;
    }

    if (result != null) {
      setState(() {
        _selectedValue = result;
      });
      widget.onChanged?.call(result);
    }
  }

  Future<DateTime?> _showDatePicker() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedValue ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2100),
      builder: (context, child) => _buildThemedDialog(child!),
    );

    if (date != null) {
      // Preserve time if we already have a selected value
      if (_selectedValue != null) {
        return DateTime(
          date.year,
          date.month,
          date.day,
          _selectedValue!.hour,
          _selectedValue!.minute,
        );
      }
      return date;
    }
    return null;
  }

  Future<DateTime?> _showTimePicker() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedValue != null 
          ? TimeOfDay.fromDateTime(_selectedValue!)
          : TimeOfDay.now(),
      builder: (context, child) => _buildThemedDialog(child!),
    );

    if (time != null) {
      final now = DateTime.now();
      // Preserve date if we already have a selected value
      final baseDate = _selectedValue ?? now;
      return DateTime(
        baseDate.year,
        baseDate.month,
        baseDate.day,
        time.hour,
        time.minute,
      );
    }
    return null;
  }

  Future<DateTime?> _showDateTimePicker() async {
    // First show date picker
    final date = await _showDatePicker();
    if (date == null) return null;

    // Check if widget is still mounted before showing time picker
    if (!mounted) return null;

    // Then show time picker
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedValue != null 
          ? TimeOfDay.fromDateTime(_selectedValue!)
          : TimeOfDay.now(),
      builder: (context, child) => _buildThemedDialog(child!),
    );

    if (time != null) {
      return DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    }
    return date; // Return just the date if time selection was cancelled
  }

  Widget _buildThemedDialog(Widget child) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: HuxTokens.primary(context),
          surface: HuxTokens.surfaceElevated(context),
        ),
      ),
      child: child,
    );
  }

  double _getHeight() {
    switch (widget.size) {
      case HuxDateTimePickerSize.small:
        return 32;
      case HuxDateTimePickerSize.medium:
        return 40;
      case HuxDateTimePickerSize.large:
        return 48;
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case HuxDateTimePickerSize.small:
        return 14;
      case HuxDateTimePickerSize.medium:
        return 16;
      case HuxDateTimePickerSize.large:
        return 18;
    }
  }

  double _getHorizontalPadding() {
    switch (widget.size) {
      case HuxDateTimePickerSize.small:
        return 16;
      case HuxDateTimePickerSize.medium:
        return 18;
      case HuxDateTimePickerSize.large:
        return 20;
    }
  }

  double _getVerticalPadding() {
    switch (widget.size) {
      case HuxDateTimePickerSize.small:
        return 8;
      case HuxDateTimePickerSize.medium:
        return 12;
      case HuxDateTimePickerSize.large:
        return 16;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case HuxDateTimePickerSize.small:
        return 16;
      case HuxDateTimePickerSize.medium:
        return 18;
      case HuxDateTimePickerSize.large:
        return 20;
    }
  }
}

/// Mode determining what the picker should allow selection of
enum HuxDateTimePickerMode {
  /// Date selection only
  date,
  
  /// Time selection only
  time,
  
  /// Combined date and time selection
  dateTime,
}

/// Size variants for HuxDateTimePicker
enum HuxDateTimePickerSize {
  /// Small picker with compact padding
  small,

  /// Medium picker with standard padding
  medium,

  /// Large picker with generous padding
  large,
} 