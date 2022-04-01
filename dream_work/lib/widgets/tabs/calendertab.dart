import 'package:flutter/material.dart';

class CalenderTab extends StatelessWidget {
  const CalenderTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Icon(Icons.calendar_month, size: 64.0, color: Colors.green));
  }
}
