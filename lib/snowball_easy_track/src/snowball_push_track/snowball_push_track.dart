import 'package:logger/logger.dart';

import '../../../src/snowball_analytics.dart';
import 'push_track_class.dart';
import 'push_track_enum.dart';

export 'push_track_class.dart';
export 'push_track_enum.dart';

class SnowballPushTrack {
  static final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      printEmojis: false,
    ),
  );

  static void _log(dynamic msg) {
    logger.i('🔔Snowball Event Easy Track:$msg');
  }

  static void basicLog(String key, Map<String, dynamic> value) {
    _log('$key: $value');
    SnowballAnalytics().logEvent(name: key, parameters: value);
  }

  static void sendTrackEvent(PushTrackInfo pushTrackInfo) {
    basicLog(EventPushType.track_user_info.name, pushTrackInfo.toEventJson());
  }

  static void testLog() {
    _log('test');
  }
}
