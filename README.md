[![Codemagic build status](https://api.codemagic.io/apps/5e93249b1838ac3d3e52a5bc/5e93249b1838ac3d3e52a5bb/status_badge.svg)](https://codemagic.io/apps/5e93249b1838ac3d3e52a5bc/5e93249b1838ac3d3e52a5bb/latest_build)
[![codecov](https://codecov.io/gh/CoderJava/Flutter-News-App/branch/dev-v2.0.0/graph/badge.svg)](https://codecov.io/gh/CoderJava/Flutter-News-App)
[![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://github.com/tenhobi/effective_dart)

# Flutter News App
News App developed with Flutter and API from [News API](https://newsapi.org)

## How to use
Please open file **api_provider.dart** and change `YOUR_API_KEY` in the variable `_baseUrl` with your own.

## Technology
1. BLoC<br />
BLoC (Business Logic Component) is design pattern helps to separate *presentation* from *business logic*.
2. Dio<br />
A powerful HTTP client for Dart, which supports interceptors, FormData, Request Cancellation, File Downloading, Timeout, etc.
3. JSON Serializable<br />
Automatically generate code for converting to and from JSON by annotating Dart classes.
4. Intl<br />
Plugin to provides internalization and localization facilities, including message translation, plurals and genders, date/number formatting and parsing, and bidirectional text.
5. Url Launcher<br />
Flutter plugin for launching a URL on Android and iOS.
6. Build Runner<br />
Package to provides a concrete way of generating files using Dart code, outside of tools like `pub server/build`, files are always generated directly on disk, and rebuilds are *incremental-* inspired by tools such as Bazel.

![News App](https://github.com/CoderJava/Flutter-News-App/blob/master/screenshots/output_app.png)
