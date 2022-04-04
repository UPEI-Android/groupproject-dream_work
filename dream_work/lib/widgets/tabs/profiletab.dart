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
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.greenAccent,
                    ),
                  )
                : Profile(
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
