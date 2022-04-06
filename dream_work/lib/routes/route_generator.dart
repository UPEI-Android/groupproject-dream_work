

import 'package:dream_work/routes/unknown_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../screens/auth_screen.dart';
import '../screens/calendar_screen.dart';
import '../screens/home_screen.dart';
import '../screens/individual_screen.dart';


class RouteGenerator {

  static const String homeScreen = '/home';
  static const String authScreen = '/welcome';
  static const String individualScreen = '/individual';
  static const String calendarScreen = '/calendar';


  //private constructor
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case authScreen:
        return MaterialPageRoute(
          builder: (_) => const AuthScreen(),
        );
      case individualScreen:
        return MaterialPageRoute(
          builder: (_) => const IndividualScreen(),
        );
      case calendarScreen:
        return MaterialPageRoute(
          builder: (_) => const CalendarScreen(),
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