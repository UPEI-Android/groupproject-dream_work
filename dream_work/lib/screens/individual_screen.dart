import 'dart:math';

import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../../dream_connector/dreamConnector.dart';

class IndividualScreen extends StatefulWidget {
  const IndividualScreen({
    Key? key,
    this.individualTitle,
  }) : super(key: key);

  final String? individualTitle;
  static const routeName = '/individual';

  @override
  State<IndividualScreen> createState() => _IndividualScreenState();
}

class _IndividualScreenState extends State<IndividualScreen> {
  bool _isLoading = false;

  void setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: const TodoList(),
    );
  }

  PreferredSizeWidget _appBar() => AppBar(
        title: const Text(
          'demo',
          style: TextStyle(fontSize: 25),
        ),
        elevation: 12,
        actions: [
          _isLoading
              ? const CircularProgressIndicator()
              : IconButton(
                  icon: const Icon(Icons.add),
                  color: Colors.yellow,
                  onPressed: () {
                    _createIndividualItem();
                  },
                ),
        ],
      );

  /// create a new individual todo item
  void _createIndividualItem() async {
    // get a random number
    final Map<String, dynamic> map = {
      "tid": (DateTime.now().millisecondsSinceEpoch).toString(),
      "members": "demo",
      "section": 'demo',
      "isDone": false,
      "updated_by": "test",
      "updated_at": "undefined",
      "created_at": "undefined",
      "due_at": "test",
      "content": "test"
    };

    setLoading(true);
    await DreamDatabase.instance.writeOne(map);
    setLoading(false);
  }
}

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
