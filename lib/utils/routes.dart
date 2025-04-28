import 'package:flutter/material.dart';

class Routes {
  static const String splash = '/';
  static const String roleSelection = '/role-selection';
  static const String login = '/login';
  static const String register = '/register';
  static const String citizenHome = '/citizen-home';
  static const String officerHome = '/officer-home';
  static const String authorityHome = '/authority-home';
}

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {


      // Routes will be implemented when creating the views
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );


    }
  }
} 