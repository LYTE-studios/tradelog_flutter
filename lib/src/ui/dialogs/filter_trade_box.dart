import 'package:flutter/material.dart';

class DarkCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime)? onDateSelected;

  const DarkCalendar({
    super.key,
    required this.selectedDate,
    this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12), // reduced padding
      width: 300, // fixed width
      decoration: BoxDecoration(
        color: const Color(0xFF15161E), // Changed from transparent to #272835
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [], // Removed shadow
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          const SizedBox(height: 16), // reduced spacing
          _buildWeekdayHeader(),
          const SizedBox(height: 8),
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left,
              color: Color(0xFFF5F5F5)), // Lighter color
          onPressed: () {
            // Handle previous month
          },
          style: IconButton.styleFrom(
            backgroundColor: Colors.transparent,
          ),
        ),
        Text(
          '${_getMonthName(selectedDate.month)} ${selectedDate.year}',
          style: const TextStyle(
            color: Color(0xFFF5F5F5), // Lighter color
            fontSize: 16,
            fontWeight: FontWeight.w400, // Lighter weight
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right,
              color: Color(0xFFF5F5F5)), // Lighter color
          onPressed: () {
            // Handle next month
          },
          style: IconButton.styleFrom(
            backgroundColor: Colors.transparent,
          ),
        ),
      ],
    );
  }

  Widget _buildWeekdayHeader() {
    final weekDays = [
      'Sun',
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat'
    ]; // Changed to abbreviated names
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekDays
          .map((day) => SizedBox(
                width:
                    36, // slightly increased width to accommodate longer text
                child: Text(
                  day,
                  style: const TextStyle(
                    color:
                        Color(0xFFCCCCCC), // Lighter grey for weekday headers
                    fontSize: 12,
                    fontWeight: FontWeight.w300, // Lighter weight
                  ),
                  textAlign: TextAlign.center,
                ),
              ))
          .toList(),
    );
  }

  Widget _buildCalendarGrid() {
    final daysInMonth =
        DateTime(selectedDate.year, selectedDate.month + 1, 0).day;
    final firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    final firstWeekday = firstDayOfMonth.weekday;

    // Calculate previous month's days
    final previousMonth = DateTime(selectedDate.year, selectedDate.month, 0);
    final daysInPreviousMonth = previousMonth.day;

    List<Widget> dayWidgets = [];

    // Add previous month's days
    for (int i = 0; i < (firstWeekday == 7 ? 0 : firstWeekday); i++) {
      final day = daysInPreviousMonth - firstWeekday + i + 1;
      dayWidgets.add(
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: Text(
            day.toString(),
            style: const TextStyle(
              color: Color(0xFFE8E8E8), // Lighter color for previous month
              fontSize: 14,
              fontWeight: FontWeight.w300, // Lighter weight
            ),
          ),
        ),
      );
    }

    // Add current month's days
    for (int day = 1; day <= daysInMonth; day++) {
      final isSelected = day == selectedDate.day;
      dayWidgets.add(
        GestureDetector(
          onTap: () {
            onDateSelected?.call(
              DateTime(selectedDate.year, selectedDate.month, day),
            );
          },
          child: Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            // Removed decoration for selected state
            child: Text(
              day.toString(),
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFFFFFFFF) // Pure white for selected date
                    : const Color(
                        0xFFB3B8C3), // Lighter color for current month
                fontSize: 14,
                fontWeight: isSelected
                    ? FontWeight.w500
                    : FontWeight.w300, // Lighter weights
              ),
            ),
          ),
        ),
      );
    }

    // Add next month's days (only fill up to 35 cells - 5 rows)
    int nextMonthDay = 1;
    while (dayWidgets.length < 35) {
      // Changed from 42 to 35 (5 rows × 7 days)
      dayWidgets.add(
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: Text(
            nextMonthDay.toString(),
            style: const TextStyle(
              color: Color(0xFFE8E8E8), // Lighter color for next month
              fontSize: 14,
              fontWeight: FontWeight.w300, // Lighter weight
            ),
          ),
        ),
      );
      nextMonthDay++;
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: dayWidgets.map((widget) {
        return SizedBox(
          width: 32,
          height: 32,
          child: widget,
        );
      }).toList(),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
}
