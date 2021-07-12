import 'package:flutter/material.dart';
import 'package:flutter_news_app/app.dart';
import 'package:flutter_news_app/config/base_url_config.dart';
import 'package:flutter_news_app/config/flavor_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(
    flavor: Flavor.DEVELOPMENT,
    colorPrimary: Colors.blue,
    colorAccent: Colors.blue,
    values: FlavorValues(
      baseUrlEndpoint: BaseUrlConfig().baseUrlDevelopment,
    ),
  );
  runApp(App());
}
