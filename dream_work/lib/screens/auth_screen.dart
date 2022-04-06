import 'package:dream_work/widgets/form/userauth_form.dart';
import 'package:flutter/material.dart';
import '../dream_connector/dream_connector.dart';
import '../widgets/widgets.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final TextEditingController _server;

  bool _isHttps = true;
  bool _isServerConnected = false;
  String? _error;

  void _setserverError([String? error]) {
    setState(() {
      _error = error;
    });
  }

  void _setServerConnected(bool isConnected) {
    setState(() {
      _isServerConnected = isConnected;
    });
  }

  @override
  void initState() {
    super.initState();
    _server = TextEditingController();
  }

  @override
  void dispose() {
    _server.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: ListView(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: _isServerConnected ? 110 : 550,
                child: _serverAuth(),
              ),
              _isServerConnected
                  ? AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      height: 380,
                      child: const UserAuth(),
                    )
                  : Container(),
            ],
          )),
    );
  }

  Widget _serverAuth() => Column(
        mainAxisAlignment: _isServerConnected
            ? MainAxisAlignment.center
            : MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _server,
            enableSuggestions: false,
            autocorrect: false,
            readOnly: _isServerConnected ? true : false,
            decoration: InputDecoration(
              icon: _error != null
                  ? const Icon(Icons.error, color: Colors.red)
                  : _isServerConnected
                      ? const Icon(Icons.check)
                      : const Icon(Icons.computer),
              labelText: 'Server Address',
              errorText: _error,
              errorStyle: const TextStyle(color: Colors.red),
            ),
          ),
          _isServerConnected
              ? IconButton(
                  onPressed: () {
                    _setServerConnected(false);
                    _setserverError(null);
                  },
                  icon: const Icon(Icons.close, color: Colors.red))
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(Icons.https),
                        const Text(
                          'HTTPS',
                        ),
                        Switch(
                          value: _isHttps,
                          onChanged: (value) {
                            setState(() {
                              _isHttps = value;
                            });
                          },
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                        ),
                      ],
                    ),
                    ElevatedButton(
                      child: StreamBuilder<Object>(
                          stream: DreamAuth.instance.isLoading,
                          builder: (context, AsyncSnapshot snap) {
                            return Text(
                              snap.data == null || !snap.hasData
                                  ? 'Connecting..'
                                  : "Connect",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            );
                          }),
                      onPressed: () async {
                        if (_server.text.isEmpty) {
                          _setserverError('Server address is required');
                          return;
                        }
                        late String serverUrl;
                        late int port;

                        String protocol = _isHttps ? 'https' : 'http';

                        try {
                          serverUrl = _server.text.split(':')[0];
                          port = _server.text.split(':').length == 2
                              ? int.parse(_server.text.split(':').last)
                              : _isHttps
                                  ? 443
                                  : 80;
                          print(port);
                        } catch (e) {
                          _setserverError('Invalid server address');
                        }

                        _setserverError(null);

                        DreamCore dreamCore = DreamCore.initializeCore(
                          serverUrl: serverUrl,
                          serverPort: port,
                          serverProtocol: protocol,
                        );

                        await dreamCore
                            .coreState()
                            .then(
                              (value) => {
                                _setServerConnected(true),
                              },
                            )
                            .catchError(
                          (e) {
                            _setserverError('Failed to connect to server');
                          },
                        );
                      },
                    ),
                  ],
                ),
        ],
      );
}
