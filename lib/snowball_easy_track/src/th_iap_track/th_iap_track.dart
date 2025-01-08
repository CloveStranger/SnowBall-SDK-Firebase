import 'package:flutter_th_common_firebase/flutter_th_common_firebase.dart';

class ThIapTrack {
  static void _log(dynamic msg) {
    logger.i('🛒 Th iap easytrack:$msg');
  }

  static void basicLog(String key, Map<String, dynamic> value) {
    _log('$key: $value');
    ThAnalyticsLib.logEvent(name: key, parameters: value);
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
