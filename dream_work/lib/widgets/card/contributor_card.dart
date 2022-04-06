import 'dart:math';

import 'package:dream_work/dream_connector/dream_connector.dart';
import 'package:flutter/material.dart';
import '../widgets.dart';
import '../../utils/utils.dart';

class Contributors extends StatelessWidget {
  const Contributors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GeneralCard(
      height: 220,
      backgroundColor: Colors.black,
      child: Stack(
        children: [
          _monthText(0),
          _monthText(1),
          _monthText(2),
          StreamBuilder(
            stream: DreamDatabase.instance.allItem,
            builder: (context, AsyncSnapshot snap) {
              if (snap.data == null) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.greenAccent,
                  ),
                );
              }

              // find numeber of tasks in each day
              List<int> data = numberOfTasksInEachDay(snap.data);
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 12; i++)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (int j = 0; j < 7; j++)
                          _block(
                            taskNum: data
                                .where((element) => element == 7 * i + j)
                                .length,
                          ),
                      ],
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _monthText(int mountAgo) => Positioned(
        top: 25,
        left: mountAgo * 105,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            monthToString(mountAgo).substring(0, 3),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      );

  Widget _block({required int taskNum}) {
    var color = Colors.grey.withOpacity(0.33);
    if (taskNum > 10) {
      color = Colors.green.withOpacity(1.0);
    } else if (taskNum > 5) {
      color = Colors.green.withOpacity(0.7);
    } else if (taskNum > 2) {
      color = Colors.green.withOpacity(0.4);
    } else if (taskNum > 0) {
      color = Colors.green.withOpacity(0.2);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.7, vertical: 3.5),
      child: Container(
        width: 17,
        height: 17,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4.5),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, 3),
            ),
          ],
        ),
      ),
    );
  }
}
