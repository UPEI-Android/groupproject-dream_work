import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class Fetcher {
  final String? authToken;
  final Uri serverUrl;
  final http.Client client = http.Client();

  Fetcher({
    this.authToken,
    required this.serverUrl,
  });
}

mixin Individual<T, E> on Fetcher {
  Future<List<Map<T, E>>> fetch({
    required String authToken,
    required Uri serverUrl,
    required http.Client client,
  }) async {
    final response = await client.get(
      serverUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': authToken,
      },
    );

    if (kDebugMode) {
      print(
          'fetcher_Individual: ${response.statusCode} - response body: ${response.body.split(':').first}...');
    }

    if (response.statusCode != 200) {
      throw Exception('Failed to load post');
    }

    final List<dynamic> rawData = json.decode(response.body);
    final List<Map<T, E>> data = rawData.map((e) => Map<T, E>.from(e)).toList();
    return data;
  }
}

class IndividualFetcher extends Fetcher with Individual<String, dynamic> {
  IndividualFetcher({
    required String authToken,
    required Uri serverUrl,
  }) : super(
          authToken: authToken,
          serverUrl: serverUrl,
        );

  Future<List<Map<String, dynamic>>> getResult() async {
    return fetch(authToken: authToken!, serverUrl: serverUrl, client: client);
    //.catchError((value) => print(value)),
  }
}
