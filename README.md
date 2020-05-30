[![Codemagic build status](https://api.codemagic.io/apps/5e93249b1838ac3d3e52a5bc/5e93249b1838ac3d3e52a5bb/status_badge.svg)](https://codemagic.io/apps/5e93249b1838ac3d3e52a5bc/5e93249b1838ac3d3e52a5bb/latest_build)
[![codecov](https://codecov.io/gh/CoderJava/Flutter-News-App/branch/dev-v2.0.0/graph/badge.svg)](https://codecov.io/gh/CoderJava/Flutter-News-App)
[![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://github.com/tenhobi/effective_dart)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

![Flutter News App](https://github.com/CoderJava/Flutter-News-App/blob/master/screenshots/social%20media%20preview.png)

# Flutter News App
News App developed with Flutter and API from [News API](https://newsapi.org)

## Versions
For Flutter News App v1, you can check this [repository](https://github.com/CoderJava/Flutter-News-App/tree/v1.0.0).

## Usage
1. Please open file **constant_config.dart** and change `YOUR API KEY` in the variable `keyNewsApi` with your own.
2. In development mode, I'm used fake json server. So, the data is not realtime. 
3. Build flavor only work for Android. So, if you want to run as development mode you can use this command.
```
flutter run -t lib/main_development.dart --flavor development -d <device_id>
```
or in production mode.
```
flutter run --release -t lib/main_production.dart --flavor production -d <device_id>
```
*Note: If you want to build and release this app to Play Store. Please use this command.*
```
flutter build appbundle --release --flavor production -t lib/main_production.dart
```
4. For iOS, you can use this command as development mode.
```
flutter run -t lib/main_development.dart -d <device_id>
```
or in production mode.
```
flutter run --release -t lib/main_production.dart -d <device_id>
```
For iOS, to build and release there is no configuration. Just follow the instructions from the [documentation](https://flutter.dev/docs/deployment/ios).

## Feature
- [X] List daily news.
- [X] Filter daily news by category.
- [X] Refresh list daily news with pull to refresh style.
- [X] Go to detail news website.
- [X] Search news.
- [X] Dark mode support.

## Technology
1. Dio<br />
A powerful Http client for Dart, which supports interceptors, FormData, Request Cancellation, File Downloading, Timeout, etc.
2. Flutter BLoC<br />
Flutter widgets that make it easy to implement the BLoC design pattern.
3. Intl<br />
Package providers internationalization and localization facilities, including message translation, plurals and genders, date/number formatting and parsing, and bidirectional text.
4. Url Launcher<br />
Flutter plugin for launching a URL in the mobile platform. Supports iOS and Android.
5. Cached Network Image<br />
Flutter library to load and cache network images. Can also be used with placeholder and error widgets.
6. Get It<br />
Simple direct Service Locator that allows to decouple the interface from a concrete implementation and to access the concrete implementation from everywhere in your App.
7. Dartz<br />
Functional Programming in Dart. Purify your Dart code using efficient immutable data structures, monads, lenses and other FP tools.
8. Equatable<br />
An abstract class that helps to implement equality without needing to explicitly override == and hashCode.
9. Data Connection Checker<br />
A pure Dart library that checks for internet by opening a socket to a list of specified addresses, each with individual port and timeout.
10. Flutter ScreenUtil<br />
A Flutter plugin for adapting screen and font size.
11. Pedantic<br />
How to get the most value from Dart static analysis.
12. Device Info<br />
Flutter plugin providing detailed information about the device (make, model, etc).
13. Flutter SVG<br />
An SVG rendering and widget library for Flutter, which allows painting and displaying Scalable Vector Graphics 1.1 files.
14. Build Runner<br />
Tools to write binaries that run builders.
15. Mockito<br />
A mock framework inspired by Mockito.
16. Bloc Test<br />
A testing library which makes it easy to test blocs.
17. JSON Serializable<br />
Automatically generate code for converting to and from JSON by annotating Dart classes.


![News App](https://github.com/CoderJava/Flutter-News-App/blob/master/screenshots/output_app_v2.png)
