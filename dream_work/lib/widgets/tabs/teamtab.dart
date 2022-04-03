import 'package:dream_work/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../../screens/screens.dart';

class TeamTab extends StatelessWidget {
  const TeamTab({Key? key}) : super(key: key);
  static const routeName = '/team';

  @override
  Widget build(BuildContext context) {
    List<String> demo = List.generate(3, (index) => 'Team Item $index');
    return ListView.builder(
      itemCount: demo.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () async {
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
