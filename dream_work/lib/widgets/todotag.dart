import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'widgets.dart';

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
