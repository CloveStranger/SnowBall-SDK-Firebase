import 'package:logger/logger.dart';

import '../../../src/snowball_analytics.dart';
import 'iap_track_class.dart';
import 'iap_track_enum.dart';

export 'iap_track_class.dart';
export 'iap_track_enum.dart';

class ThIapTrack {
  static final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      printEmojis: false,
    ),
  );

  static void _log(dynamic msg) {
    logger.i('🛒Snowball Iap Easy Track:$msg');
  }

  static void basicLog(String key, Map<String, dynamic> value) {
    _log('$key: $value');
    SnowballAnalytics().logEvent(name: key, parameters: value);
  }

  static void iapBeginLog(IapBeginInfo iapBeginInfo) {
    basicLog(EventIapKey.IAP_Begin.name, iapBeginInfo.toJson());
  }

  static void iapSuccessLog(IapSuccessInfo iapSuccessInfo) {
    basicLog(EventIapKey.IAP_Success.name, iapSuccessInfo.toJson());
  }

  static void iapTrackLog(IapTrackInfo iapTrackInfo) {
    basicLog(EventIapKey.iap_purchase_estimate.name, iapTrackInfo.toJson());
    basicLog(EventIapKey.th_revenue_estimate.name, iapTrackInfo.toJson());
  }

  static void iapFailedLog(IapFailedInfo iapFailedInfo) {
    basicLog(EventIapKey.IAP_Failed.name, iapFailedInfo.toJson());
  }

  static void testLog() {
    _log('test');
  }
}
