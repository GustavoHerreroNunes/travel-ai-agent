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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyACYjNcXwpuqP0lMqqI3ksAwb1ducHjhf8',
    appId: '1:206847485070:web:af58637464737c226dd5df',
    messagingSenderId: '206847485070',
    projectId: 'travel-ai-agent',
    authDomain: 'travel-ai-agent.firebaseapp.com',
    storageBucket: 'travel-ai-agent.firebasestorage.app',
    measurementId: 'G-CBJ17Z9SH1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBUpcgGiQM5S7YGoKAcLBdNWfzJZXB4OgE',
    appId: '1:206847485070:android:4eff3cfe5b0d88eb6dd5df',
    messagingSenderId: '206847485070',
    projectId: 'travel-ai-agent',
    storageBucket: 'travel-ai-agent.firebasestorage.app',
  );

}