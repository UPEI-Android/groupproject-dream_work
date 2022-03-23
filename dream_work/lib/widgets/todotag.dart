import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
          child: _container(
            title: prop.title,
            isDone: prop.isDone,
          )),
    );
  }
}

///----------------------------------------------------------------------------
/// This is the container for the todo tag.
///----------------------------------------------------------------------------
Widget _container({
  required String title,
  required bool isDone,
}) =>
    Container(
      margin: const EdgeInsets.all(3),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.deepPurpleAccent,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          _checkBox(
            isDone: isDone,
          ),
          _title(
            title: title,
          ),
        ],
      ),
    );

///----------------------------------------------------------------------------
/// This is the checkbox for the todo tag, pass in a bool to set the state.
///----------------------------------------------------------------------------
Widget _checkBox({
  bool isDone = false,
}) =>
    Checkbox(
      value: isDone,
      onChanged: (value) {
        isDone = true;
      },
    );

///----------------------------------------------------------------------------
/// Title Widget of the todo item, with a custom text style
///----------------------------------------------------------------------------
Widget _title({
  String? title,
}) =>
    Text(
      title ?? '',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 17,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.left,
    );
