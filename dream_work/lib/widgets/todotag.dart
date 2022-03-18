import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTag extends StatelessWidget {
  const TodoTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 6),
      child: Slidable(
        startActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // A pane can dismiss the Slidable.
          //dismissible: DismissiblePane(onDismissed: () {}),

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: const Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.share,
              label: 'Share',
            ),
          ],
        ),
        child: Container(
          height: 50,
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}
