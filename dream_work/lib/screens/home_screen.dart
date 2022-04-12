// ignore_for_file: constant_identifier_names
import 'package:dream_work/dream_connector/utils/utils.dart';
import 'package:dream_work/screens/calendar_screen.dart';
import 'package:flutter/services.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../dream_connector/dream_connector.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;
  static List<Widget> _tabPages = <Widget>[
    TeamTab(search: ''),
    CalenderTab(),
    CalendarScreen(),
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


  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar =  Padding(
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
  );

  PreferredSizeWidget _appbar(BuildContext context) => AppBar(
        automaticallyImplyLeading: false,
        title: customSearchBar,
        elevation: 12,

        actions: [
          IconButton(
            icon: customIcon,
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  customIcon = const Icon(Icons.cancel);
                  customSearchBar = ListTile(
                    leading: const Icon(
                      Icons.search,
                      size: 28,
                    ),
                    title: TextField(
                    decoration: const InputDecoration(
                    hintText: 'search for a task',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                    border: InputBorder.none,
                  ),
                   onSubmitted: (String query) {
                     setState(() {
                       _tabPages = <Widget>[
                         TeamTab(search: query),
                         const CalenderTab(),
                         const CalendarScreen(),
                         const ProfileTab(),
                       ];
                     });
                   }
                )
                  );
                } else {
                  setState(() {
                    _tabPages = <Widget>[
                      const TeamTab(search: ''),
                      const CalenderTab(),
                      const CalendarScreen(),
                      const ProfileTab(),
                    ];
                  });
                  customIcon = const Icon(Icons.search);
                  customSearchBar = Padding(
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
                  );
                }
              });
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
