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
    apiKey: 'AIzaSyBqpnRtvOZm9VCNMzNZ8y8WU29bT4GKN8Q',
    appId: '1:335785632147:web:2681d2c68316d891b7c866',
    messagingSenderId: '335785632147',
    projectId: 'search-test-api',
    authDomain: 'search-test-api.firebaseapp.com',
    storageBucket: 'search-test-api.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDLruB0lPwB-pG2Sgv8bQpyerNIogf2Avw',
    appId: '1:335785632147:android:5f507cab49fe97b1b7c866',
    messagingSenderId: '335785632147',
    projectId: 'search-test-api',
    storageBucket: 'search-test-api.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAT7QfxmrACL54a1V-zdezqVHZK3yACbsQ',
    appId: '1:335785632147:ios:885f20ad7daad0feb7c866',
    messagingSenderId: '335785632147',
    projectId: 'search-test-api',
    storageBucket: 'search-test-api.appspot.com',
    iosClientId: '335785632147-hb5vj2i8hmjb10s152ik55acq3kddrt7.apps.googleusercontent.com',
    iosBundleId: 'com.example.searchTestApi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAT7QfxmrACL54a1V-zdezqVHZK3yACbsQ',
    appId: '1:335785632147:ios:c377ff2b3809e900b7c866',
    messagingSenderId: '335785632147',
    projectId: 'search-test-api',
    storageBucket: 'search-test-api.appspot.com',
    iosClientId: '335785632147-bidulejn5vtpckqffupg7msc5h42nhho.apps.googleusercontent.com',
    iosBundleId: 'com.example.searchTestApi.RunnerTests',
  );
}