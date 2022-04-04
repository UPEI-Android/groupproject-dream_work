import 'package:flutter/material.dart';

class Progerss extends StatelessWidget {
  const Progerss({Key? key, this.precent = 0}) : super(key: key);
  final double precent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      height: 25,
      decoration: BoxDecoration(
        //color: Colors.black,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < 10; i++) progressIcon(precent > i),
        ],
      ),
    );
  }
}

Widget progressIcon(bool isDone) => Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        width: 5,
        height: 25,
        decoration: BoxDecoration(
          color: isDone ? Colors.green : Colors.black,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
