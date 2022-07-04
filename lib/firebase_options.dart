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
    apiKey: 'AIzaSyAfGvy98yoiGvwTUEgB4-F5rEWDNrzsiCA',
    appId: '1:393506943603:web:1dba113de52ca570d97006',
    messagingSenderId: '393506943603',
    projectId: 'finalproject-mad-1117-1122',
    authDomain: 'finalproject-mad-1117-1122.firebaseapp.com',
    storageBucket: 'finalproject-mad-1117-1122.appspot.com',
    measurementId: 'G-SQJR0S0RDX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAubKmAIr3o8qw8ZIog4JmgcErmvPPvTPk',
    appId: '1:393506943603:android:235a07103b9e8265d97006',
    messagingSenderId: '393506943603',
    projectId: 'finalproject-mad-1117-1122',
    storageBucket: 'finalproject-mad-1117-1122.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCm8M2r2wqaVCjFaCGbBobqFcn4Ngw5seU',
    appId: '1:393506943603:ios:8f8ee38c43744cd0d97006',
    messagingSenderId: '393506943603',
    projectId: 'finalproject-mad-1117-1122',
    storageBucket: 'finalproject-mad-1117-1122.appspot.com',
    iosClientId: '393506943603-30ait998gvsrv1unga9r4bj9v5nv5hcl.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterScanner',
  );
}