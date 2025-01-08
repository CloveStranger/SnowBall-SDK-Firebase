import 'package:logger/logger.dart';

import '../../../snowball_sdk_firebase.dart';

class SnowballEventTrack {
  static final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      printEmojis: false,
    ),
  );

  static void _log(dynamic msg) {
    logger.i('📝Snowball Event Easy Track:$msg');
  }

  static void basicLog(String key, Map<String, dynamic> value) {
    _log('$key: $value');
    SnowballAnalytics().logEvent(name: key, parameters: value);
  }

  static void testLog() {
    _log('test');
  }
}
