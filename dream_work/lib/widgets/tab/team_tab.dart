import 'package:flutter/material.dart';
import '../../dream_connector/dream_connector.dart';
import '../../screens/screens.dart';
import '../../utils/utils.dart';
import '../widgets.dart';

class TeamTab extends StatelessWidget {
  const TeamTab({Key? key}) : super(key: key);
  static const routeName = '/team';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DreamDatabase.instance.allItem,
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (snap.data == null || snap.hasError) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.greenAccent,
            ),
          );
        }

        // find unique sections
        final List<dynamic> sections = findSections(sourceData: snap.data);
        // find finished percentage for eachsection
        final Map<String, double> sectionDonePercentage = {};
        for (final String section in sections) {
          sectionDonePercentage.addEntries(<String, double>{
            section: findFinishPrecentageBySection(
                section: section, sourceData: snap.data)
          }.entries);
        }

        return ListView.builder(
          itemCount: sections.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () async {
              Navigator.pushNamed(
                context,
                IndividualScreen.routeName,
                arguments: sections[index],
              );
            },
            child: Tag(
              title: sections[index],
              isDone: false,
              isEditable: false,
              height: 85,
              widget: TaskProgerss(
                precent: sectionDonePercentage[sections[index]]!,
              ),
            ),
          ),
        );
      },
    );
  }
}
