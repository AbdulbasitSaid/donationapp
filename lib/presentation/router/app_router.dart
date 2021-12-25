import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._();
  static MaterialPageRoute<dynamic> routeToPage(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
