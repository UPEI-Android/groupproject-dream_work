import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:table_calendar/table_calendar.dart';
import '../dream_connector/dream_database.dart';
import '../router.dart';
import '../utils/date_util.dart';
import '../utils/section_util.dart';
import '../widgets/card/section_card.dart';
import '../widgets/task_progress.dart';

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
              icon: const Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  _format = CalendarFormat.month;
                  _selectedDay=_focusedDay ;
                });
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
            _focusedDay = focusedDay;


            Alert(
                context: context,
                title: "Tasks Due on $_selectedDay",
                content: StreamBuilder(
                  stream: DreamDatabase.instance.items,
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    if (snap.data == null || snap.hasError) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.greenAccent,
                        ),
                      );
                    }

                    // find unique sections
                    final List<dynamic> sections = findItemsBySection(sourceData: snap.data, section: "due_at");


                    sections.removeWhere((element) => element.due_at != _selectedDay.toString());

                    // find finished percentage for each section
                    final Map<String, double> sectionFinishedPercentage = {};
                    for (final String section in sections) {
                      sectionFinishedPercentage.addEntries(<String, double>{
                        section: findFinishPercentageBySection(
                            section: section, sourceData: snap.data)
                      }.entries);
                    }

                    return ListView.builder(
                      itemCount: sections.length,
                      itemBuilder: (context, index) => SectionCard(
                        title: sections[index],
                        child: TaskProgerss(
                            precent: sectionFinishedPercentage[sections[index]] ?? 0),
                        onTap: () => Navigator.pushNamed(
                          context,
                          Routing.individual,
                          arguments: sections[index],
                        ),
                      ),
                    );
                  },
                ),
                buttons: [
                  DialogButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Okay",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
            ]).show();
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },


      ),
    );
  }


}