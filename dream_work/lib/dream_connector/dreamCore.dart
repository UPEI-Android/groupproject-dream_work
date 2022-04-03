import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// sotre basic information and setting about server
class DreamCore {
  final String serverUrl; // server url
  final int serverPort; // default 80
  final String serverProtocol; // http or https
  late Uri uri;

  DreamCore({
    required this.serverUrl,
    required this.serverPort,
    required this.serverProtocol,
  }) {
    uri = Uri(
      scheme: serverProtocol,
      host: serverUrl,
      port: serverPort,
    );
  }

  /// check if server is available
  /// return server url if server is available
  /// throw exception if server is not available
  Future<Uri> coreState() async {
    print(uri);
    http.Client client = http.Client();
    http.Response response = await client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      if (kDebugMode) {
        print('Failed to connect $uri');
      }
      throw Exception('Failed to connect to server');
    }
    if (kDebugMode) {
      print('successfully connected to $uri');
    }

    return uri;
  }
}
