import 'package:flutter/material.dart';

extension DateTimeExtension on DateTime {
  DateTime toStartDate() {
    return DateTime(year, month, day);
  }

  DateTime toEndDate() {
    return DateTime(year, month, day, 23, 59, 59, 99);
  }

  DateTime setCurrentTime() {
    final today = DateTime.now();
    return DateTime(
      year,
      month,
      day,
      today.hour,
      today.minute,
      today.second,
      today.millisecond,
    );
  }

  bool isToday() {
    final today = DateTime.now();
    return today.day == day && today.month == month && today.year == year;
  }

  DateTime get nextMonth => DateTime(year, month + 1, day);
  DateTime get prevMonth => DateTime(year, month - 1, day);
  DateTime get nextWeek => add(const Duration(days: 7));
  DateTime get prevWeek => subtract(const Duration(days: 7));

  DateTime startOfWeek() => subtract(Duration(days: weekday - 1)).toStartDate();
  DateTime endOfWeek() =>
      add(Duration(days: DateTime.daysPerWeek - weekday)).toEndDate();

  DateTime firstDayOfMonth() => DateTime(year, month, 1);
  DateTime lastDayOfMonth() => DateTime(
        year,
        month + 1,
      ).subtract(const Duration(days: 1)).toEndDate();

  List<DateTimeRange> getWeeksOfMonth() {
    List<DateTimeRange> dateRange = [];
    DateTime week = firstDayOfMonth();
    final thisMonth = month;
    while (week.month == thisMonth) {
      DateTime startOfWeek = week.startOfWeek();
      DateTime endOfWeek = week.endOfWeek();
      if (startOfWeek.month != thisMonth) {
        startOfWeek = firstDayOfMonth();
      }
      if (endOfWeek.month != thisMonth) {
        endOfWeek = lastDayOfMonth();
      }
      DateTimeRange date = DateTimeRange(start: startOfWeek, end: endOfWeek);
      dateRange.add(date);
      week = endOfWeek.add(const Duration(days: 1));
    }
    return dateRange;
  }

  int get weekNumber {
    final weeksOfMonth = getWeeksOfMonth();
    for (int i = 0; i < weeksOfMonth.length; i++) {
      if (weeksOfMonth[i].start.isBefore(this) &&
          weeksOfMonth[i].end.isAfter(this)) {
        return i;
      }
    }
    return 0;
  }
}
