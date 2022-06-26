import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/app.dart';
import 'package:flutter_news_app/config/base_url_config.dart';
import 'package:flutter_news_app/config/flavor_config.dart';
import 'package:flutter_news_app/core/util/constant_value.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final constantColor = ConstantColor();
  final baseUrlConfig = BaseUrlConfig();
  FlavorConfig(
    flavor: Flavor.development,
    colorPrimary: constantColor.primaryColor500,
    colorAccent: constantColor.accentColor,
    colorPrimaryDark: constantColor.primaryColor900,
    colorPrimaryLight: constantColor.primaryColor50,
    values: FlavorValues(
      baseUrlNewsEndpoint: baseUrlConfig.baseUrlNewsProduction + baseUrlConfig.prefixNewsEndpointV2,
    ),
  );
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('id', 'ID'),
      ],
      path: 'assets/translations',
      child: const App(),
    ),
  );
}
