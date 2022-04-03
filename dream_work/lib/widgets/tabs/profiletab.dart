import 'package:flutter/material.dart';
import '../../dream_connector/dreamConnector.dart';
import '../widgets.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  double _height = 80;
  bool _isExpanded = false;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: _height,
          child: StreamBuilder(
            stream: DreamAuth.instance.authStateStream,
            builder: (BuildContext context, AsyncSnapshot snap) {
              return snap.data == null
                  ? _authTag()
                  : Profile(
                      userEmail: snap.data['email'] ?? '',
                      userName: snap.data['name'] ?? '',
                      showLogout: true,
                    );
            },
          ),
        ),
        _divider(),
        Container(
          height: 200,
          color: Colors.amber,
        ),
        _divider(),
        Container(
          height: 100,
          color: Colors.amber,
        ),
        _divider(),
      ],
    );
  }

  Widget _authTag() => _isExpanded
      ? _loginForm()
      : ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.amber,
            padding: const EdgeInsets.all(20),
          ),
          onPressed: () async {
            setState(() {
              _height = 300;
            });
            await Future.delayed(const Duration(milliseconds: 200), () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            });
          },
          child:
              const Text('Login / Register', style: TextStyle(fontSize: 30.0)));

  Widget _loginForm() => Form(
        child: Container(
          color: Colors.amber,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(_error,
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username / Email',
                    labelStyle: TextStyle(fontSize: 20),
                  ),
                ),
                TextFormField(
                  controller: _password,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    labelStyle: TextStyle(fontSize: 20),
                  ),
                ),
                _error == 'No such user' ? _registerBtn() : _signinBtn(),
              ],
            ),
          ),
        ),
      );

  Widget _signinBtn() => ElevatedButton(
        onPressed: () async {
          final String email = _email.text;
          final String password = _password.text;
          await DreamAuth.instance
              .loginWithEmailAndPassword(email: email, password: password)
              .then((value) {
            setState(() {
              _height = 100;
              _isExpanded = false;
              _error = '';
            });
          }).catchError(
            (e) {
              setState(
                () {
                  _error = e.toString().split(': ').last;
                },
              );
            },
          );
        },
        child: const Text(
          'Login',
          style: TextStyle(fontSize: 30.0),
        ),
      );

  Widget _registerBtn() => ElevatedButton(
        onPressed: () async {
          final String email = _email.text;
          final String password = _password.text;
          await DreamAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((value) {
            setState(() {
              _height = 100;
              _isExpanded = false;
              _error = '';
            });
          }).catchError((e) {
            setState(() {
              _error = e.toString().split(': ').last;
            });
          });
        },
        child: const Text(
          'Resgister',
          style: TextStyle(fontSize: 30.0),
        ),
      );
}

Widget _divider() => const Divider(
      height: 30,
      color: Colors.white,
    );
