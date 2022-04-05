import 'package:flutter/material.dart';
import '../../screens/screens.dart';

///----------------------------------------------------------------------------
/// A custom navigation bar
///----------------------------------------------------------------------------
class NavBar extends StatelessWidget {
  const NavBar({
    Key? key,
    required this.tabController,
    this.prop,
  }) : super(key: key);
  final TabController tabController;
  final prop; // todo

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // size of the screen
    return Positioned(
      bottom: 0.035 * size.height,
      child: SizedBox(
        width: 160,
        height: 70,
        child: _buttonHolder(tabController: tabController),
      ),
    );
  }
}

/// A container hold the [homeButton], [teamButton] and [calendarButton].
Widget _buttonHolder({required TabController tabController}) => Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 15, 26, 60),
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
        border: Border.all(
          color: Colors.black,
          width: 0.3,
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
          _navButton(
            icon: const Icon(Icons.group),
            index: 0,
            tabController: tabController,
          ),
          _navButton(
            icon: const Icon(Icons.calendar_month),
            index: 1,
            tabController: tabController,
          ),
          _navButton(
              icon: const Icon(Icons.home),
              index: 2,
              tabController: tabController),
        ],
      ),
    );

/// A button that navigates to the [HomeScreen].
Widget _navButton({
  required Icon icon,
  required int index,
  required TabController tabController,
}) =>
    IconButton(
      icon: icon,
      iconSize: 29,
      color: Colors.green,
      onPressed: () {
        tabController.animateTo(index);
      },
    );
