import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../../dream_connector/dreamConnector.dart';

class IndividualScreen extends StatelessWidget {
  const IndividualScreen({Key? key}) : super(key: key);

  static const routeName = '/individual';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: const TodoList(),
    );
  }
}

PreferredSizeWidget appBar() => AppBar();

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DreamDatabase.instance.allItem,
      builder: (BuildContext context, AsyncSnapshot snap) {
        return snap.data != null
            ? ListView.builder(
                itemCount: snap.data.length,
                itemBuilder: (context, index) => TodoTag(
                  prop: snap.data[index],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: Colors.greenAccent,
                ),
              );
      },
    );
  }
}

// todo replace this
class DemoItem {
  final String title;
  final bool isDone;
  DemoItem(this.title, this.isDone);
}
