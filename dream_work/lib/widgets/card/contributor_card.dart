import 'package:flutter/material.dart';
import '../widgets.dart';

class Contributors extends StatelessWidget {
  const Contributors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GeneralCard(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < 10; i++) _block(0),
        ],
      ),
    );
  }

  Widget _block(double level) => Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: level == 0 ? Colors.black : Colors.green.withOpacity(level),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      );
}
