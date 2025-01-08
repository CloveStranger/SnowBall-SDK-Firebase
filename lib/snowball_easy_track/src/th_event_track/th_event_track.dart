import 'package:flutter_th_common_firebase/flutter_th_common_firebase.dart';

class ThEventTrack {
  static void _log(dynamic msg) {
    logger.i('📝 Th event easytrack:$msg');
  }

  static void basicLog(String key, Map<String, dynamic> value) {
    _log('$key: $value');
    ThAnalyticsLib.logEvent(name: key, parameters: value);
  }

  static void testLog() {
    _log('test');
  }
}
