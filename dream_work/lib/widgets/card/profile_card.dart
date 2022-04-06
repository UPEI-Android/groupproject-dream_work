import 'package:dream_work/routes/route_generator.dart';
import 'package:flutter/material.dart';
import '../../dream_connector/dream_connector.dart';
import '../../router.dart';
import '../../widgets/widgets.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
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
    return GeneralCard(
      height: 80,
      onTap: () {
        if (showLogout) {
          showDialog(
            context: context,
            builder: (context) => SimpleDialog(
              backgroundColor: Colors.greenAccent,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () async {
                      await DreamAuth.instance.logout();

                      Navigator.pushNamed(context, Routing.auth);
                    },
                    child: const Text('Logout'),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  ),
                ),
              ],
            ),
          );
        }
      },
      child: _userProfile(),
    );
  }

  Widget _userProfile() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 20.0),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.green,
              child: Text(userName[0].toUpperCase(),
                  style: const TextStyle(fontSize: 30.0, color: Colors.white)),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  userName.replaceFirst(userName[0], userName[0].toUpperCase()),
                  style: const TextStyle(fontSize: 25.0, color: Colors.white)),
              const Divider(
                height: 5,
              ),
              Text(userEmail,
                  style: const TextStyle(fontSize: 15.0, color: Colors.white)),
            ],
          ),
        ],
      );
}
