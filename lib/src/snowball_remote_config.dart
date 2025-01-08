import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'snowball_logger.dart';

class SnowballRemoteConfig {
  factory SnowballRemoteConfig() {
    return SnowballRemoteConfig._makeInstance();
  }

  factory SnowballRemoteConfig._makeInstance() {
    _instance ??= SnowballRemoteConfig._();
    return _instance!;
  }

  SnowballRemoteConfig._();

  static SnowballRemoteConfig? _instance;

  static SnowballRemoteConfig get instance =>
      SnowballRemoteConfig._makeInstance();

  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  Logger get logger => SnowballLogger.logger;

  final String _prefix = '==> Firebase Remote Config Log ';

  Future<void> setDefault(Map<String, dynamic> defaultValue) async {
    await remoteConfig.setDefaults(defaultValue);
  }

  Future<void> init({
    Map<String, dynamic>? defaultValue,
    RemoteConfigSettings? settings,
    RemoteConfigSettings? debugSettings,
  }) async {
    if (defaultValue != null) {
      await setDefault(defaultValue);
    }
    if (kDebugMode) {
      await remoteConfig.setConfigSettings(
        debugSettings ??
            RemoteConfigSettings(
              fetchTimeout: const Duration(minutes: 1),
              minimumFetchInterval: const Duration(minutes: 5),
            ),
      );
    } else {
      await remoteConfig.setConfigSettings(
        settings ??
            RemoteConfigSettings(
              fetchTimeout: const Duration(seconds: 10),
              minimumFetchInterval: const Duration(hours: 1),
            ),
      );
    }
    await remoteConfig.fetchAndActivate();
  }

  void _logInfo(dynamic message) {
    logger.i('$_prefix$message');
  }

  void _logError(
    String message,
    String key, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    logger.e(
      '$_prefix$message Get $key Failed',
      error: error,
      stackTrace: stackTrace,
    );
  }

  bool getBool(String key) {
    final bool value = remoteConfig.getBool(key);
    _logInfo('Get $key: $value');
    return value;
  }

  String getString(String key) {
    final String value = remoteConfig.getString(key);
    _logInfo('Get $key: $value');
    return value;
  }

  int getInt(String key) {
    final int value = remoteConfig.getInt(key);
    _logInfo('Get $key: $value');
    return value;
  }

  double getDouble(String key) {
    final double value = remoteConfig.getDouble(key);
    _logInfo('Get $key: $value');
    return value;
  }

  Future<void> fetch() async {
    _logInfo('Fetch Start');
    await remoteConfig.fetch();
    _logInfo('Fetch End');
  }

  Future<void> active() async {
    _logInfo('Active Start');
    await remoteConfig.activate();
    _logInfo('Active End');
  }

  Future<void> fetchAndActive() async {
    _logInfo('Fetch And Active Start');
    await remoteConfig.fetchAndActivate();
    _logInfo('Fetch And Active End');
  }
}
