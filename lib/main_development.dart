import 'package:flutter/material.dart';
import 'package:flutter_news_app/app.dart';
import 'package:flutter_news_app/config/base_url_config.dart';
import 'package:flutter_news_app/config/flavor_config.dart';
import 'package:flutter_news_app/injection_container.dart' as di;
import 'package:flutter_stetho/flutter_stetho.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(
    flavor: Flavor.DEVELOPMENT,
    values: FlavorValues(baseUrl: BaseUrlConfig().baseUrlDevelopment),
  );
  await di.init();
  await Stetho.initialize();
  runApp(App());
}