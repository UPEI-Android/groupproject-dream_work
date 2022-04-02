import 'package:http/http.dart' as http;

/// sotre basic information and setting about server
class DreamCore {
  final String serverUrl; // server url
  final int serverPort; // default 80
  final String serverProtocol; // http or https

  DreamCore({
    required this.serverUrl,
    required this.serverPort,
    required this.serverProtocol,
  });

  Future<Uri> coreState() async {
    Uri uri = Uri.parse('$serverProtocol://$serverUrl:$serverPort');
    http.Client client = http.Client();
    http.Response response = await client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to connect to server');
    }
    return uri;
  }
}
