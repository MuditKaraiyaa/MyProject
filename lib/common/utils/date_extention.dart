extension XDateTime on DateTime {
  /// Returns true if the input date is the same date as this DateTime instance.
  bool isSameDate(DateTime inputDate) {
    return year == inputDate.year && month == inputDate.month && day == inputDate.day;
  }
}
