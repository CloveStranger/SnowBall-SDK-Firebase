import 'package:shared_preferences/shared_preferences.dart';

class ThAdTrack {
  static late SharedPreferences _prefs;

  static bool _initialized = false;

  static Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _initialized = true;
  }

  static double revenueThreshold = 0.01;
  static double revenueEstimateThreshold = 0.01;
  static double totalRevenueThreshold = 0.01;

  static void _log(dynamic msg) {
    logger.i('📺 Th ad easytrack:$msg');
  }

  static void basicLog(String key, Map<String, dynamic> value) {
    _log('$key: $value');
    ThAnalyticsLib.logEvent(name: key, parameters: value);
  }

  static Future<void> _onRevenueEvent(double revenue) async {
    try {
      if (!_initialized) {
        await _initPrefs();
      }
      String eventKey = EventAdKey.th_revenue.name;
      String storeKey = '${eventKey}_key';
      double revenueDouble = (_prefs.getDouble(storeKey) ?? 0) + revenue;
      if (revenueDouble < revenueThreshold) {
        _prefs.setDouble(storeKey, revenueDouble);
        return;
      }
      basicLog(eventKey, {
        'currency': 'USD',
        'value': revenueDouble,
        'publisher_revenue': revenueDouble,
      });
      _prefs.setDouble(storeKey, 0);
    } catch (e) {
      _log('revenue store error: $e');
    }
  }

  static Future<void> _onRevenueEstimateEvent(double revenue) async {
    try {
      if (!_initialized) {
        await _initPrefs();
      }
      String eventKey = EventAdKey.th_revenue_estimate.name;
      String storeKey = '${eventKey}_key';
      double revenueDouble = (_prefs.getDouble(storeKey) ?? 0) + revenue;
      if (revenueDouble < revenueEstimateThreshold) {
        _prefs.setDouble(storeKey, revenueDouble);
        return;
      }
      basicLog(EventAdKey.th_revenue_estimate.name, {
        'currency': 'USD',
        'value': revenueDouble,
        'publisher_revenue': revenueDouble,
      });
      _prefs.setDouble(storeKey, 0);
    } catch (e) {
      _log('revenue estimate store error: $e');
    }
  }

  static Future<void> _onTotalRevenueEvent(double revenue) async {
    try {
      if (!_initialized) {
        await _initPrefs();
      }
      String eventKey = EventAdKey.Total_Ads_Revenue_001.name;
      String storeKey = '${eventKey}_key';
      double revenueDouble = (_prefs.getDouble(storeKey) ?? 0) + revenue;
      if (revenueDouble < totalRevenueThreshold) {
        _prefs.setDouble(storeKey, revenueDouble);
        return;
      }
      basicLog(EventAdKey.Total_Ads_Revenue_001.name, {
        'currency': 'USD',
        'value': revenueDouble,
        'publisher_revenue': revenueDouble,
      });
      _prefs.setDouble(storeKey, 0);
    } catch (e) {
      _log('total revenue store error: $e');
    }
  }

  static void onILRDEvent(ILRDInfo ilrdInfo) {
    if (ilrdInfo.revenue <= 0) {
      return;
    }
    basicLog(
      EventAdKey.th_ad_impression.name,
      ilrdInfo.toEventJSON(),
    );
    _onRevenueEvent(ilrdInfo.revenue);
    _onRevenueEstimateEvent(ilrdInfo.revenue);
    _onTotalRevenueEvent(ilrdInfo.revenue);
  }

  static void testLog() {
    _log('test');
  }
}
