import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // size of the screen
    return Positioned(
      bottom: 0.03 * size.height,
      child: SizedBox(
        width: size.width / 2,
        child: buttonHolder(),
      ),
    );
  }
}

Widget buttonHolder() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(
        Radius.circular(50),
      ),
      border: Border.all(
        color: Colors.black,
        width: 1.5,
      ),
      backgroundBlendMode: BlendMode.darken,
    ),
    child: ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        calendarButton(),
        homeButton(),
        teamButton(),
      ],
    ),
  );
}

Widget homeButton() {
  return IconButton(
    icon: const Icon(Icons.home),
    iconSize: 32,
    onPressed: () {},
  );
}

Widget calendarButton() {
  return IconButton(
    icon: const Icon(Icons.calendar_today),
    iconSize: 32,
    onPressed: () {},
  );
}

Widget teamButton() {
  return IconButton(
    icon: const Icon(Icons.group),
    iconSize: 32,
    onPressed: () {},
  );
}
