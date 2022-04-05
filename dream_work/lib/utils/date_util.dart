enum Month {
  January,
  February,
  March,
  April,
  May,
  June,
  July,
  August,
  September,
  October,
  November,
  December
}

String dateToString() =>
    Month.values[DateTime.now().month - 1].toString().split('.').last +
    " " +
    DateTime.now().day.toString();
