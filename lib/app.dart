import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_news_app/config/flavor_config.dart';
import 'package:flutter_news_app/core/route/app_route.dart';
import 'package:flutter_news_app/feature/presentation/page/splash/splash_page.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: FlavorConfig.instance.flavor == Flavor.development,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFFFFC63F,
          <int, Color>{
            50: Color(0xFFFFF9E4),
            100: Color(0xFFFFEDBA),
            200: Color(0xFFFFE28F),
            300: Color(0xFFFFD864),
            400: Color(0xFFFFCE4A),
            500: Color(0xFFFFC63F),
            600: Color(0xFFFFB83A),
            700: Color(0xFFFFA636),
            800: Color(0xFFFE9734),
            900: Color(0xFFFB7A30),
          },
        ),
      ),
      title: FlavorConfig.instance.flavor == Flavor.development ? 'Dev FNews' : 'FNews',
      home: const SplashPage(),
      onGenerateRoute: (RouteSettings settings) => AppRoute.onGenerateRoute(settings),
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (Platform.isIOS) {
              hideSoftKeyboard();
            }
          },
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          ),
        );
      },
    );
  }

  hideSoftKeyboard() {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
