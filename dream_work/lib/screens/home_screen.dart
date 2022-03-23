import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // size of the screen
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SizedBox(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: const [
            TodoList(),
            NavBar(),
          ],
        ),
      ),
    );
  }
}
