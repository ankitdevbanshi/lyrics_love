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
    apiKey: 'AIzaSyDHi2nYdyNdddkWZufz4aY_AYADVPmxr-Y',
    appId: '1:344126358722:web:b6138e3ba5ecc3c3c0e75b',
    messagingSenderId: '344126358722',
    projectId: 'lyrics-2834d',
    authDomain: 'lyrics-2834d.firebaseapp.com',
    storageBucket: 'lyrics-2834d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB5guQ324svA_OB6j01vre-L9Uwc0WOiBs',
    appId: '1:344126358722:android:23c87e3780eceac7c0e75b',
    messagingSenderId: '344126358722',
    projectId: 'lyrics-2834d',
    storageBucket: 'lyrics-2834d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAF79qNwgdB7etSs1UZc0CMeuAGUMAlvFk',
    appId: '1:344126358722:ios:8270972dc95bb1f2c0e75b',
    messagingSenderId: '344126358722',
    projectId: 'lyrics-2834d',
    storageBucket: 'lyrics-2834d.appspot.com',
    iosBundleId: 'com.example.lyricsLove',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAF79qNwgdB7etSs1UZc0CMeuAGUMAlvFk',
    appId: '1:344126358722:ios:70705967fecf0aa3c0e75b',
    messagingSenderId: '344126358722',
    projectId: 'lyrics-2834d',
    storageBucket: 'lyrics-2834d.appspot.com',
    iosBundleId: 'com.example.lyricsLove.RunnerTests',
  );
}