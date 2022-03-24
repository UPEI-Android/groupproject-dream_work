// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

enum Mounth {
  January,
  February,
  March,
  April,
  May,
  June,
  July,
  August,
  September,
  October,
  November,
  December
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const _tabPages = <Widget>[
    TeamTag(),
    Center(child: Icon(Icons.calendar_month, size: 64.0, color: Colors.blue)),
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
    return Scaffold(
      appBar: _appbar(),
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
}

PreferredSizeWidget _appbar() => AppBar(
      title: Text(_date4today()),
      elevation: 10,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // todo add a real action for search
          },
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            // todo add a real action for add
          },
        ),
      ],
    );

String _date4today() =>
    Mounth.values[DateTime.now().month - 1].toString().split('.').last +
    " " +
    DateTime.now().day.toString();
