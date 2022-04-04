import 'package:dream_work/dream_connector/dream_connector.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum Path {
  register,
  login,
  logout,
  all,
  single,
}

/// get the path of the backend
Future<Uri> pathResolver(
    {required Path path, required DreamCore dreamCore}) async {
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
      _path = '/api/todo/';
      break;
  }
  final serverUrl = await dreamCore.coreState();
  final Uri urlWithPath = Uri.parse(serverUrl.toString() + _path);
  if (kDebugMode) {
    print('utils_pathResolver: $urlWithPath');
  }
  return urlWithPath;
}

/// Sent post request to server.
///
/// If state code is 200 return the response body.
///
/// If state code is not 200 throw Error.
Future<String> post({
  required Path path,
  required Map<String, String> headers,
  required String body,
  required DreamCore dreamCore,
}) async {
  final Uri url = await pathResolver(path: path, dreamCore: dreamCore);
  final http.Client client = http.Client();
  final response = await client.post(url, headers: headers, body: body);

  if (kDebugMode) {
    print(
        'utils_post: ${response.statusCode} response body - ${body.toString().split(":").first}');
  }

  if (response.statusCode != 200) {
    throw Exception(json.decode(response.body)['error']);
  }
  return response.body;
}

/// Sent DELETE request to server.
///
/// If state code is 200 return the response body.
///
/// If state code is not 200 throw Error.
Future<String> delete({
  required Path path,
  required Map<String, String> headers,
  required String body,
  required DreamCore dreamCore,
}) async {
  final Uri url = await pathResolver(path: path, dreamCore: dreamCore);
  final http.Client client = http.Client();
  final response = await client.delete(url, headers: headers, body: body);

  if (kDebugMode) {
    print(
        'utils_post: ${response.statusCode} response body - ${body.toString().split(":").first}');
  }

  if (response.statusCode != 200) {
    throw Exception(json.decode(response.body)['error']);
  }
  return response.body;
}
