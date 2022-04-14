import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'dream_connector.dart';
import 'utils/utils.dart';

/// Core of the dream connector
///
/// This class is used to initialize the dream connector
class DreamCore {
  late final String serverUrl; // server url
  late final int serverPort; // default 80
  late final String serverProtocol; // http or https

  late final Uri uri;
  final BehaviorSubject _isLoadingStream = BehaviorSubject<bool>.seeded(false);

  /// Stream of [bool]
  /// - true if loading
  get isLoading => _isLoadingStream;

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

  /// a factory method to initialize a DreamCore instance
  factory DreamCore.core({
    required String serverUrl,
    required int serverPort,
    required String serverProtocol,
  }) {
    return DreamCore.initializeCore(
      serverUrl: serverUrl,
      serverPort: serverPort,
      serverProtocol: serverProtocol,
    );
  }

  /// check if server is available
  ///
  /// return server url if server is available
  ///
  /// throw exception if server is not available
  Future<Uri> coreState() async {
    _isLoadingStream.add(true);
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
    _isLoadingStream.add(false);
    return uri;
  }

  Future close() async {
    DreamDatabase.instance.disconnect();
    logger('dreamCore_close: closed successfully');
  }

  DreamCore._dummy();

  factory DreamCore.dummyCore() {
    return DreamCore._dummy();
  }
}
