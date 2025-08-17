import 'package:flutter/material.dart';
import '../theme/hux_tokens.dart';
import '../components/buttons/hux_button.dart';

/// Inline dropdown date picker anchored to a trigger button.
///
/// Renders a Hux-styled button; on press, shows an overlayed calendar panel
/// positioned relative to the button (below by default, flips above if needed).
class HuxDatePicker extends StatefulWidget {
  /// Creates a Hux date picker dropdown anchored to the trigger button.
  const HuxDatePicker(
      {super.key,
      this.initialDate,
      required this.firstDate,
      required this.lastDate,
      this.onDateChanged,
      this.placeholder,
      this.variant = HuxButtonVariant.outline,
      this.size = HuxButtonSize.medium,
      this.icon,
      this.primaryColor,
      this.overlayColor,
      this.showText = true});

  /// The initially selected date. If null, the button shows [placeholder].
  final DateTime? initialDate;

  /// The earliest selectable date in the dropdown calendar.
  final DateTime firstDate;

  /// The latest selectable date in the dropdown calendar.
  final DateTime lastDate;

  /// Called when the user selects a date from the dropdown panel.
  final ValueChanged<DateTime>? onDateChanged;

  /// Button label to render when [initialDate] is null.
  final String? placeholder;

  /// Visual style of the trigger button.
  final HuxButtonVariant variant;

  /// Size of the trigger button.
  final HuxButtonSize size;

  /// Optional leading icon for the trigger button.
  final IconData? icon;

  /// Optional primary color override for the trigger button.
  final Color? primaryColor;

  /// Optional color for DatePicker Overlay
  final Color? overlayColor;

  /// Whether to show text label (default: true). Set to false for icon-only version.
  final bool showText;

  @override
  State<HuxDatePicker> createState() => _HuxDatePickerState();
}

