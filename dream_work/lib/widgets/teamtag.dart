import 'package:dream_work/screens/individual_screen.dart';
import 'package:flutter/material.dart';
import 'widgets.dart';
import '../screens/screens.dart';

class TeamTag extends StatelessWidget {
  const TeamTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> demo = List.generate(3, (index) => 'Team Item $index');
    return ListView.builder(
      itemCount: demo.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            IndividualScreen.routeName,
            // todo add arguments:
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Tag(
            title: demo[index],
            isDone: false,
            height: 100,
          ),
        ),
      ),
    );
  }
}
