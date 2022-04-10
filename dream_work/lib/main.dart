import 'package:dream_work/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        initialRoute: Routing.calendar,
        routes: Routing.router());
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