class _HuxDatePickerState extends State<HuxDatePicker> {
  final GlobalKey _buttonKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  late DateTime _currentDate;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _currentDate = widget.initialDate ?? DateTime.now();
  }

  @override
  void didUpdateWidget(covariant HuxDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDate != oldWidget.initialDate &&
        widget.initialDate != null) {
      _currentDate = widget.initialDate!;
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _toggleOverlay() {
    if (_overlayEntry == null) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  void _showOverlay() {
    final RenderBox buttonBox =
        _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final Size buttonSize = buttonBox.size;
    final Size screenSize = MediaQuery.of(context).size;

    const double panelHeight = 318.0; // Slightly more to account for variation
    const double belowGap = 4.0; // Small gap below button
    const double aboveGap =
        4.0; // Smaller gap above button for closer positioning

    bool showAbove = false;
    Offset followerOffset = Offset(0, buttonSize.height + belowGap);
    final double buttonGlobalDy = buttonBox.localToGlobal(Offset.zero).dy;

    final double spaceBelow =
        screenSize.height - (buttonGlobalDy + buttonSize.height);
    if (spaceBelow < panelHeight + belowGap + 20) {
      // 20px buffer
      showAbove = true;
      followerOffset = Offset(0, -panelHeight - aboveGap);
    }

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _removeOverlay,
                child: const SizedBox.shrink(),
              ),
            ),
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: followerOffset,
              child: Material(
                color: widget.overlayColor,
                child: _HuxDatePickerPanel(
                  initialDate: _currentDate,
                  firstDate: widget.firstDate,
                  lastDate: widget.lastDate,
                  onSelected: (date) {
                    setState(() => _currentDate = date);
                    widget.onDateChanged?.call(date);
                    _removeOverlay();
                  },
                  isAbove: showAbove,
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context, rootOverlay: false).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  String _formatDate(BuildContext context, DateTime date) {
    return MaterialLocalizations.of(context).formatMediumDate(date);
  }

  @override
  Widget build(BuildContext context) {
    final String label = widget.initialDate == null
        ? (widget.placeholder ?? 'Select Date')
        : _formatDate(context, _currentDate);

    // Use ghost variant (no border, no background, no padding) for icon-only mode
    final buttonVariant =
        widget.showText ? widget.variant : HuxButtonVariant.ghost;

    return CompositedTransformTarget(
      link: _layerLink,
      child: HuxButton(
        key: _buttonKey,
        onPressed: _toggleOverlay,
        variant: buttonVariant,
        size: widget.size,
        primaryColor: widget.primaryColor,
        icon: widget.icon ?? Icons.calendar_today,
        child: widget.showText ? Text(label) : const SizedBox(width: 0),
      ),
    );
  }
}

class _HuxDatePickerPanel extends StatefulWidget {
  const _HuxDatePickerPanel({
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onSelected,
    this.isAbove = false,
  });

  /// Date used to initialize the panel selection and month view.
  final DateTime initialDate;

  /// Lower bound for selectable dates.
  final DateTime firstDate;

  /// Upper bound for selectable dates.
  final DateTime lastDate;

  /// Callback invoked when a date is chosen from the panel.
  final ValueChanged<DateTime> onSelected;

  /// Whether the panel is rendered above the trigger (for limited space below).
  final bool isAbove;

  @override
  State<_HuxDatePickerPanel> createState() => _HuxDatePickerPanelState();
}

class _HuxDatePickerPanelState extends State<_HuxDatePickerPanel> {
  late DateTime _selectedDate;
  late DateTime _currentMonth;
  bool _isShowingMonthPicker = false;
  bool _isShowingYearPicker = false;
  late ScrollController _yearScrollController;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    final int defaultYear =
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

  void _handleSelect(DateTime date) {
    setState(() => _selectedDate = date);
    widget.onSelected(date);
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
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: HuxTokens.surfaceElevated(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HuxTokens.buttonSecondaryBorder(context)),
        boxShadow: [
          BoxShadow(
            color: HuxTokens.shadowColor(context),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 7 * 32 + 6, child: _buildHeader()),
          const SizedBox(height: 16),
          if (_isShowingMonthPicker)
            SizedBox(width: 7 * 32 + 6, child: _buildMonthPicker())
          else if (_isShowingYearPicker)
            SizedBox(width: 7 * 32 + 6, child: _buildYearPicker())
          else
            SizedBox(width: 7 * 32 + 6, child: _buildCalendarGrid()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        _NavigationButton(icon: Icons.chevron_left, onPressed: _previousMonth),
        const SizedBox(width: 12),
        Expanded(child: _buildMonthButton()),
        const SizedBox(width: 8),
        Expanded(child: _buildYearButton()),
        const SizedBox(width: 12),
        _NavigationButton(icon: Icons.chevron_right, onPressed: _nextMonth),
      ],
    );
  }

  Widget _buildMonthButton() {
    return HuxButton(
      onPressed: _toggleMonthPicker,
      variant: HuxButtonVariant.outline,
      size: HuxButtonSize.small,
      child: Text(
        _getMonthName(_currentMonth.month),
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildYearButton() {
    return HuxButton(
      onPressed: _toggleYearPicker,
      variant: HuxButtonVariant.outline,
      size: HuxButtonSize.small,
      child: Text(
        _currentMonth.year.toString(),
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
    if (_isShowingYearPicker) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final int currentYearIndex = _currentMonth.year - 1900;
        const double itemHeight = 36.0;
        const double itemPadding = 4.0;
        const double totalItemHeight = itemHeight + itemPadding;
        final double scrollOffset = (currentYearIndex * totalItemHeight) - 100;
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

  Widget _buildMonthPicker() {
    return Column(
      children: [
        Text(
          'Select Month',
          style: TextStyle(
            color: HuxTokens.textPrimary(context),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            Row(children: [
              _buildMonthItem(1, 'Jan'),
              const SizedBox(width: 8),
              _buildMonthItem(2, 'Feb'),
              const SizedBox(width: 8),
              _buildMonthItem(3, 'Mar'),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              _buildMonthItem(4, 'Apr'),
              const SizedBox(width: 8),
              _buildMonthItem(5, 'May'),
              const SizedBox(width: 8),
              _buildMonthItem(6, 'Jun'),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              _buildMonthItem(7, 'Jul'),
              const SizedBox(width: 8),
              _buildMonthItem(8, 'Aug'),
              const SizedBox(width: 8),
              _buildMonthItem(9, 'Sep'),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              _buildMonthItem(10, 'Oct'),
              const SizedBox(width: 8),
              _buildMonthItem(11, 'Nov'),
              const SizedBox(width: 8),
              _buildMonthItem(12, 'Dec'),
            ]),
          ],
        ),
      ],
    );
  }

  Widget _buildMonthItem(int month, String label) {
    final bool isSelected = month == _currentMonth.month;
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
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget _buildYearPicker() {
    final List<int> years =
        List.generate(2050 - 1900 + 1, (index) => 1900 + index);
    return Column(
      children: [
        Text(
          'Select Year',
          style: TextStyle(
            color: HuxTokens.textPrimary(context),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 4 * 32 + 24,
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView.builder(
              controller: _yearScrollController,
              physics: const ClampingScrollPhysics(),
              itemCount: years.length,
              itemBuilder: (context, index) {
                final int year = years[index];
                final bool isSelected = year == _currentMonth.year;
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
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
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

  Widget _buildCalendarGrid() {
    return Column(
      children: [
        Row(
          children: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su']
              .map((day) => SizedBox(
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
                  ))
              .toList(),
        ),
        const SizedBox(height: 16),
        ..._buildCalendarRows(),
      ],
    );
  }

  List<Widget> _buildCalendarRows() {
    final int daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    final DateTime firstDayOfMonth =
        DateTime(_currentMonth.year, _currentMonth.month, 1);
    final int firstWeekday = firstDayOfMonth.weekday;
    final int daysFromPrevMonth = (firstWeekday - 1) % 7;
    final DateTime prevMonth =
        DateTime(_currentMonth.year, _currentMonth.month - 1);
    final int daysInPrevMonth =
        DateTime(prevMonth.year, prevMonth.month + 1, 0).day;

    final List<Widget> rows = [];
    final int totalDaysToShow = daysFromPrevMonth + daysInMonth;
    final int numberOfWeeks = (totalDaysToShow / 7).ceil();

    for (int weekIndex = 0; weekIndex < numberOfWeeks; weekIndex++) {
      bool hasCurrentMonthDay = false;
      for (int dayIndex = 0; dayIndex < 7; dayIndex++) {
        final int dayNumber = weekIndex * 7 + dayIndex - daysFromPrevMonth + 1;
        if (dayNumber > 0 && dayNumber <= daysInMonth) {
          hasCurrentMonthDay = true;
          break;
        }
      }
      if (hasCurrentMonthDay) {
        rows.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: List.generate(7, (dayIndex) {
                final int dayNumber =
                    weekIndex * 7 + dayIndex - daysFromPrevMonth + 1;
                final bool isPrevMonth = dayNumber <= 0;
                final bool isNextMonth = dayNumber > daysInMonth;
                if (isPrevMonth) {
                  final int prevMonthDay = daysInPrevMonth + dayNumber;
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
                  final int nextMonthDay = dayNumber - daysInMonth;
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
                  final DateTime date = DateTime(
                      _currentMonth.year, _currentMonth.month, dayNumber);
                  final bool isSelected = date.year == _selectedDate.year &&
                      date.month == _selectedDate.month &&
                      date.day == _selectedDate.day;
                  final DateTime now = DateTime.now();
                  final bool isToday = date.year == now.year &&
                      date.month == now.month &&
                      date.day == now.day;
                  final bool isDisabled = date.isBefore(widget.firstDate) ||
                      date.isAfter(widget.lastDate);

                  return SizedBox(
                    width: 32,
                    child: _buildDayCell(
                      day: dayNumber,
                      isCurrentMonth: true,
                      isSelected: isSelected,
                      isToday: isToday,
                      isDisabled: isDisabled,
                      onTap: isDisabled ? null : () => _handleSelect(date),
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
    const List<String> months = [
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
}

/// Individual day cell with hover and pressed visual states.
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
    if (widget.isDisabled) return Colors.transparent;
    if (widget.isSelected) return HuxTokens.primary(context);
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
    if (widget.isDisabled) return HuxTokens.textDisabled(context);
    if (widget.isSelected) return HuxTokens.textInvert(context);
    if (widget.isToday) return HuxTokens.primary(context);
    if (widget.isCurrentMonth) return HuxTokens.textPrimary(context);
    return HuxTokens.textSecondary(context);
  }

  Border? _getBorder() {
    if (widget.isToday && !widget.isSelected) {
      return Border.all(color: HuxTokens.primary(context), width: 1);
    }
    return null;
  }
}

/// Small navigation button used in the calendar header.
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
    if (_isPressed) return HuxTokens.surfaceHover(context);
    if (_isHovered) return HuxTokens.surfaceHover(context);
    return HuxTokens.surfacePrimary(context);
  }

  Color _getIconColor() {
    return HuxTokens.textPrimary(context);
  }
}
