import 'package:dream_work/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../dream_connector/dreamConnector.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const routeName = '/welcome';

  @override
  Widget build(BuildContext context) {
    final _serverUrlController = TextEditingController();
    final _serverPortController = TextEditingController();
    final _serverProtocolController = TextEditingController();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            child: const Text('Log In'),
            onPressed: () {
              Alert(
                  context: context,
                  title: "Log In",
                  content: Column(
                    children: <Widget>[
                      TextField(
                        controller: _serverUrlController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.computer),
                          labelText: 'Server Address',
                        ),
                      ),
                      TextField(
                        controller: _serverPortController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.portrait),
                          labelText: 'Port',
                        ),
                      ),
                      TextField(
                        controller: _serverProtocolController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'Protocol',
                        ),
                      ),
                    ],
                  ),
                  buttons: [
                    DialogButton(
                      onPressed: () {
                        DreamCore dreamCore = DreamCore(
                          ServerUrl: _serverUrlController.text,
                          ServerPort: int.parse(_serverPortController.text),
                          ServerProtocol: _serverProtocolController.text,
                        );
                        DreamAuth.instance.dreamCore = dreamCore;
                        Navigator.pushNamed(
                          context,
                          HomeScreen.routeName,
                        );
                      },
                      child: const Text(
                        "Join",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    DialogButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ]).show();
            },
          ),
        ],
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
