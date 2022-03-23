import 'package:flutter/material.dart';
import 'widgets.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // demo
        for (int i = 0; i < 20; i++) const TodoTag(),
      ],
    );
  }
}
