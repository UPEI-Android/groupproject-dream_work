import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  const Tag(
      {Key? key,
      required this.title,
      required this.isDone,
      this.height = 50,
      this.padding = const EdgeInsets.only(left: 30, right: 30, top: 12),
      this.isEditable = true,
      this.widget,
      this.callBack,
      t})
      : super(key: key);

  final EdgeInsetsGeometry padding;
  final String title;
  final bool isDone;
  final bool isEditable;
  final double height;
  final Widget? widget;
  final Function? callBack;

  @override
  Widget build(BuildContext context) {
    /// Body of the tax
    return Padding(
      padding: padding,
      child: Container(
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
        child: _infoBox(),
      ),
    );
  }

  ///---------------------------------------------------------------------------
  /// contains all the info of the tag
  ///---------------------------------------------------------------------------
  Widget _infoBox() {
    final String titleAdj =
        title.length < 13 ? title : title.substring(0, 13) + '...';
    return isEditable
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _checkBox(
                isDone: isDone,
              ),
              Expanded(
                child: _editableText(title: titleAdj),
              ),
              widget ?? Container(),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text(
                  titleAdj,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              widget ?? Container(),
            ],
          );
  }

  ///----------------------------------------------------------------------------
  /// This is the editable content of the tag
  ///----------------------------------------------------------------------------
  Widget _editableText({
    String? title,
  }) =>
      TextField(
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: title ?? 'new task',
          border: InputBorder.none,
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
        ),
      );

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
}
