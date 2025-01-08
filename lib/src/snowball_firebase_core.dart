import 'package:firebase_core/firebase_core.dart';

class SnowballFirebaseCore {
  factory SnowballFirebaseCore() {
    return SnowballFirebaseCore._makeInstance();
  }

  factory SnowballFirebaseCore._makeInstance() {
    _instance ??= SnowballFirebaseCore._();
    return _instance!;
  }

  SnowballFirebaseCore._();

  static SnowballFirebaseCore? _instance;

  static SnowballFirebaseCore get instance =>
      SnowballFirebaseCore._makeInstance();

  Future<void> init(FirebaseOptions firebaseOptions) async {
    await Firebase.initializeApp(options: firebaseOptions);
  }
}
