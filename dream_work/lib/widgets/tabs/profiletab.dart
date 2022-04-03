import 'package:flutter/material.dart';
import '../../dream_connector/dreamConnector.dart';
import '../widgets.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final BorderRadiusGeometry borderRadius = BorderRadius.circular(20);
  late final TextEditingController _email;
  late final TextEditingController _password;

  double _height = 80;
  bool _isExpanded = false;
  bool _isLoading = false;
  String? _error;

  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  void _setError([String? error]) {
    setState(() {
      _error = error;
    });
  }

  void _setExpanded(bool isExpanded) {
    setState(() {
      _isExpanded = isExpanded;
    });
  }

  void _setHeight([double height = 100]) {
    setState(() {
      _height = height;
    });
  }

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
        _authTag(),
        _divider(),
        Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: Colors.amber,
          ),
        ),
        _divider(),
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: Colors.greenAccent,
          ),
        ),
        _divider(),
      ],
    );
  }

  Widget _authTag() => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: _height,
        child: StreamBuilder(
          stream: DreamAuth.instance.authState,
          builder: (BuildContext context, AsyncSnapshot snap) {
            return snap.data == null
                ? _isExpanded
                    ? _authForm()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(20),
                        ),
                        onPressed: () async {
                          _setHeight(280);
                          await Future.delayed(
                              const Duration(milliseconds: 200), () {
                            _setExpanded(!_isExpanded);
                          });
                        },
                        child: const Text('Login / Register',
                            style: TextStyle(fontSize: 25.0)))
                : Profile(
                    userEmail: snap.data['email'] ?? '',
                    userName: snap.data['name'] ?? '',
                    showLogout: true,
                  );
          },
        ),
      );

  Widget _authForm() => Form(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: Colors.greenAccent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_error ?? '',
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    labelText: 'Username / Email',
                  ),
                ),
                TextFormField(
                  controller: _password,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
                _error == 'No such user' ? _registerBtn() : _signinBtn(),
              ],
            ),
          ),
        ),
      );

  Widget _signinBtn() => ElevatedButton(
        child: Text(
          _isLoading ? 'loading...' : 'Login',
        ),
        onPressed: () async {
          _setLoading(true);
          _signin();
          _setLoading(false);
        },
      );

  Widget _registerBtn() => ElevatedButton(
        child: Text(
          _isLoading ? 'loading...' : 'Resgister',
        ),
        onPressed: () async {
          _setLoading(true);
          _register();
          _setLoading(false);
        },
      );

  Future<void> _signin() async {
    final String email = _email.text;
    final String password = _password.text;
    await DreamAuth.instance
        .loginWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (value) {
        _restTag();
      },
    ).catchError(
      (e) {
        _setError(e.toString().split(': ').last);
      },
    );
  }

  Future<void> _register() async {
    final String email = _email.text;
    final String password = _password.text;
    await DreamAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (value) {
        _restTag();
      },
    ).catchError(
      (e) {
        _setError(e.toString().split(': ').last);
      },
    );
  }

  void _restTag() {
    _setExpanded(false);
    _setHeight();
    _setError();
  }
}

Widget _divider() => const Divider(
      height: 30,
      color: Colors.white,
    );
