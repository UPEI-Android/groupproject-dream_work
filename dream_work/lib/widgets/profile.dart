import 'package:flutter/material.dart';
import '../dream_connector/dreamConnector.dart';

class Profile extends StatelessWidget {
  const Profile({
    Key? key,
    required this.userEmail,
    required this.userName,
    this.showLogout = false,
  }) : super(key: key);

  final String userName;
  final String userEmail;
  final bool showLogout;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (showLogout) {
          showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                    backgroundColor: Theme.of(context).primaryColor,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            await DreamAuth.instance.logout();
                          },
                          child: const Text('Logout'),
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                        ),
                      ),
                    ],
                  ));
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.green,
              child: Text(userName[0],
                  style: const TextStyle(fontSize: 30.0, color: Colors.white)),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName,
                  style: const TextStyle(fontSize: 25.0, color: Colors.white)),
              const Divider(
                height: 5,
              ),
              Text(userEmail,
                  style: const TextStyle(fontSize: 15.0, color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}
