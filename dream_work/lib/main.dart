import 'package:flutter/material.dart';
import 'screens/screens.dart';
import '../dream_connector/dreamConnector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dream Work',
      theme: ThemeData(
        primarySwatch: colorCustom,
        scaffoldBackgroundColor: colorCustom,
        fontFamily: 'Nunito',
      ),
      initialRoute: HomeScreen.routeName,
      routes: {
        AuthScreen.routeName: (context) => const AuthScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        IndividualScreen.routeName: (context) => const IndividualScreen(),
      },
    );
  }
}

Map<int, Color> customColor = {
  50: const Color.fromARGB(25, 12, 15, 33),
  100: const Color.fromARGB(50, 12, 15, 33),
  200: const Color.fromARGB(75, 12, 15, 33),
  300: const Color.fromARGB(100, 12, 15, 33),
  400: const Color.fromARGB(125, 12, 15, 33),
  500: const Color.fromARGB(150, 12, 15, 33),
  600: const Color.fromARGB(175, 12, 15, 33),
  700: const Color.fromARGB(200, 12, 15, 33),
  800: const Color.fromARGB(225, 12, 15, 33),
  900: const Color.fromARGB(255, 12, 15, 33),
};

MaterialColor colorCustom = MaterialColor(0xFF121536, customColor);
