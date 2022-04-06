import 'package:flutter/widgets.dart';
import 'screens/screens.dart';

class Routing {
  static String home = '/';
  static String auth = '/Auth';
  static String individual = '/Individual';

  static Map<String, Widget Function(BuildContext)> router() {
    return {
      auth: (context) => const AuthScreen(),
      home: (context) => const HomeScreen(),
      individual: (context) => const IndividualScreen(),
    };
  }
}
