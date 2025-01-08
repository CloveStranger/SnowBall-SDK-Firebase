import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:logger/logger.dart';

import 'snowball_logger.dart';

class SnowballAnalytics {
  factory SnowballAnalytics() {
    return SnowballAnalytics._makeInstance();
  }

  factory SnowballAnalytics._makeInstance() {
    _instance ??= SnowballAnalytics._();
    return _instance!;
  }

  SnowballAnalytics._();

  static SnowballAnalytics? _instance;

  static SnowballAnalytics get instance => SnowballAnalytics._makeInstance();

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Logger get logger => SnowballLogger.logger;

  final String _prefix = '==> Firebase Analytics Log ';

  void init() {
    FirebaseAnalytics.instance.setConsent(
      analyticsStorageConsentGranted: true,
      adStorageConsentGranted: true,
    );
  }

  void _logInfo(dynamic message) {
    logger.i('$_prefix$message');
  }

  void _logError(dynamic message) {
    logger.e('$_prefix$message');
  }

  Future<void> logEvent({
    required String name,
    Map<String, dynamic>? parameters,
  }) async {
    try {
      _logInfo('Sending event: $name, Parameters: $parameters');
      await FirebaseAnalytics.instance.logEvent(
        name: name,
        parameters: parameters?.map(
          (String key, dynamic value) {
            final dynamic formatValue =
                (value is num || value is String) ? value : value.toString();
            return MapEntry<String, Object>(
              key,
              formatValue is Object ? formatValue : formatValue.toString(),
            );
          },
        ),
      );
      _logInfo('Event sent successfully: $name');
    } catch (e, stackTrace) {
      _logError('Failed to send event: $name');
      _logError('Error: $e');
      _logError('Stack trace: $stackTrace');
    }
  }
}
