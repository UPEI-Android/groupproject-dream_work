import 'dart:math';

import '../dream_connector/dream_connector.dart';

/// create a new individual todo item
createTask({required String section}) async {
  // get a random number
  final Map<String, dynamic> map = {
    "tid": (DateTime.now().millisecondsSinceEpoch).toString(),
    "members": "demo",
    "section": section,
    "isDone": false,
    "updated_by": "test",
    "updated_at": "undefined",
    "created_at": "undefined",
    "due_at": "test",
    "content": "",
  };
  await DreamDatabase.instance.writeOne(map);
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
