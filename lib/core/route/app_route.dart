import 'package:flutter/material.dart';
import 'package:flutter_news_app/feature/presentation/page/dashboard/dashboard_page.dart';
import 'package:flutter_news_app/feature/presentation/page/login/login_page.dart';
import 'package:flutter_news_app/feature/presentation/page/splash/splash_page.dart';

class AppRoute {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    /*Map<String, dynamic>? arguments;
    if (settings.arguments is Map<String, dynamic>?) {
      arguments = settings.arguments as Map<String, dynamic>?;
    }*/
    final routes = <String, WidgetBuilder>{
      SplashPage.routeName: (context) {
        return const SplashPage();
      },
      LoginPage.routeName: (context) {
        return const LoginPage();
      },
      DashboardPage.routeName: (context) {
        return const DashboardPage();
      },
    };
    final builder = routes[settings.name];
    return MaterialPageRoute(
      builder: (context) => builder!(context),
      settings: settings,
    );
  }
}