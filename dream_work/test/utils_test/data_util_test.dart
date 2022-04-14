import 'package:flutter_test/flutter_test.dart';
import '../../lib/utils/date_util.dart';

void main() {
  /// test daysBetween util
  test('test days between two date', () {
    DateTime start = DateTime.parse('2020-01-01');
    DateTime end = DateTime.parse('2020-01-03');
    expect(daysBetween(start, end), 2);
  });

  test('test days between created_at date to today', () {
    DateTime today = DateTime.now();
    List<Map<String, dynamic>> soruceData = [
      {
        'created_at': today.toString(),
      },
      {
        'created_at': today.toString(),
      },
      {
        'created_at': today.toString(),
      }
    ];
    expect(numberOfTasksInEachDay(soruceData), [0, 0, 0]);
  });

  test('Convert current month to formate String', () {
    expect(monthToString(), 'April');
  });
}
