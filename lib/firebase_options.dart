// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDB1J9-8jd3kWPFEDwZTOnvQlCgqkzfMBE',
    appId: '1:762714433094:web:f9e73d2d79aa61b9fa8c47',
    messagingSenderId: '762714433094',
    projectId: 'coinwise-7816b',
    authDomain: 'coinwise-7816b.firebaseapp.com',
    storageBucket: 'coinwise-7816b.appspot.com',
    measurementId: 'G-5FJTLWLT1F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBnHluaObMDwcyJXnev2AekK17o12syl88',
    appId: '1:762714433094:android:29db7668794bc9fbfa8c47',
    messagingSenderId: '762714433094',
    projectId: 'coinwise-7816b',
    storageBucket: 'coinwise-7816b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD763qp67OiI_0D39tVVlDyd3qkIZ2McA8',
    appId: '1:762714433094:ios:f2e699d5594c6c94fa8c47',
    messagingSenderId: '762714433094',
    projectId: 'coinwise-7816b',
    storageBucket: 'coinwise-7816b.appspot.com',
    iosBundleId: 'com.example.coinwise',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD763qp67OiI_0D39tVVlDyd3qkIZ2McA8',
    appId: '1:762714433094:ios:f2e699d5594c6c94fa8c47',
    messagingSenderId: '762714433094',
    projectId: 'coinwise-7816b',
    storageBucket: 'coinwise-7816b.appspot.com',
    iosBundleId: 'com.example.coinwise',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDB1J9-8jd3kWPFEDwZTOnvQlCgqkzfMBE',
    appId: '1:762714433094:web:8ea1a98a51c50fc7fa8c47',
    messagingSenderId: '762714433094',
    projectId: 'coinwise-7816b',
    authDomain: 'coinwise-7816b.firebaseapp.com',
    storageBucket: 'coinwise-7816b.appspot.com',
    measurementId: 'G-MQ4155XLP5',
  );
}
