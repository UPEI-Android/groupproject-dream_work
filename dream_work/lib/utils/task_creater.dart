import 'dart:math';

import '../dream_connector/dream_connector.dart';

/// create a new individual todo item
createTask({required String section}) async {
  // todo: give them real values
  final bool isDone = Random().nextBool();
  // get a random number
  final Map<String, dynamic> map = {
    "tid": (DateTime.now().millisecondsSinceEpoch).toString(),
    "members": "demo",
    "section": section,
    "isDone": isDone,
    "updated_by": "test",
    "updated_at": "undefined",
    "created_at": "undefined",
    "due_at": "test",
    "content": "test"
  };
  await DreamDatabase.instance.writeOne(map);
}

editTask({required bool isDone}) async {}
