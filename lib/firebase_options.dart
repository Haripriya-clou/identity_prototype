import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyAEU0EiGCBumjbovFvrLpv9Pmfk4iK3O-Y',
    appId: '1:1033926027135:web:default', // dummy
    messagingSenderId: '1033926027135',
    projectId: 'verishield-e93e8',
    authDomain: 'verishield-e93e8.firebaseapp.com',
    storageBucket: 'verishield-e93e8.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAEU0EiGCBumjbovFvrLpv9Pmfk4iK3O-Y',
    appId: '1:1033926027135:android:32e06c5980b86266f85c4a',
    messagingSenderId: '1033926027135',
    projectId: 'verishield-e93e8',
    storageBucket: 'verishield-e93e8.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAEU0EiGCBumjbovFvrLpv9Pmfk4iK3O-Y',
    appId: '1:1033926027135:ios:default', // dummy
    messagingSenderId: '1033926027135',
    projectId: 'verishield-e93e8',
    storageBucket: 'verishield-e93e8.firebasestorage.app',
  );
}