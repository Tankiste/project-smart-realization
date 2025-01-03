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
    apiKey: 'AIzaSyBwJcimKBrOP15uWQ6B9gPpCABgV1afnGs',
    appId: '1:94956581208:web:6f9a30c71d1a804fbdb52d',
    messagingSenderId: '94956581208',
    projectId: 'smart-house-91c04',
    authDomain: 'smart-house-91c04.firebaseapp.com',
    storageBucket: 'smart-house-91c04.firebasestorage.app',
    measurementId: 'G-3FG8V6P14H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB-AbvwBmK5QNJRgGLfofl_qp5lE7C-b28',
    appId: '1:94956581208:android:57cb8ea2353a7b2dbdb52d',
    messagingSenderId: '94956581208',
    projectId: 'smart-house-91c04',
    storageBucket: 'smart-house-91c04.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCxdnnBSy0kgAr67p7RCgFRTdbMoVj0rWM',
    appId: '1:94956581208:ios:391b5792fd8a1465bdb52d',
    messagingSenderId: '94956581208',
    projectId: 'smart-house-91c04',
    storageBucket: 'smart-house-91c04.firebasestorage.app',
    iosBundleId: 'com.example.smartHome',
  );
}
