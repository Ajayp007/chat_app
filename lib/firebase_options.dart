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
    apiKey: 'AIzaSyCR3y_H3waOi1irWqG6WyHvQxwU1Yj-tUM',
    appId: '1:548078730305:web:f5b74fa1f5b51d24d49ac0',
    messagingSenderId: '548078730305',
    projectId: 'chatapp-c86fc',
    authDomain: 'chatapp-c86fc.firebaseapp.com',
    storageBucket: 'chatapp-c86fc.appspot.com',
    measurementId: 'G-7LQ98EN1ES',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBCFYNqKfU1vrPO3n_G2x1djqAs9LHxvdo',
    appId: '1:548078730305:android:d568cffbad3b1bedd49ac0',
    messagingSenderId: '548078730305',
    projectId: 'chatapp-c86fc',
    storageBucket: 'chatapp-c86fc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD8TAvJKvoiUvLqwWjmcn6EDyLKs3wVito',
    appId: '1:548078730305:ios:329422bcebed28ebd49ac0',
    messagingSenderId: '548078730305',
    projectId: 'chatapp-c86fc',
    storageBucket: 'chatapp-c86fc.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD8TAvJKvoiUvLqwWjmcn6EDyLKs3wVito',
    appId: '1:548078730305:ios:329422bcebed28ebd49ac0',
    messagingSenderId: '548078730305',
    projectId: 'chatapp-c86fc',
    storageBucket: 'chatapp-c86fc.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCR3y_H3waOi1irWqG6WyHvQxwU1Yj-tUM',
    appId: '1:548078730305:web:b93c688d8c356463d49ac0',
    messagingSenderId: '548078730305',
    projectId: 'chatapp-c86fc',
    authDomain: 'chatapp-c86fc.firebaseapp.com',
    storageBucket: 'chatapp-c86fc.appspot.com',
    measurementId: 'G-FJYG4SVEM8',
  );
}
