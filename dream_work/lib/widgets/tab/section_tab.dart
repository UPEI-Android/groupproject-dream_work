import 'package:dream_work/routes/route_generator.dart';
import 'package:flutter/material.dart';
import '../../dream_connector/dream_connector.dart';
import '../../router.dart';
import '../../utils/utils.dart';
import '../widgets.dart';

class TeamTab extends StatelessWidget {
  const TeamTab({Key? key}) : super(key: key);
  //static const routeName = '/team';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DreamDatabase.instance.items,
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
        final Map<String, double> sectionFinishedPercentage = {};
        for (final String section in sections) {
          sectionFinishedPercentage.addEntries(<String, double>{
            section: findFinishPercentageBySection(
                section: section, sourceData: snap.data)
          }.entries);
        }

        return ListView.builder(
          itemCount: sections.length,
          itemBuilder: (context, index) => SectionCard(
            title: sections[index],
            child: TaskProgerss(
                precent: sectionFinishedPercentage[sections[index]] ?? 0),
            onTap: () => Navigator.pushNamed(
              context,
              Routing.individual,
              arguments: sections[index],
            ),
          ),
        );
      },
    );
  }
}
