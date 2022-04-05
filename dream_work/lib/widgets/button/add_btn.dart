import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    Key? key,
    required this.isLoading,
    required this.onPressed,
  }) : super(key: key);
  final bool isLoading;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Padding(
            padding: EdgeInsets.only(right: 15.0, left: 13.0),
            child: Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.greenAccent,
                  strokeWidth: 3,
                ),
              ),
            ),
          )
        : IconButton(
            icon: const Icon(Icons.add),
            color: Colors.yellow,
            onPressed: () {
              onPressed();
            },
          );
  }
}
