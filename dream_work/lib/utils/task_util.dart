import '../dream_connector/dream_connector.dart';

/// create a new individual todo item
createTask({required String section}) async {
  String currentUser = DreamAuth.instance.authState.value['name'];
  // get a random number
  final Map<String, dynamic> map = {
    "tid": (DateTime.now().millisecondsSinceEpoch).hashCode.toRadixString(16),
    "members": currentUser,
    "section": section,
    "isDone": false,
    "updated_by": currentUser,
    "updated_at": "undefined",
    "created_at": "undefined",
    "due_at": "none",
    "content": "",
  };
  await DreamDatabase.instance.writeOne(map);
}

createSection() {
  createTask(
      section:
          'New_${(DateTime.now().microsecond).hashCode.toRadixString(16)}');
}
