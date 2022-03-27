import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  const Tag({
    Key? key,
    required this.title,
    required this.isDone,
    this.margin = const EdgeInsets.all(3),
    this.height = 50,
  }) : super(key: key);

  final String title;
  final bool isDone;
  final EdgeInsetsGeometry margin;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color.fromARGB(255, 16, 28, 65),
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
  }
}

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
