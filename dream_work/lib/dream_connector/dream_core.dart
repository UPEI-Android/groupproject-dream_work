import 'package:dream_work/dream_connector/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'dream_connector.dart';
import 'utils/utils.dart';

/// Core of the dream connector
///
/// This class is used to initialize the dream connector
class DreamCore {
  final String serverUrl; // server url
  final int serverPort; // default 80
  final String serverProtocol; // http or https

  late Uri uri;

  /// a Named Constructor to initialize a DreamCore instance
  ///
  /// then set the instance to [DreamAuth.instance.dreamCore]
  /// and [DreamDatabase.instance.dreamCore]
  ///
  /// [serverUrl] is the server url
  /// [serverPort] is the server port
  /// [serverProtocol] is the server protocol
  DreamCore.initializeCore({
    required this.serverUrl,
    required this.serverPort,
    required this.serverProtocol,
  }) {
    uri = Uri(
      scheme: serverProtocol,
      host: serverUrl,
      port: serverPort,
    );
    DreamAuth.instance.dreamCore = this;
    DreamDatabase.instance.dreamCore = this;
    logger('DreamCore.initializeCore created for: $uri');
  }

  /// check if server is available
  ///
  /// return server url if server is available
  ///
  /// throw exception if server is not available
  Future<Uri> coreState() async {
    http.Client client = http.Client();
    http.Response response = await client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    response.statusCode != 200
        ? throw Exception('Failed to connect to server')
        : null;

    logger('dreamCore_coreState: successfully connected to $uri');
    return uri;
  }

  Future close() async {
    logger('dreamCore_close: closing dream core');
  }
}
