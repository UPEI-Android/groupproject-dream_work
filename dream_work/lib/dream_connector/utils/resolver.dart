import '../dream_core.dart';
import 'logger.dart';

enum Path {
  register,
  login,
  logout,
  all,
  single,
}

/// build the path for the request
Future<Uri> pathResolver({
  required Path path,
  required DreamCore dreamCore,
  String? tid,
}) async {
  late String _path;
  switch (path) {
    case Path.register:
      _path = '/api/auth/register';
      break;
    case Path.login:
      _path = '/api/auth/login';
      break;
    case Path.logout:
      _path = '/api/auth/logout';
      break;
    case Path.all:
      _path = '/api/todos';
      break;
    case Path.single:
      _path = '/api/todos/';
      break;
  }
  final serverUrl = await dreamCore.coreState();
  final Uri urlWithPath = Uri.parse(serverUrl.toString() + _path + (tid ?? ''));
  logger('utils_pathResolver: $urlWithPath');

  return urlWithPath;
}

/// build the header for the request
Map<String, String> headerResolver([String? authToken]) => {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'authorization': authToken ?? '',
    };
