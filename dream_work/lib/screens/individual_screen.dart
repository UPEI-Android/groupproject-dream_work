import 'package:dream_work/screens/screens.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
        elevation: 12,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Warining'),
                  content: const Text('Are You sure you want to delete?'),
                  actions: [
                    TextButton(
                      child: const Text('Yes'),
                      onPressed: () async {
                        await DreamDatabase.instance.deleteAll();
                        Navigator.pushNamed(context, HomeScreen.routeName);
                      },
                    ),
                    TextButton(
                      child: const Text('No'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
          StreamBuilder(
            stream: DreamDatabase.instance.isLoading,
            builder: (context, AsyncSnapshot snap) {
              return AddButton(
                isLoading: snap.data ?? true,
                onPressed: () {
                  createIndividualItem(section: section);
                },
              );
            },
          ),
        ],
      );

  Widget todoList() => StreamBuilder(
        stream: DreamDatabase.instance.allItem,
        builder: (BuildContext context, AsyncSnapshot snap) {
          List<dynamic> list = [];
          double finshPrecentage = 0;

          if (snap.data != null) {
            list = snap.data.where((e) => e['section'] == section).toList();
            finshPrecentage = snap.data
                    .where((element) => element['section'] == section)
                    .map((element) => element['isDone'].toString())
                    .toList()
                    .where((element) => element == 'true')
                    .length /
                snap.data
                    .where((element) => element['section'] == section)
                    .length;
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Tag(
                title: section,
                isDone: false,
                height: 100,
                widget: Progerss(precent: finshPrecentage),
              ),
              snap.data != null
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) => TodoTag(
                          prop: list[index],
                        ),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: Colors.greenAccent,
                      ),
                    ),
            ],
          );
        },
      );
}

class TodoTag extends StatelessWidget {
  const TodoTag({Key? key, this.prop}) : super(key: key);
  final prop; //TODO give this a type

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 6),
      child: Slidable(
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  // todo add a real action
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
              SlidableAction(
                onPressed: (context) {
                  // todo add a real action
                },
                backgroundColor: const Color(0xFF21B7CA),
                foregroundColor: Colors.white,
                icon: Icons.share,
                label: 'Share',
              ),
            ],
          ),
          child: Tag(
            title: prop['tid'],
            isDone: prop['isDone'],
          )),
    );
  }
}
