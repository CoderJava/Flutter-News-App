import 'package:flutter/material.dart';

class AppRoute {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    Map<String, dynamic>? arguments;
    if (settings.arguments is Map<String, dynamic>?) {
      arguments = settings.arguments as Map<String, dynamic>?;
    }
    final routes = <String, WidgetBuilder>{};
    final builder = routes[settings.name];
    return MaterialPageRoute(
      builder: (context) => builder!(context),
      settings: settings,
    );
  }
}