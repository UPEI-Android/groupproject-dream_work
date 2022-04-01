import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  double _height = 80;
  bool _isExpanded = false;

  Widget _profile([bool isLogin = false]) => isLogin
      ? const UserAccountsDrawerHeader(
          accountName: Text('Guest', style: TextStyle(fontSize: 25.0)),
          accountEmail:
              Text('guest@dream.local', style: TextStyle(fontSize: 15.0)),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.amber,
            child: Text('G', style: TextStyle(fontSize: 40.0)),
          ),
        )
      : _isExpanded
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
              child: const Text('Login', style: TextStyle(fontSize: 30.0)));

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: _height,
          child: _profile(),
          color: Colors.amber,
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
}

Widget _loginForm() => Form(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username / Email',
                labelStyle: TextStyle(fontSize: 20),
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                labelStyle: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 30.0),
              ),
            ),
          ],
        ),
      ),
    );

Widget _divider() => const Divider(
      height: 30,
      color: Colors.white,
    );
