import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class Fetcher {
  final String? authToken;
  final String serverUrl;
  final http.Client client = http.Client();

  Fetcher({
    this.authToken,
    required this.serverUrl,
  });
}

mixin Individual<T, E> on Fetcher {
  Future<List<Map<T, E>>?> fetch({
    required String authToken,
    required String serverUrl,
    required http.Client client,
  }) async {
    final response = await client.get(
      Uri.parse('$serverUrl/api/todos'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': authToken,
      },
    );
    //assert(response.statusCode != 200, response.body);
    if (response.statusCode != 200) {
      throw Exception('Failed to load post');
    }

    print(response.body);

    final List<dynamic> rawData = json.decode(response.body);
    final List<Map<T, E>> data =
        rawData.map((e) => Map.castFrom(e) as Map<T, E>).toList();
    return data;
  }
}

class IndividualFetcher extends Fetcher with Individual<String, dynamic> {
  IndividualFetcher({
    required String authToken,
    required String serverUrl,
  }) : super(
          authToken: authToken,
          serverUrl: serverUrl,
        );

  void getResult() async {
    await Future.wait({
      fetch(authToken: authToken!, serverUrl: serverUrl, client: client)
          .then((value) => print(value))
      //.catchError((value) => print(value)),
    });
  }
}
