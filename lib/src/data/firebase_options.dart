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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB9ukUvOTm9DsgDhktIWVh1KulYcaGmZqU',
    appId: '1:671880926521:android:e7e10e3be18a7f37c384e8',
    messagingSenderId: '671880926521',
    projectId: 'chat-app-cdc16',
    databaseURL: 'https://chat-app-cdc16-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'chat-app-cdc16.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyARuJb1qiAUE5YJ6X3be9w8700lDiiulk4',
    appId: '1:671880926521:ios:e96985f244b388acc384e8',
    messagingSenderId: '671880926521',
    projectId: 'chat-app-cdc16',
    databaseURL: 'https://chat-app-cdc16-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'chat-app-cdc16.appspot.com',
    iosBundleId: 'dev.takhirov.chatApplicationWithFirebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyARuJb1qiAUE5YJ6X3be9w8700lDiiulk4',
    appId: '1:671880926521:ios:1d349172b4e5cc75c384e8',
    messagingSenderId: '671880926521',
    projectId: 'chat-app-cdc16',
    databaseURL: 'https://chat-app-cdc16-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'chat-app-cdc16.appspot.com',
    iosBundleId: 'dev.takhirov.chatApplicationWithFirebase.RunnerTests',
  );
}
