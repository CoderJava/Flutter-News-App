import 'package:flutter/material.dart';

enum Flavor {
  DEVELOPMENT,
  PRODUCTION,
}

class FlavorValues {
  String baseUrlEndpoint;

  FlavorValues({
    required this.baseUrlEndpoint,
  });
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final MaterialColor colorPrimary;
  final Color colorAccent;
  final FlavorValues values;

  static late FlavorConfig _instance;

  factory FlavorConfig({
    required Flavor flavor,
    MaterialColor colorPrimary = Colors.blue,
    Color colorAccent = Colors.blue,
    required FlavorValues values,
  }) {
    _instance = FlavorConfig._internal(
      flavor,
      enumName(flavor.toString()),
      colorPrimary,
      colorAccent,
      values,
    );
    return _instance;
  }

  FlavorConfig._internal(
    this.flavor,
    this.name,
    this.colorPrimary,
    this.colorAccent,
    this.values,
  );

  static FlavorConfig get instance => _instance;

  static String enumName(String enumToString) {
    final paths = enumToString.split('.');
    return paths[paths.length - 1];
  }
}
