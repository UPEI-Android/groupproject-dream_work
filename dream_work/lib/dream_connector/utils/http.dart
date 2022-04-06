import 'package:http/http.dart' as http;
import 'dart:convert';
import 'utils.dart';

/// Sent post request to server.
///
/// If state code is 200 return the response body.
///
/// If state code is not 200 throw Error.
Future<String> post({
  required Uri url,
  required Map<String, String> headers,
  required String body,
}) async {
  final http.Client client = http.Client();
  final response = await client.post(url, headers: headers, body: body);

  logger(
      'utils_post: ${response.statusCode} response body - ${body.toString().split(":").first}');

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
  required Uri url,
  required Map<String, String> headers,
  required String body,
}) async {
  final http.Client client = http.Client();
  final response = await client.delete(url, headers: headers, body: body);

  logger(
      'utils_post: ${response.statusCode} response body - ${body.toString().split(":").first}');

  if (response.statusCode != 200) {
    throw Exception(json.decode(response.body)['error']);
  }
  return response.body;
}
