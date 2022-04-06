import '../dream_connector/dream_connector.dart';

/// find the task item that in this section.
List<dynamic> findItemsBySecion({
  required dynamic sourceData,
  required String section,
}) {
  return sourceData.where((e) => e['section'] == section).toList();
}

/// calculate the precentage off finished task in this section.
double findFinishPrecentageBySection({
  required dynamic sourceData,
  required String section,
}) {
  return sourceData
          .where((element) => element['section'] == section)
          .map((element) => element['isDone'].toString())
          .toList()
          .where((element) => element == 'true')
          .length /
      sourceData.where((element) => element['section'] == section).length;
}

/// find all sections in the source data.
List<dynamic> findSections({
  required dynamic sourceData,
}) {
  return sourceData.map((e) => e['section']).toSet().toList();
}

/// rename the section
Future sectionTitleEditer({
  required String newTitle,
  required String oldTitle,
}) async {
  // find all the element with the old title and change it to the new title
  var data = await DreamDatabase.instance.allItem;
  data.value.forEach(
    (element) {
      if (element['section'] == oldTitle) {
        element['section'] = newTitle;
      }
    },
  );
  await deleteSectionWithTitle(title: oldTitle);
  await DreamDatabase.instance.writeAll(data.value);
}

/// delete all the task item belong to the section
Future deleteSectionWithTitle({
  required String title,
}) async {
  var data = await DreamDatabase.instance.allItem;
  data.value.where((e) => e['section'] == title).forEach(
        (e) async => await DreamDatabase.instance.deleteOne(tid: e['tid']),
      );
}
