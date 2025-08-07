import 'package:flutter/material.dart';
import '../theme/hux_tokens.dart';
import '../components/buttons/hux_button.dart';

/// Shows a Hux UI-themed date picker dialog.
///
/// This function displays a custom date picker with modern design patterns,
/// featuring compact month/year dropdowns, clean grid layout, and Hux theming.
///
/// Example:
/// ```dart
/// final DateTime? picked = await showHuxDatePickerDialog(
///   context: context,
///   initialDate: DateTime.now(),
///   firstDate: DateTime(2000),
///   lastDate: DateTime(2100),
/// );
/// ```
///
/// Returns the selected date or null if cancelled.
Future<DateTime?> showHuxDatePickerDialog({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
  GlobalKey? targetKey,
}) {
  return showDialog<DateTime>(
    context: context,
    barrierColor: Colors.transparent,
    builder: (context) => Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 120),
        child: HuxDatePickerDialog(
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
        ),
      ),
    ),
  );
}

/// A custom Hux UI-themed date picker dialog widget.
///
/// This widget provides a modern date picker with month/year selection,
/// calendar grid layout, and Hux theming support.
///
/// Example:
/// ```dart
/// HuxDatePickerDialog(
///   initialDate: DateTime.now(),
///   firstDate: DateTime(2000),
///   lastDate: DateTime(2100),
/// )
/// ```
class HuxDatePickerDialog extends StatefulWidget {
  /// Creates a Hux date picker dialog.
  ///
  /// [initialDate] is the date initially selected.
  /// [firstDate] is the earliest date that can be selected.
  /// [lastDate] is the latest date that can be selected.
  const HuxDatePickerDialog({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
  });

  /// The initially selected date.
  final DateTime initialDate;

  /// The earliest date that can be selected.
  final DateTime firstDate;

  /// The latest date that can be selected.
  final DateTime lastDate;

  @override
  State<HuxDatePickerDialog> createState() => _HuxDatePickerDialogState();
}

