import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/model.dart';

// todo remove those when everything ready
const String _demoUrl = 'http://localhost:3000';
const String _demoAuthToken =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3QxIiwibmFtZSI6InRlc3QxIiwiZW1haWwiOiJ0ZXN0MSIsImlhdCI6MTY0NzQ3MzM3OH0.xA-RbK5JdXqANTqNZeoWsPWxHqohyIroImASATLeEHY';

class IndividualFetcher {
  IndividualFetcher({
    this.authToken = _demoAuthToken, // jwt auth token
    this.serverUrl = _demoUrl, // server url
  }); // todo remove the default values when everything ready

  final String authToken;
  final String serverUrl;
  final client = http.Client();

  ///----------------------------------------------------------------------------
  /// Fetches the all data belongs to the user, user data will in the authToken.
  ///----------------------------------------------------------------------------
  Future<List<Map<dynamic, dynamic>>?> fetchAll() async {
    final response = await client.get(
      Uri.parse('$serverUrl/api/todos'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': authToken,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> rawData = json.decode(response.body);
      final List<Map<dynamic, dynamic>> data =
          rawData.map((e) => Map.castFrom(e)).toList();
      return data;
    }
    assert(response.statusCode != 200, response.body);
    return null;
  }

  ///----------------------------------------------------------------------------
  /// fetche a single item by a tid or a uid, not both.
  /// tid: task id
  /// pid: project id
  ///----------------------------------------------------------------------------
  Future<Map<dynamic, dynamic>?> fetchById({
    String? tid,
    String? pid,
  }) async {
    assert(!(tid == null && pid == null), 'one of tid or pid must be provided');
    assert(!(tid != null && pid != null),
        'only one of tid or pid should be provided');

    if (tid != null) {
      final response = await client.get(
        Uri.parse('$serverUrl/api/todos/$tid'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': authToken,
        },
      );

      if (response.statusCode == 200) {
        return Map.castFrom(json.decode(response.body));
      }
      assert(response.statusCode != 200, response.body);
    }

    if (pid != null) {
      // todo also add this to the server
    }

    return null;
  }
}
