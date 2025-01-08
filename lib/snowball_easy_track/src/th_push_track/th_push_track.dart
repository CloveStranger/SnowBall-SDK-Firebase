import 'package:flutter_th_common_firebase/flutter_th_common_firebase.dart';

class ThPushTrack {
  static void _log(dynamic msg) {
    logger.i('🔔 Th push easytrack:$msg');
  }

  static void basicLog(String key, Map<String, dynamic> value) {
    _log('$key: $value');
    ThAnalyticsLib.logEvent(name: key, parameters: value);
  }

  static void sendTrackEvent(PushTrackInfo pushTrackInfo) {
    basicLog(EventPushType.track_user_info.name, pushTrackInfo.toEventJson());
  }

  static void testLog() {
    _log('test');
  }
}
