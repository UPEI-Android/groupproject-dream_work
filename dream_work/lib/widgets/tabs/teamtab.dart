import 'package:dream_work/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../../dream_connector/dreamConnector.dart';
import '../../screens/screens.dart';

class TeamTab extends StatelessWidget {
  const TeamTab({Key? key}) : super(key: key);
  static const routeName = '/team';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DreamDatabase.instance.allItem,
      builder: (BuildContext context, AsyncSnapshot snap) {
        var sections;
        //find unique section
        if (snap.data != null) {
          sections = snap.data.map((e) => e['section']).toSet().toList();
        }

        return snap.data != null
            ? ListView.builder(
                itemCount: sections.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () async {
                    Navigator.pushNamed(
                      context,
                      IndividualScreen.routeName,
                      arguments: sections[index],
                    );
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: Tag(
                      title: sections[index],
                      isDone: false,
                      height: 100,
                    ),
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: Colors.greenAccent,
                ),
              );
      },
    );
  }
}

class item {
  final String section;
  item(this.section);
}
