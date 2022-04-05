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
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay =  DateTime.now();

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
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },

        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay; // show all todos for that day
          });

        },

        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },

        eventLoader: (day) {
          return _getTODOsForDay(day); //TODO get the task the person has to do for that day
        },
      ),
    );
  }
}