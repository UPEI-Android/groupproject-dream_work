import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class IndividualScreen extends StatelessWidget {
  const IndividualScreen({Key? key}) : super(key: key);

  static const routeName = '/individual';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.deepPurple,
      body: const TodoList(),
    );
  }
}

PreferredSizeWidget appBar() => AppBar(
      backgroundColor: Colors.deepPurple,
    );

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DemoItem> demoList = List.generate(
        20,
        (index) =>
            DemoItem('demo item $index', false)); // todo add a real stream

    return ListView.builder(
      itemCount: demoList.length,
      itemBuilder: (context, index) => TodoTag(
        prop: demoList[index],
      ),
    );
  }
}

// todo replace this
class DemoItem {
  final String title;
  final bool isDone;
  DemoItem(this.title, this.isDone);
}