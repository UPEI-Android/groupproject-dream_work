import 'package:dream_work/dream_connector/dream_connector.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:dream_work/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// cutomized card for individual screen
class TaskCard extends StatefulWidget {
  const TaskCard({
    Key? key,
    required this.tid,
    required this.isDone,
    this.height = 45,
    this.content,
    this.child,
  }) : super(key: key);

  final String tid;
  final bool isDone;
  final double height;
  final String? content;
  final Widget? child;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  final TextEditingController _text = TextEditingController();
  bool _isDone = false;

  @override
  void initState() {
    super.initState();
    _isDone = widget.isDone;
  }

  void setIsDone(bool done) {
    setState(() {
      _isDone = done;
    });
  }

  @override
  Widget build(BuildContext context) {
    //setIsDone(widget.isDone);
    _text.text = widget.content ?? 'new task';
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
      child: _card(),
    );
  }

  Widget _card() => GeneralCard(
        height: widget.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _checkBox(),
            Expanded(child: _editableText()),
            widget.child ?? Container(),
          ],
        ),
      );

  ///----------------------------------------------------------------------------
  /// This is the editable content of the tag
  ///----------------------------------------------------------------------------
  Widget _editableText() => TextField(
        controller: _text,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: 'New Task',
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
        onSubmitted: (value) {
          // todo : update the value to the database
          print(value);
        },
      );

  ///----------------------------------------------------------------------------
  /// This is the checkbox for the todo tag, pass in a bool to set the state.
  ///----------------------------------------------------------------------------
  Widget _checkBox() => Checkbox(
        shape: const CircleBorder(),
        activeColor: Colors.green,
        checkColor: Colors.green,
        value: _isDone,
        onChanged: (bool? value) async {
          setIsDone(!_isDone);
          await DreamDatabase.instance.editOne(tid: widget.tid, isDone: value);
        },
      );
}
