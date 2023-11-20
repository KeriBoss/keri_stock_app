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
    apiKey: 'AIzaSyDlYc9IRBfqrnI1MT7v3gZ8byTvaC_Irjk',
    appId: '1:277467892045:web:0c0567c0cf379c36818f04',
    messagingSenderId: '277467892045',
    projectId: 'keri-stock',
    authDomain: 'keri-stock.firebaseapp.com',
    storageBucket: 'keri-stock.appspot.com',
    measurementId: 'G-XLZMJDPSQD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCSpq6W6HY_ns4OTtLfITkLbrfzleSeL6w',
    appId: '1:277467892045:android:d2289388ec5ab4ac818f04',
    messagingSenderId: '277467892045',
    projectId: 'keri-stock',
    storageBucket: 'keri-stock.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAWym58QzorxgTG-MgYtap8GNlbTDEHTvo',
    appId: '1:277467892045:ios:612f34698309ee19818f04',
    messagingSenderId: '277467892045',
    projectId: 'keri-stock',
    storageBucket: 'keri-stock.appspot.com',
    iosBundleId: 'com.example.stockMarketProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAWym58QzorxgTG-MgYtap8GNlbTDEHTvo',
    appId: '1:277467892045:ios:2bfe40f249c01822818f04',
    messagingSenderId: '277467892045',
    projectId: 'keri-stock',
    storageBucket: 'keri-stock.appspot.com',
    iosBundleId: 'com.example.stockMarketProject.RunnerTests',
  );
}