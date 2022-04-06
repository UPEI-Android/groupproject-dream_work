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
