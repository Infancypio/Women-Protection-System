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
    apiKey: 'AIzaSyB8uyRo6oxROYudS9Vz0W8V9W061r2NeyY',
    appId: '1:101031538271:web:a4acf573b8ba8c526675ea',
    messagingSenderId: '101031538271',
    projectId: 'women-protection-79b65',
    authDomain: 'women-protection-79b65.firebaseapp.com',
    storageBucket: 'women-protection-79b65.appspot.com',
    measurementId: 'G-0M8Z7R297S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMnEZoZQpS4PIUntXFXI_v7KHhUtO4xeo',
    appId: '1:101031538271:android:90a59f8a0199cf9f6675ea',
    messagingSenderId: '101031538271',
    projectId: 'women-protection-79b65',
    storageBucket: 'women-protection-79b65.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAzUMUqZmK0IPQZlGe3Win14-fXl0HrZ80',
    appId: '1:101031538271:ios:5704d8dfa491ef4f6675ea',
    messagingSenderId: '101031538271',
    projectId: 'women-protection-79b65',
    storageBucket: 'women-protection-79b65.appspot.com',
    iosBundleId: 'com.example.womenSafetyApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAzUMUqZmK0IPQZlGe3Win14-fXl0HrZ80',
    appId: '1:101031538271:ios:5704d8dfa491ef4f6675ea',
    messagingSenderId: '101031538271',
    projectId: 'women-protection-79b65',
    storageBucket: 'women-protection-79b65.appspot.com',
    iosBundleId: 'com.example.womenSafetyApp',
  );
}
