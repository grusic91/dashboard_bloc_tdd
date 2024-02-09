// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

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
      // ignore: no_default_cases
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCrwwQjvtx3fiB2_o3HzwgmDCHvEqvE1go',
    appId: '1:187265218475:web:d19d584d4fd308c55484ee',
    messagingSenderId: '187265218475',
    projectId: 'dashboard-bloc-app',
    authDomain: 'dashboard-bloc-app.firebaseapp.com',
    storageBucket: 'dashboard-bloc-app.appspot.com',
    measurementId: 'G-H63Y3RMHTW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMViaPOjDZ9hGf_cda-2u-GYqyBDhA16E',
    appId: '1:187265218475:android:2734ba2d634a6c905484ee',
    messagingSenderId: '187265218475',
    projectId: 'dashboard-bloc-app',
    storageBucket: 'dashboard-bloc-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCLREwDDsUD7cKKshjO_Vfs7oD3omgG97g',
    appId: '1:187265218475:ios:43198c36d11b97515484ee',
    messagingSenderId: '187265218475',
    projectId: 'dashboard-bloc-app',
    storageBucket: 'dashboard-bloc-app.appspot.com',
    iosBundleId: 'com.example.dashboardBlocTdd',
  );
}