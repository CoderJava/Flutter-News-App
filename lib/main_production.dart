import 'package:flutter/material.dart';
import 'package:flutter_news_app/app.dart';
import 'package:flutter_news_app/config/base_url_config.dart';
import 'package:flutter_news_app/config/flavor_config.dart';
import 'package:flutter_news_app/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(
    flavor: Flavor.PRODUCTION,
    values: FlavorValues(baseUrl: BaseUrlConfig().baseUrlProduction),
  );
  await di.init();
  runApp(App());
}