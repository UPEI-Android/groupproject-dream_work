import 'package:flutter/material.dart';

class TaskProgerss extends StatelessWidget {
  const TaskProgerss({Key? key, this.precent = 0}) : super(key: key);
  final double precent;

  @override
  Widget build(BuildContext context) {
    final double decPrecent = precent * 10;
    return Container(
      width: 125,
      height: 29,
      decoration: BoxDecoration(
        //color: Colors.black,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < 10; i++) _block(decPrecent > i),
        ],
      ),
    );
  }
}

Widget _block(bool isDone) => Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        width: 5,
        decoration: BoxDecoration(
          color: isDone ? Colors.green : Colors.black,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
