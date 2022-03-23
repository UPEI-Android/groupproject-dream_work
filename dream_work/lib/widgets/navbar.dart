import 'package:flutter/material.dart';
import '../screens/screens.dart';

///----------------------------------------------------------------------------
/// A custom navigation bar
///----------------------------------------------------------------------------
class NavBar extends StatelessWidget {
  const NavBar({Key? key, required this.tabController}) : super(key: key);
  final TabController tabController;

  /// A button that navigates to the [HomeScreen].
  Widget navButton({required Icon icon, required int index}) => IconButton(
        icon: icon,
        color: const Color.fromARGB(255, 0, 255, 229),
        onPressed: () {
          tabController.animateTo(index);
        },
      );

  /// A container hold the [homeButton], [teamButton] and [calendarButton].
  Widget buttonHolder() => Container(
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
            navButton(icon: const Icon(Icons.group), index: 1),
            navButton(icon: const Icon(Icons.home), index: 0),
            navButton(icon: const Icon(Icons.calendar_today), index: 2),
          ],
        ),
      );

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
