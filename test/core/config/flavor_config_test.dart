import 'package:flutter_news_app/config/flavor_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tBaseUrlNewsEndpoint = 'testBaseUrlNewsEndpoint';
  final values = FlavorValues(
    baseUrlNewsEndpoint: tBaseUrlNewsEndpoint,
  );

  test(
    'Should return true while call the function isProduction with flavor production',
    () async {
      // arrange
      FlavorConfig(
        flavor: Flavor.production,
        values: values,
      );

      // act
      final result = FlavorConfig.isProduction();

      // assert
      expect(result, true);
    },
  );

  test(
    'Should return false while call the function isProduction with flavor development',
    () async {
      // arrange
      FlavorConfig(
        flavor: Flavor.development,
        values: values,
      );

      // act
      final result = FlavorConfig.isProduction();

      // assert
      expect(result, false);
    },
  );

  test(
    'Should return false while call the function isDevelopment with flavor production',
    () async {
      // arrange
      FlavorConfig(
        flavor: Flavor.production,
        values: values,
      );

      // act
      final result = FlavorConfig.isDevelopment();

      // assert
      expect(result, false);
    },
  );

  test(
    'Should return true while call the function isProduction with flavor development',
    () async {
      // arrange
      FlavorConfig(
        flavor: Flavor.development,
        values: values,
      );

      // act
      final result = FlavorConfig.isDevelopment();

      // assert
      expect(result, true);
    },
  );
}