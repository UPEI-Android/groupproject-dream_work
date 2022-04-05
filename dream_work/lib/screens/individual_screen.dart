import 'package:dream_work/screens/screens.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../dream_connector/dream_connector.dart';
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

  /// appbar of the individual screen
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
          // disply the loading state
          StreamBuilder(
            stream: DreamDatabase.instance.loadingState,
            builder: (context, AsyncSnapshot snap) {
              return AddButton(
                isLoading: snap.data ?? true,
                onPressed: () {
                  createTask(section: section);
                },
              );
            },
          ),
        ],
      );

  /// build a list of [TaskTag]
  Widget todoList() => StreamBuilder(
        stream: DreamDatabase.instance.allItem,
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.data == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.greenAccent,
              ),
            );
          }

          List<dynamic> taskList =
              findItemsBySecion(sourceData: snap.data, section: section);
          double finshPrecentage = findFinishPrecentageBySection(
              sourceData: snap.data, section: section);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Tag(
                title: section,
                isDone: false,
                height: 100,
                widget: TaskProgerss(precent: finshPrecentage),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: taskList.length,
                  itemBuilder: (context, index) => TaskTag(
                    prop: taskList[index],
                  ),
                ),
              )
            ],
          );
        },
      );
}

/// cutomized [Tag] for individual screen
class TaskTag extends StatelessWidget {
  const TaskTag({Key? key, this.prop}) : super(key: key);
  final dynamic prop;

  @override
  Widget build(BuildContext context) {
    return Slidable(
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
      ),
    );
  }
}
