import 'package:flutter/widgets.dart';
import 'screens/screens.dart';

class Routing {
  static const String home = '/';
  static const String auth = '/Auth';
  static const String individual = '/Individual';

  static Map<String, Widget Function(BuildContext)> router() {
    return {
      auth: (context) => const AuthScreen(),
      home: (context) => const HomeScreen(),
      individual: (context) => const IndividualScreen(),
    };
  }
}
