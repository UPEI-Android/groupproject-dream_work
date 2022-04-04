import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  const Tag({
    Key? key,
    required this.title,
    required this.isDone,
    this.margin = const EdgeInsets.all(3),
    this.height = 50,
    this.widget,
  }) : super(key: key);

  final String title;
  final bool isDone;
  final EdgeInsetsGeometry margin;
  final double height;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 28, 41, 83),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              _checkBox(
                isDone: isDone,
              ),
              _title(
                title:
                    title.length < 13 ? title : title.substring(0, 13) + '...',
              ),
            ],
          ),
          widget ?? Container(),
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
      shape: const CircleBorder(),
      activeColor: Colors.green,
      checkColor: Colors.green,
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
