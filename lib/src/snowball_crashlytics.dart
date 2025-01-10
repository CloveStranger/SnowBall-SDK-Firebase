import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'snowball_logger.dart';

class SnowballCrashlytics {
  factory SnowballCrashlytics() {
    return SnowballCrashlytics._makeInstance();
  }

  factory SnowballCrashlytics._makeInstance() {
    _instance ??= SnowballCrashlytics._();
    return _instance!;
  }

  SnowballCrashlytics._();

  static SnowballCrashlytics? _instance;

  static SnowballCrashlytics get instance =>
      SnowballCrashlytics._makeInstance();

  Logger get logger => SnowballLogger.logger;

  static const String _prefix = '==> Firebase Crashlytics Log ';

  void _logError(String message, [Object? error, StackTrace? stackTrace]) {
    logger.e('$_prefix$message', error: error, stackTrace: stackTrace);
  }

  void _recordError(FlutterErrorDetails error) {
    if (!kDebugMode) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(error);
    }
    _logError('FlutterError $error');
  }

  bool _recordAsyncError(Object error, StackTrace stack) {
    if (!kDebugMode) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    }
    _logError('FlutterAsyncError', error, stack);
    return true;
  }

  void init({
    FlutterExceptionHandler? onError,
    ErrorCallback? onAsyncError,
  }) {
    FlutterError.onError = onError ?? _recordError;
    PlatformDispatcher.instance.onError = onAsyncError ?? _recordAsyncError;
  }
}
