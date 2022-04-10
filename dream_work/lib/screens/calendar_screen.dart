import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:table_calendar/table_calendar.dart';

import '../dream_connector/dream_database.dart';
import '../router.dart';
import '../utils/date_util.dart';
import '../utils/section_util.dart';
import '../utils/task_util.dart';
import '../widgets/button/add_btn.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  CalendarFormat _format = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay =  DateTime.now();

  @override
  void initState() {
    super.initState();
    initialization();
  }

  Future<void> initialization() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
        padding: const EdgeInsets.only(left: 9.0),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
    Text(
    monthAndDayToString(),
    style: const TextStyle(fontSize: 25),
    ),
        ]
      )
    ),
          actions: [
      IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {
        // todo add a real action for search
      },
    ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  _format = CalendarFormat.month;
                  _selectedDay=_focusedDay ;
                });
              },
            ),
            StreamBuilder(
              stream: DreamDatabase.instance.loadingState,
              builder: (context, AsyncSnapshot snap) {
                return AddButton(
                  isLoading: snap.data ?? true,
                  onPressed: () {
                    createSection();
                  },
                );
              },
            ),
  ]
    ),

      backgroundColor: Colors.greenAccent,
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


      ),
    );
  }


}