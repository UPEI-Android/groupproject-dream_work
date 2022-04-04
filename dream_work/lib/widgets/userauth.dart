import 'package:flutter/material.dart';
import '../dream_connector/dreamConnector.dart';
import '../screens/home_screen.dart';

class UserAuth extends StatefulWidget {
  const UserAuth({Key? key}) : super(key: key);

  @override
  State<UserAuth> createState() => _UserAuthState();
}

class _UserAuthState extends State<UserAuth> {
  bool _isLoading = false;
  String? _error;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _name;

  void _setError([String? error]) {
    setState(() {
      _error = error;
    });
  }

  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _name = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _isRegister = _error == 'No such user';
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _email,
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: _error == null
                ? const Icon(Icons.person)
                : const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
            labelText: 'Email',
            errorText: _error,
            errorStyle: const TextStyle(color: Colors.red),
          ),
        ),
        _isRegister
            ? TextField(
                controller: _name,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  icon: _error == null
                      ? const Icon(Icons.lock)
                      : const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                  labelText: 'Name',
                  errorText: _error,
                  errorStyle: const TextStyle(color: Colors.red),
                ),
              )
            : Container(),
        TextField(
          controller: _password,
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          decoration: InputDecoration(
            icon: _error == null
                ? const Icon(Icons.lock)
                : const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
            labelText: 'Password',
            errorText: _error,
            errorStyle: const TextStyle(color: Colors.red),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: btn(_error != 'No such user'),
        ),
      ],
    );
  }

  Widget btn(bool isSign) => ElevatedButton(
        child: Text(
          _isLoading
              ? 'Connecting...'
              : isSign
                  ? "Login"
                  : "Register",
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () async {
          if (_email.text.isEmpty || _password.text.isEmpty) {
            _setError('Please enter a valid email and password');
            return;
          }
          _setLoading(true);
          final String email = _email.text;
          final String password = _password.text;
          await _sentForm(email, password, _error != 'No such user')
              .then((value) {
            _setLoading(false);
            _email.clear();
            _password.clear();
            _name.clear();
          });
        },
      );

  Future<void> _sentForm(String email, String password, bool isSign) async {
    final fn = isSign
        ? DreamAuth.instance.loginWithEmailAndPassword(
            email: email,
            password: password,
          )
        : DreamAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

    await fn.then(
      (value) {
        _authSeccess();
        DreamDatabase.instance.connect();
      },
    ).catchError(
      (e) {
        _setError(e.toString().split(': ').last);
      },
    );
  }

  void _authSeccess() {
    _setError();
    Navigator.pushNamed(
      context,
      HomeScreen.routeName,
    );
  }
}
