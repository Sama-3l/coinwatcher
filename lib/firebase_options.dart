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
    apiKey: 'AIzaSyC9T2jEFoqwo45jLcDhqUpn_kFiYuX36c4',
    appId: '1:1041756226762:web:a096bfd7d43d6b451f2033',
    messagingSenderId: '1041756226762',
    projectId: 'coinwatcher-91276',
    authDomain: 'coinwatcher-91276.firebaseapp.com',
    storageBucket: 'coinwatcher-91276.appspot.com',
    measurementId: 'G-2XZ5WDGGR2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBVqiEG1PS901rtmwfGUOPSk1YSbEv9tLw',
    appId: '1:1041756226762:android:7491518aeaa31a671f2033',
    messagingSenderId: '1041756226762',
    projectId: 'coinwatcher-91276',
    storageBucket: 'coinwatcher-91276.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB7ay8NzNlzCUbx69kuGgnmWsFglZbFMMg',
    appId: '1:1041756226762:ios:a89f2e99a9ac72fc1f2033',
    messagingSenderId: '1041756226762',
    projectId: 'coinwatcher-91276',
    storageBucket: 'coinwatcher-91276.appspot.com',
    iosClientId: '1041756226762-0fq9vb0i1vd38ejm64clprihgirg8g4j.apps.googleusercontent.com',
    iosBundleId: 'com.samael.coinwatcher',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB7ay8NzNlzCUbx69kuGgnmWsFglZbFMMg',
    appId: '1:1041756226762:ios:a0a9ed9f5b31d8951f2033',
    messagingSenderId: '1041756226762',
    projectId: 'coinwatcher-91276',
    storageBucket: 'coinwatcher-91276.appspot.com',
    iosClientId: '1041756226762-3rpg90k352bgaf1phts0u2bmaegaiivh.apps.googleusercontent.com',
    iosBundleId: 'com.example.coinwatcher',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC9T2jEFoqwo45jLcDhqUpn_kFiYuX36c4',
    appId: '1:1041756226762:web:7283a007b4f0ab121f2033',
    messagingSenderId: '1041756226762',
    projectId: 'coinwatcher-91276',
    authDomain: 'coinwatcher-91276.firebaseapp.com',
    storageBucket: 'coinwatcher-91276.appspot.com',
    measurementId: 'G-2529WE0JCM',
  );

}