import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({
    Key? key,
    required this.userEmail,
    required this.userName,
  }) : super(key: key);

  final String userName;
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: Text(userName, style: TextStyle(fontSize: 25.0)),
      accountEmail: Text(userEmail, style: TextStyle(fontSize: 15.0)),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.green,
        child: Text(userName[0], style: const TextStyle(fontSize: 20.0)),
      ),
    );
  }
}
