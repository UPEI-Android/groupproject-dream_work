import 'package:flutter/material.dart';
import '../screens/screens.dart';

/// A fixed possition hover navigation bar contains a [buttonHolder].
class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // size of the screen
    return Positioned(
      bottom: 0.03 * size.height,
      child: SizedBox(
        width: size.width / 2.5,
        height: 57,
        child: buttonHolder(),
      ),
    );
  }
}

/// A container hold the [homeButton], [teamButton] and [calendarButton].
Widget buttonHolder() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.deepPurpleAccent,
      borderRadius: const BorderRadius.all(
        Radius.circular(50),
      ),
      border: Border.all(
        color: Colors.black,
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.4),
          blurRadius: 7,
          spreadRadius: 5,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: ButtonBar(
      alignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      buttonHeight: 8,
      buttonPadding: const EdgeInsets.all(0.1),
      children: [
        navButton(const Icon(Icons.home)),
        navButton(const Icon(Icons.group)),
        navButton(const Icon(Icons.calendar_today)),
      ],
    ),
  );
}

/// A button that navigates to the [HomeScreen].
Widget navButton(Icon icon) => IconButton(
      icon: icon,
      color: const Color.fromARGB(255, 0, 255, 229),
      onPressed: () {},
    );
