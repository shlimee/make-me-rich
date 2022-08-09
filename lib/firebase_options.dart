import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDmyF7OkVQMbMb7UhEo04FHsrAy1nHN-w8',
    appId: '1:1062912859500:android:b70745e4f16a96f6d0e749',
    messagingSenderId: '1062912859500',
    projectId: 'makemerich-dec84',
    storageBucket: 'makemerich-dec84.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyALm5WBK0afPbzIrN9yFmjrxniyRrDnmZQ',
    appId: '1:1062912859500:ios:7b6784d941f82544d0e749',
    messagingSenderId: '1062912859500',
    projectId: 'makemerich-dec84',
    storageBucket: 'makemerich-dec84.appspot.com',
    iosClientId:
        '1062912859500-kcam0ofrqligjgkk629rp7mrf3uprv1j.apps.googleusercontent.com',
    iosBundleId: 'com.azsolcsak.makeMeRich',
  );
}
