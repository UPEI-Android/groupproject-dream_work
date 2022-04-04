import 'package:flutter/material.dart';
import '../../dream_connector/dreamConnector.dart';
import '../../screens/screens.dart';
import '../widgets.dart';

class TeamTab extends StatelessWidget {
  const TeamTab({Key? key}) : super(key: key);
  static const routeName = '/team';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DreamDatabase.instance.allItem,
      builder: (BuildContext context, AsyncSnapshot snap) {
        Map<String, double> sectionDonePercentage = {};
        List<dynamic> sections = [];

        if (snap.data != null) {
          // find unique section
          sections = snap.data.map((e) => e['section']).toSet().toList();

          // find done percentage of each section
          for (final String data in sections) {
            double donePrecent = snap.data
                    .where((element) => element['section'] == data)
                    .map((element) => element['isDone'].toString())
                    .toList()
                    .where((element) => element == 'true')
                    .length /
                snap.data.where((element) => element['section'] == data).length;
            final result = <String, double>{data: donePrecent};
            sectionDonePercentage.addEntries(result.entries);
          }
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
                      widget: Progerss(
                          precent: sectionDonePercentage[sections[index]]!),
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
