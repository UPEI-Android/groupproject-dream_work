import 'package:dream_work/dream_connector/dream_connector.dart';

void taskEditer({
  required String tid,
  String? section,
  String? context,
  String? memeber,
  bool? isDone,
  String? update_by,
  DateTime? due_at,
}) {
  // todo
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
  data.value.forEach(
      (e) async => await DreamDatabase.instance.deleteOne(tid: e['tid']));
}
