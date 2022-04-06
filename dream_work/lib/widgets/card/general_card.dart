import 'package:flutter/material.dart';

class GeneralCard extends StatelessWidget {
  const GeneralCard({
    Key? key,
    this.height,
    this.padding = const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
    this.child,
    this.onTap,
    this.backgroundColor = const Color.fromARGB(255, 28, 41, 83),
  }) : super(key: key);

  final double? height;
  final Widget? child;
  final Function? onTap;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Padding(
        padding: padding,
        child: _card(child: child ?? Container()),
      ),
    );
  }

  Widget _card({required Widget child}) => Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: child,
      );
}
