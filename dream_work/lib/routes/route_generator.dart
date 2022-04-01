

import 'package:dream_work/domain/model/individual.dart';
import 'package:dream_work/routes/unknown_screen.dart';
import 'package:dream_work/screens/home_screen.dart';
import 'package:dream_work/screens/individual_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../screens/auth_screen.dart';


class RouteGenerator {

  static const String auth_screen = '/welcome';
  static const String home_screen = '/home';
  static const String individual_screen = '/individual';

  //private constructor
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case auth_screen:
        return MaterialPageRoute(
          builder: (_) => const AuthScreen(),
        );
      case home_screen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case individual_screen:
        return MaterialPageRoute(
          builder: (_) => const IndividualScreen(),
        );
    }
    if(kDebugMode) {
      return MaterialPageRoute(builder: (context) =>  const UnknownScreen());
    }
    else {
      return MaterialPageRoute(builder: (context) => const AuthScreen());
    }
  }

}