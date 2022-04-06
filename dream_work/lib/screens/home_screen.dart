// ignore_for_file: constant_identifier_names
import '../dream_connector/dream_connector.dart';
import 'package:flutter/material.dart';
import '../router.dart';
import '../widgets/widgets.dart';
import '../utils/utils.dart';
import 'auth_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const _tabPages = <Widget>[
    TeamTab(),
    CalenderTab(),
    ProfileTab(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabPages.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DreamDatabase.instance.connect();

    return Scaffold(
      appBar: _appbar(context),
      body: SizedBox(
        child: Stack(
          alignment: Alignment.center,
          children: [
            TabBarView(
              controller: _tabController,
              children: _tabPages,
            ),
            NavBar(tabController: _tabController),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _appbar(BuildContext context) => AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 9.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                monthAndDayToString(),
                style: const TextStyle(fontSize: 25),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: StreamBuilder(
                  stream: DreamDatabase.instance.connectState,
                  builder: (context, AsyncSnapshot snap) {
                    if (snap.data == null) {
                      return const Icon(
                        Icons.cloud_circle,
                        color: Colors.red,
                        size: 15,
                      );
                    }
                    return const Icon(
                      Icons.cloud_circle,
                      color: Colors.green,
                      size: 15,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        elevation: 12,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // todo add a real action for search
            },
          ),
          StreamBuilder(
            stream: DreamDatabase.instance.loadingState,
            builder: (context, AsyncSnapshot snap) {
              return AddButton(
                isLoading: snap.data ?? true,
                onPressed: () {
                  createSection();
                },
              );
            },
          ),
        ],
      );
}