class _HuxDatePickerDialogState extends State<HuxDatePickerDialog> {
  late DateTime _selectedDate;
  late DateTime _currentMonth;
  bool _isShowingMonthPicker = false;
  bool _isShowingYearPicker = false;
  late ScrollController _yearScrollController;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    // Set default to 2025 if the initial date is outside our range
    final defaultYear =
        widget.initialDate.year >= 1900 && widget.initialDate.year <= 2050
            ? widget.initialDate.year
            : 2025;
    _currentMonth = DateTime(defaultYear, widget.initialDate.month);
    _yearScrollController = ScrollController();
  }

  @override
  void dispose() {
    _yearScrollController.dispose();
    super.dispose();
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    // Close the dialog immediately when a date is selected
    Navigator.of(context).pop(date);
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: HuxTokens.surfaceElevated(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: HuxTokens.buttonSecondaryBorder(context),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with month/year dropdowns
            SizedBox(
              width: 7 * 32 + 6, // 7 columns of 32px each + 6px for margins
              child: _buildHeader(),
            ),
            const SizedBox(height: 16),

            // Calendar grid or month/year picker
            _isShowingMonthPicker
                ? SizedBox(
                    width:
                        7 * 32 + 6, // 7 columns of 32px each + 6px for margins
                    child: _buildMonthPicker(),
                  )
                : _isShowingYearPicker
                    ? SizedBox(
                        width: 7 * 32 +
                            6, // 7 columns of 32px each + 6px for margins
                        child: _buildYearPicker(),
                      )
                    : SizedBox(
                        width: 7 * 32 +
                            6, // 7 columns of 32px each + 6px for margins
                        child: _buildCalendarGrid(),
                      ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        // Left navigation arrow
        _buildNavigationButton(
          icon: Icons.chevron_left,
          onPressed: _previousMonth,
        ),
        const SizedBox(width: 12),

        // Month dropdown
        Expanded(
          child: _buildMonthButton(),
        ),
        const SizedBox(width: 8),

        // Year dropdown
        Expanded(
          child: _buildYearButton(),
        ),
        const SizedBox(width: 12),

        // Right navigation arrow
        _buildNavigationButton(
          icon: Icons.chevron_right,
          onPressed: _nextMonth,
        ),
      ],
    );
  }

  Widget _buildMonthButton() {
    return HuxButton(
      onPressed: () => _toggleMonthPicker(),
      variant: HuxButtonVariant.outline,
      size: HuxButtonSize.small,
      child: Text(
        _getMonthName(_currentMonth.month),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildYearButton() {
    return HuxButton(
      onPressed: () => _toggleYearPicker(),
      variant: HuxButtonVariant.outline,
      size: HuxButtonSize.small,
      child: Text(
        _currentMonth.year.toString(),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _toggleMonthPicker() {
    setState(() {
      _isShowingMonthPicker = !_isShowingMonthPicker;
      _isShowingYearPicker = false;
    });
  }

  void _toggleYearPicker() {
    setState(() {
      _isShowingYearPicker = !_isShowingYearPicker;
      _isShowingMonthPicker = false;
    });

    // Jump to current year immediately when opening year picker
    if (_isShowingYearPicker) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final currentYearIndex = _currentMonth.year - 1900;
        const itemHeight = 36.0; // height of each year item
        const itemPadding = 4.0; // padding between items (from Padding widget)
        const totalItemHeight = itemHeight + itemPadding;
        // Calculate the center position for the current year
        final scrollOffset = (currentYearIndex * totalItemHeight) - 100;
        _yearScrollController.jumpTo(scrollOffset.clamp(0.0, double.infinity));
      });
    }
  }

  void _handleMonthSelection(int month) {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, month);
      _isShowingMonthPicker = false;
    });
  }

  void _handleYearSelection(int year) {
    setState(() {
      _currentMonth = DateTime(year, _currentMonth.month);
      _isShowingYearPicker = false;
    });
  }

  Widget _buildNavigationButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return _NavigationButton(
      icon: icon,
      onPressed: onPressed,
    );
  }

  Widget _buildMonthPicker() {
    return Column(
      children: [
        // Title
        Text(
          'Select Month',
          style: TextStyle(
            color: HuxTokens.textPrimary(context),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),

        // Month grid (4x3)
        Column(
          children: [
            Row(
              children: [
                _buildMonthItem(1, 'Jan'),
                const SizedBox(width: 8),
                _buildMonthItem(2, 'Feb'),
                const SizedBox(width: 8),
                _buildMonthItem(3, 'Mar'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildMonthItem(4, 'Apr'),
                const SizedBox(width: 8),
                _buildMonthItem(5, 'May'),
                const SizedBox(width: 8),
                _buildMonthItem(6, 'Jun'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildMonthItem(7, 'Jul'),
                const SizedBox(width: 8),
                _buildMonthItem(8, 'Aug'),
                const SizedBox(width: 8),
                _buildMonthItem(9, 'Sep'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildMonthItem(10, 'Oct'),
                const SizedBox(width: 8),
                _buildMonthItem(11, 'Nov'),
                const SizedBox(width: 8),
                _buildMonthItem(12, 'Dec'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildYearPicker() {
    final years = List.generate(
      2050 - 1900 + 1,
      (index) => 1900 + index,
    );

    return Column(
      children: [
        // Title
        Text(
          'Select Year',
          style: TextStyle(
            color: HuxTokens.textPrimary(context),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),

        // Year list - same height as calendar
        SizedBox(
          height: 4 * 32 +
              24, // Same height as calendar grid (weekday headers + 4 rows + gaps)
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              scrollbars: false,
            ),
            child: ListView.builder(
              controller: _yearScrollController,
              physics: const ClampingScrollPhysics(),
              itemCount: years.length,
              itemBuilder: (context, index) {
                final year = years[index];
                final isSelected = year == _currentMonth.year;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: HuxButton(
                    onPressed: () => _handleYearSelection(year),
                    variant: isSelected
                        ? HuxButtonVariant.primary
                        : HuxButtonVariant.outline,
                    size: HuxButtonSize.small,
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          year.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMonthItem(int month, String label) {
    final isSelected = month == _currentMonth.month;

    // Calculate width to fit 3 columns with 8px gaps
    // Total container width: 7 * 32 + 6 = 230px
    // 3 items + 2 gaps (8px each) = 3 * item_width + 16 = 230
    // 3 * item_width = 214
    // item_width = 71.33...
    const double itemWidth = (7 * 32 + 6 - (2 * 8)) / 3;

    return SizedBox(
      width: itemWidth,
      child: HuxButton(
        onPressed: () => _handleMonthSelection(month),
        variant:
            isSelected ? HuxButtonVariant.primary : HuxButtonVariant.outline,
        size: HuxButtonSize.small,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    return Column(
      children: [
        // Weekday headers (Monday first)
        Row(
          children: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su']
              .map(
                (day) => SizedBox(
                  width: 32,
                  child: Center(
                    child: Text(
                      day,
                      style: TextStyle(
                        color: HuxTokens.textSecondary(context),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 16),

        // Calendar grid
        ..._buildCalendarRows(),
      ],
    );
  }

  Widget _buildDayCell({
    required int day,
    required bool isCurrentMonth,
    required bool isSelected,
    required bool isToday,
    required bool isDisabled,
    VoidCallback? onTap,
  }) {
    return _DayCell(
      day: day,
      isCurrentMonth: isCurrentMonth,
      isSelected: isSelected,
      isToday: isToday,
      isDisabled: isDisabled,
      onTap: onTap,
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  List<Widget> _buildCalendarRows() {
    final daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    final firstDayOfMonth =
        DateTime(_currentMonth.year, _currentMonth.month, 1);
    final firstWeekday = firstDayOfMonth.weekday;

    // Calculate days from previous month to show (Monday = 1, Sunday = 7)
    final daysFromPrevMonth = (firstWeekday - 1) % 7;
    final prevMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    final daysInPrevMonth =
        DateTime(prevMonth.year, prevMonth.month + 1, 0).day;

    final List<Widget> rows = [];

    // Calculate how many weeks we need
    final totalDaysToShow = daysFromPrevMonth + daysInMonth;
    final numberOfWeeks = (totalDaysToShow / 7).ceil();

    for (int weekIndex = 0; weekIndex < numberOfWeeks; weekIndex++) {
      bool hasCurrentMonthDay = false;

      // Check if this row has any days from the current month
      for (int dayIndex = 0; dayIndex < 7; dayIndex++) {
        final dayNumber = weekIndex * 7 + dayIndex - daysFromPrevMonth + 1;
        if (dayNumber > 0 && dayNumber <= daysInMonth) {
          hasCurrentMonthDay = true;
          break;
        }
      }

      // Only add the row if it contains at least one day from the current month
      if (hasCurrentMonthDay) {
        rows.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: List.generate(7, (dayIndex) {
                final dayNumber =
                    weekIndex * 7 + dayIndex - daysFromPrevMonth + 1;
                final isPrevMonth = dayNumber <= 0;
                final isNextMonth = dayNumber > daysInMonth;

                if (isPrevMonth) {
                  final prevMonthDay = daysInPrevMonth + dayNumber;
                  return SizedBox(
                    width: 32,
                    child: _buildDayCell(
                      day: prevMonthDay,
                      isCurrentMonth: false,
                      isSelected: false,
                      isToday: false,
                      isDisabled: true,
                    ),
                  );
                } else if (isNextMonth) {
                  final nextMonthDay = dayNumber - daysInMonth;
                  return SizedBox(
                    width: 32,
                    child: _buildDayCell(
                      day: nextMonthDay,
                      isCurrentMonth: false,
                      isSelected: false,
                      isToday: false,
                      isDisabled: true,
                    ),
                  );
                } else {
                  final date = DateTime(
                      _currentMonth.year, _currentMonth.month, dayNumber);
                  final isSelected = date.year == _selectedDate.year &&
                      date.month == _selectedDate.month &&
                      date.day == _selectedDate.day;
                  final isToday = date.year == DateTime.now().year &&
                      date.month == DateTime.now().month &&
                      date.day == DateTime.now().day;
                  final isDisabled = date.isBefore(widget.firstDate) ||
                      date.isAfter(widget.lastDate);

                  return SizedBox(
                    width: 32,
                    child: _buildDayCell(
                      day: dayNumber,
                      isCurrentMonth: true,
                      isSelected: isSelected,
                      isToday: isToday,
                      isDisabled: isDisabled,
                      onTap: isDisabled ? null : () => _selectDate(date),
                    ),
                  );
                }
              }),
            ),
          ),
        );
      }
    }

    return rows;
  }
}

/// Individual day cell widget with hover states
class _DayCell extends StatefulWidget {
  const _DayCell({
    required this.day,
    required this.isCurrentMonth,
    required this.isSelected,
    required this.isToday,
    required this.isDisabled,
    this.onTap,
  });

  final int day;
  final bool isCurrentMonth;
  final bool isSelected;
  final bool isToday;
  final bool isDisabled;
  final VoidCallback? onTap;

  @override
  State<_DayCell> createState() => _DayCellState();
}

class _DayCellState extends State<_DayCell> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.isDisabled
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 32,
          height: 32,
          margin: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
            borderRadius: BorderRadius.circular(8),
            border: _getBorder(),
          ),
          child: Center(
            child: Text(
              widget.day.toString(),
              style: TextStyle(
                color: _getTextColor(),
                fontSize: 14,
                fontWeight: widget.isSelected || widget.isToday
                    ? FontWeight.w600
                    : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (widget.isDisabled) {
      return Colors.transparent;
    }

    if (widget.isSelected) {
      return HuxTokens.primary(context);
    }

    if (_isPressed) {
      return HuxTokens.surfaceHover(context);
    }

    if (_isHovered && !widget.isSelected) {
      return HuxTokens.surfaceHover(context);
    }

    if (widget.isToday) {
      return HuxTokens.primary(context).withValues(alpha: 0.1);
    }

    return Colors.transparent;
  }

  Color _getTextColor() {
    if (widget.isDisabled) {
      return HuxTokens.textDisabled(context);
    }

    if (widget.isSelected) {
      return HuxTokens.textInvert(context);
    }

    if (widget.isToday) {
      return HuxTokens.primary(context);
    }

    if (widget.isCurrentMonth) {
      return HuxTokens.textPrimary(context);
    }

    return HuxTokens.textSecondary(context);
  }

  Border? _getBorder() {
    if (widget.isToday && !widget.isSelected) {
      return Border.all(
        color: HuxTokens.primary(context),
        width: 1,
      );
    }
    return null;
  }
}

/// Navigation button with Hux button styling
class _NavigationButton extends StatefulWidget {
  const _NavigationButton({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  State<_NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<_NavigationButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(
              widget.icon,
              size: 18,
              color: _getIconColor(),
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (_isPressed) {
      return HuxTokens.surfaceHover(context);
    }

    if (_isHovered) {
      return HuxTokens.surfaceHover(context);
    }

    return HuxTokens.surfacePrimary(context);
  }

  Color _getIconColor() {
    return HuxTokens.textPrimary(context);
  }
}
