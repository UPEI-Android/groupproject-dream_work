import '../dream_connector/dreamConnector.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../utils/utils.dart';

class IndividualScreen extends StatefulWidget {
  const IndividualScreen({
    Key? key,
  }) : super(key: key);
  static const routeName = '/individual';

  @override
  State<IndividualScreen> createState() => _IndividualScreenState();
}

class _IndividualScreenState extends State<IndividualScreen> {
  late String section;
  @override
  Widget build(BuildContext context) {
    section = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: _appBar(),
      body: todoList(),
    );
  }

  PreferredSizeWidget _appBar() => AppBar(
        title: Text(
          section,
          style: const TextStyle(fontSize: 25),
        ),
        elevation: 12,
        actions: [
          StreamBuilder(
            stream: DreamDatabase.instance.isLoading,
            builder: (context, snap) {
              return AddButton(
                isLoading: snap.data as bool,
                onPressed: () {
                  createIndividualItem(section: section);
                },
              );
            },
          )
        ],
      );

  Widget todoList() => StreamBuilder(
        stream: DreamDatabase.instance.allItem,
        builder: (BuildContext context, AsyncSnapshot snap) {
          List<dynamic> list = [];
          if (snap.data != null) {
            list = snap.data
                .where((element) => element['section'] == section)
                .toList();
          }

          return snap.data != null
              ? ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) => TodoTag(
                    prop: list[index],
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
