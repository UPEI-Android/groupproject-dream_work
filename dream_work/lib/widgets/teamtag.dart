import 'package:dream_work/routes/route_generator.dart';
import 'package:dream_work/screens/individual_screen.dart';
import 'package:flutter/material.dart';
import 'widgets.dart';
import '../screens/screens.dart';

class TeamTag extends StatelessWidget {
  const TeamTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //get team names as list
    List<String> demo = List.generate(3, (index) => 'Team Item $index');
    if (demo.isEmpty){
      return Center(child: Text("No Teams Joined Yet",style: TextStyle(color: Colors.black.withOpacity(0.6))));
    }
    return ListView.builder(
      itemCount: demo.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteGenerator.individual_screen,
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
