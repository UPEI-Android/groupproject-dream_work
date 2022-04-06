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

/// translate month and day to string
String monthAndDayToString() =>
    '${monthToString()} ${DateTime.now().day.toString()}';

/// translate month to string
/// by default return current month
String monthToString([int monthsAgo = 0]) =>
    Month.values[DateTime.now().month - 1 - monthsAgo]
        .toString()
        .split('.')
        .last;

/// find number of tasks in each day
/// return a List<dynamic> with format:
List<int> numberOfTasksInEachDay(List<Map<String, dynamic>> soruceData) {
  final today = DateTime.now();
  return soruceData
      .map(
        (e) => -daysBetween(today, DateTime.parse(e['created_at'])),
      )
      .toList();
}

/// calculate the number of date between two dates
int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}
