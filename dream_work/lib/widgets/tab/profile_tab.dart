import 'package:flutter/material.dart';
import '../../dream_connector/dream_connector.dart';
import '../widgets.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final BorderRadiusGeometry borderRadius = BorderRadius.circular(20);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _authTag(),
        const GeneralCard(
          height: 200,
        ),
        const GeneralCard(
          height: 200,
        ),
      ],
    );
  }

  Widget _authTag() => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: StreamBuilder(
          stream: DreamAuth.instance.authState,
          builder: (BuildContext context, AsyncSnapshot snap) {
            return snap.data == null
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.greenAccent,
                    ),
                  )
                : ProfileCard(
                    userEmail: snap.data['email'] ?? '',
                    userName: snap.data['name'] ?? '',
                    showLogout: true,
                  );
          },
        ),
      );
}

Widget _divider() => const Divider(
      height: 30,
      color: Colors.white,
    );
