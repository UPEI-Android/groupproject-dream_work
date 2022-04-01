/// sotre basic information and setting about server
class DreamCore {
  final String ServerUrl; // server url
  final int ServerPort; // default 80
  final String ServerProtocol; // http or https

  DreamCore({
    required this.ServerUrl,
    this.ServerPort = 80,
    this.ServerProtocol = 'http',
  });

  bool coreState() =>
      ServerUrl != null && ServerPort != null && ServerProtocol != null;
}
