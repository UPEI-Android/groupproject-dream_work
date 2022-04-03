import 'package:dream_work/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../dream_connector/dreamConnector.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const routeName = '/welcome';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final TextEditingController _serverUrlController;
  late final TextEditingController _serverPortController;
  bool _isHttps = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _serverPortController = TextEditingController();
    _serverUrlController = TextEditingController();
  }

  @override
  void dispoes() {
    _serverPortController.dispose();
    _serverUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                TextField(
                  controller: _serverUrlController,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.computer),
                    labelText: 'Server Address',
                    errorText: _error,
                    errorStyle: const TextStyle(color: Colors.red),
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _serverPortController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.portrait),
                    labelText: 'Port',
                  ),
                ),
                const Divider(
                  height: 13,
                ),
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
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                String serverUrl = 'dream.luobo.ca';
                int port = _serverPortController.text.isNotEmpty
                    ? int.parse(_serverPortController.text)
                    : _isHttps
                        ? 443
                        : 80;

                String protocol = _isHttps ? 'https' : 'http';

                setState(() {
                  _error = _serverUrlController.text.isEmpty ? 'Empty' : null;
                });

                if (_serverUrlController.text.isEmpty) {
                  return;
                }

                DreamCore dreamCore = DreamCore(
                  serverUrl: serverUrl,
                  serverPort: port,
                  serverProtocol: protocol,
                );

                DreamAuth.instance.dreamCore = dreamCore;

                await dreamCore
                    .coreState()
                    .then(
                      (value) => Navigator.pushNamed(
                        context,
                        HomeScreen.routeName,
                      ),
                    )
                    .catchError(
                  (e) {
                    setState(
                      () {
                        _error = e.toString();
                      },
                    );
                  },
                );
              },
              child: const Text(
                "Join",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeScreenBody extends StatelessWidget {
  const WelcomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // size of the screen
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          const WelcomeScreenBackground(),
          Positioned(
            top: size.height * 0.5,
            left: 0,
            child: SizedBox(
              width: size.width,
              height: size.height * 0.5,
              child: ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                      child: const Text("START"), onPressed: () => {}
                      //Navigator.pushNamed(
                      // context, RouteGenerator.individual_screen),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WelcomeScreenBackground extends StatelessWidget {
  const WelcomeScreenBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // size of the screen
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blueGrey,
                    Color.fromARGB(255, 225, 190, 145),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: SizedBox(
              width: size.width,
              height: size.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    'Dream Work',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'A place to work together',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
