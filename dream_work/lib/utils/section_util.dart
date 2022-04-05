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
