// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAqMmYgf00OVc6equ6AXXsW9zo89fbxtzQ',
    appId: '1:758124052811:web:4bf7e0c84dbf1a463c68ce',
    messagingSenderId: '758124052811',
    projectId: 'flutter-news-8c3d7',
    authDomain: 'flutter-news-8c3d7.firebaseapp.com',
    storageBucket: 'flutter-news-8c3d7.appspot.com',
    measurementId: 'G-86630CTV89',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAEHB3CU5jRzUFhYKvhVbWxWf5RmsGIV-k',
    appId: '1:758124052811:android:f434793e0805ce4b3c68ce',
    messagingSenderId: '758124052811',
    projectId: 'flutter-news-8c3d7',
    storageBucket: 'flutter-news-8c3d7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA_gK5e9tys4srJ_rw-4wQ_Dp_PQ7zcwBg',
    appId: '1:758124052811:ios:2dd4583dd48a59843c68ce',
    messagingSenderId: '758124052811',
    projectId: 'flutter-news-8c3d7',
    storageBucket: 'flutter-news-8c3d7.appspot.com',
    iosClientId: '758124052811-bsgc75rn2qng5vfsqhdi6hq3vpagtcu7.apps.googleusercontent.com',
    iosBundleId: 'com.ysn.flutterNewsApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA_gK5e9tys4srJ_rw-4wQ_Dp_PQ7zcwBg',
    appId: '1:758124052811:ios:2dd4583dd48a59843c68ce',
    messagingSenderId: '758124052811',
    projectId: 'flutter-news-8c3d7',
    storageBucket: 'flutter-news-8c3d7.appspot.com',
    iosClientId: '758124052811-bsgc75rn2qng5vfsqhdi6hq3vpagtcu7.apps.googleusercontent.com',
    iosBundleId: 'com.ysn.flutterNewsApp',
  );
}