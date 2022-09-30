extension DateTimeExtension on DateTime {
  DateTime toDate() {
    return DateTime(year, month, day);
  }

  bool isToday(){
    final today = DateTime.now();
    return today.day == day && today.month == month && today.year == year;
  }
}
