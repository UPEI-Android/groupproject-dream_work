import 'package:flutter_test/flutter_test.dart';
import '../../../lib/dream_connector/utils/http.dart';

import 'http_test.mocks.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([http.Client])
void main() {
  const String url = 'https://test.com/';
  test('post with 200', () async {
    final client = MockClient();
    when(client.post(
      Uri.parse(url),
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    )).thenAnswer((_) async => http.Response(
          '{"message": "success"}',
          200,
        ));
    final response = await post(
      url: Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: '{"message": "success"}',
      client: client,
    );
    expect(response, '{"message": "success"}');
  });

  test('delete with 200', () async {
    final client = MockClient();
    when(client.post(
      Uri.parse(url),
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    )).thenAnswer((_) async => http.Response(
          '{"message": "success"}',
          200,
        ));
    final response = await post(
      url: Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: '{"message": "success"}',
      client: client,
    );
    expect(response, '{"message": "success"}');
  });
}
