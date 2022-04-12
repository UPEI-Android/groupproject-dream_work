import 'package:dream_work/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../../dream_connector/dream_connector.dart';
import '../../router.dart';
import '../../utils/utils.dart';
import '../widgets.dart';

class TeamTab extends StatelessWidget {
   const TeamTab({Key? key, required this.search}) : super(key: key);
   final String search;
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
        if(search != ''){
          sections.removeWhere((element) => !element.toString().startsWith(search));
        }
        // find finished percentage for each section
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
