import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);
  static const routeName = '/calendar';

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  CalendarFormat _format = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TableCalendar(
        lastDay: DateTime(2050),
        firstDay: DateTime(2000),
        focusedDay: DateTime.now(),
        calendarFormat: _format,
        onFormatChanged: (CalendarFormat format){
          setState(() {
            _format=format;
          });
        },
        startingDayOfWeek: StartingDayOfWeek.monday,


      ),
    );
  }
}