import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   static const routeName = '/home';

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size; // size of the screen
//     return Scaffold(
//       backgroundColor: Colors.deepPurple,
//       body: SizedBox(
//         height: size.height,
//         width: double.infinity,
//         child: Stack(
//           alignment: Alignment.center,
//           children: const [
//             TodoList(),
//             NavBar(),
//           ],
//         ),
//       ),
//     );
//   }
// }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const _kTabPages = <Widget>[
    TodoList(),
    Center(child: Icon(Icons.alarm, size: 64.0, color: Colors.cyan)),
    Center(child: Icon(Icons.forum, size: 64.0, color: Colors.blue)),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _kTabPages.length,
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
      backgroundColor: Colors.deepPurple,
      body: SizedBox(
        child: Stack(
          alignment: Alignment.center,
          children: [
            TabBarView(
              controller: _tabController,
              children: _kTabPages,
            ),
            NavBar(tabController: _tabController),
          ],
        ),
      ),
    );
  }
}
