import 'package:flutter_test/flutter_test.dart';
import '../../lib/dream_connector/dream_core.dart';

void main() {
  String uri = 'test.com';
  test('DreamCore.initializeCore created for: $uri', () {
    final DreamCore dreamCore = DreamCore.core(
      serverUrl: uri,
      serverPort: 80,
      serverProtocol: 'http',
    );
    expect(dreamCore.serverUrl, uri);
    expect(dreamCore.serverPort, 80);
    expect(dreamCore.serverProtocol, 'http');
    expect(
        dreamCore.uri,
        Uri(
          scheme: 'http',
          host: uri,
          port: 80,
        ));
  });

  test('DreamCore.core create for: $uri', () {
    final DreamCore dreamCore = DreamCore.core(
      serverUrl: uri,
      serverPort: 80,
      serverProtocol: 'http',
    );
    expect(dreamCore.serverUrl, uri);
    expect(dreamCore.serverPort, 80);
    expect(dreamCore.serverProtocol, 'http');
    expect(
        dreamCore.uri,
        Uri(
          scheme: 'http',
          host: uri,
          port: 80,
        ));
  });

  test('DreamCore.dummyCore', () {
    final DreamCore dreamCore = DreamCore.dummyCore();
    bool isLoading = dreamCore.isLoading.value;
    expect(isLoading, false);
  });
}
