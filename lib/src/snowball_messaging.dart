import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'snowball_logger.dart';

class SnowballFcmCallback {
  SnowballFcmCallback({
    this.onTokenRefresh,
    this.onTokenRefreshError,
    this.onForeReceive,
    this.onBackgroundReceive,
  });

  void Function(String fcmToken)? onTokenRefresh;
  void Function()? onTokenRefreshError;
  void Function(RemoteMessage message)? onForeReceive;
  void Function(RemoteMessage message)? onBackgroundReceive;
}

class SnowballMessaging {
  factory SnowballMessaging() {
    return SnowballMessaging._makeInstance();
  }

  factory SnowballMessaging._makeInstance() {
    _instance ??= SnowballMessaging._();
    return _instance!;
  }

  SnowballMessaging._();

  static SnowballMessaging? _instance;

  static SnowballMessaging get instance => SnowballMessaging._makeInstance();

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final Logger _logger = SnowballLogger.logger;
  final String _prefix = '==> Firebase Messaging Log ';

  static const String _topicStoreKey = 'snowball_msg_topic_store_key';
  static const String _authReqTimeKey = 'snowball_msg_req_auth_last_time';

  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  List<String> pushTopicKeys = <String>[];

  int lastGetTokenTime = -1;

  void _logInfo(dynamic message) {
    _logger.i('$_prefix$message');
  }

  void _logError(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.e('$_prefix$message', error: error, stackTrace: stackTrace);
  }

  @pragma('vm:entry-point')
  Future<void> fcmBgHandler(RemoteMessage message) async {
    _logInfo('Background Get $message');
    _fcmCallback?.onBackgroundReceive?.call(message);
  }

  Future<void> _initPrefs() async {
    pushTopicKeys.addAll(
      (await _prefs.getStringList(_topicStoreKey)) ?? <String>[],
    );
    lastGetTokenTime = (await _prefs.getInt(_authReqTimeKey)) ?? -1;
  }

  SnowballFcmCallback? _fcmCallback;

  void init([SnowballFcmCallback? fcmCallback]) {
    _fcmCallback = fcmCallback;
    FirebaseMessaging.onBackgroundMessage(fcmBgHandler);
    FirebaseMessaging.onMessage.listen(fcmCallback?.onForeReceive?.call);
    firebaseMessaging.onTokenRefresh.listen(
      (String event) {
        _logInfo('New Fcm $event');
        _fcmCallback?.onTokenRefresh?.call(event);
      },
    ).onError(
      (dynamic error) {
        _logError(error.toString());
        _fcmCallback?.onTokenRefreshError?.call();
      },
    );
  }

  Future<String?> getUserFcmToken() async {
    if (await handleCheckPermission() == AuthorizationStatus.authorized) {
      return firebaseMessaging.getToken();
    }
    final DateTime lastTime = DateTime.fromMillisecondsSinceEpoch(
      lastGetTokenTime,
    );
    final bool timeCheck = DateTime.now().difference(lastTime).inDays > 7;
    if (lastGetTokenTime == -1 || timeCheck) {
      lastGetTokenTime = DateTime.now().millisecondsSinceEpoch;
      _prefs.setInt(_authReqTimeKey, lastGetTokenTime);
      if (await handleRequestPermission() != AuthorizationStatus.authorized) {
        return null;
      }
      return firebaseMessaging.getToken();
    }
    return null;
  }

  Future<String?> getTargetTopicInfo(String topicKey) async {
    return _prefs.getString(topicKey);
  }

  Future<Map<String, String>> getAllStoreTopicInfo() async {
    await _initPrefs();
    final Map<String, String> result = <String, String>{};
    for (final String key in pushTopicKeys) {
      result[key] = (await _prefs.getString(key)) ?? '';
    }
    return result;
  }

  Future<void> _setSubTopicList(String topic, bool isSub) async {
    await _initPrefs();
    if (isSub) {
      if (!pushTopicKeys.contains(topic)) {
        pushTopicKeys.add(topic);
      }
    } else {
      if (pushTopicKeys.contains(topic)) {
        pushTopicKeys.remove(topic);
      }
    }
    _prefs.setStringList(_topicStoreKey, pushTopicKeys);
  }

  Future<AuthorizationStatus> handleCheckPermission() async {
    return (await firebaseMessaging.getNotificationSettings())
        .authorizationStatus;
  }

  Future<AuthorizationStatus> handleRequestPermission() async {
    return (await firebaseMessaging.requestPermission()).authorizationStatus;
  }

  Future<bool> basicSubTopic({
    required String topicKey,
    required String topic,
  }) async {
    bool isSub = false;
    try {
      final String? storeTopic = await _prefs.getString(topicKey);
      if (storeTopic != null) {
        await basicUnSubTopic(topicKey: topicKey, topic: topic);
      }
      await FirebaseMessaging.instance.subscribeToTopic(topic);
      _prefs.setString(topicKey, topic);
      _setSubTopicList(topicKey, true);
      _logInfo('$topicKey:$topic sub success');
      isSub = true;
    } catch (e, stack) {
      _logError('$topicKey:$topic', e, stack);
    }
    return isSub;
  }

  Future<bool> basicUnSubTopic({
    required String topicKey,
    String? topic,
  }) async {
    bool isUnSub = false;
    try {
      final String? storeTopic = topic ?? await getTargetTopicInfo(topicKey);
      if (storeTopic != null) {
        await FirebaseMessaging.instance.unsubscribeFromTopic(storeTopic);
      }
      _prefs.remove(topicKey);
      _setSubTopicList(topicKey, false);
      _logInfo('$topicKey:$topic unSub success');
      isUnSub = true;
    } catch (e, stack) {
      _logError('$topicKey:$topic', e, stack);
    }
    return isUnSub;
  }

  Future<List<bool>> batchSubTopic(Map<String, String> topics) async {
    final List<Future<bool>> subList = <Future<bool>>[];
    topics.forEach((String key, String value) {
      subList.add(basicSubTopic(topicKey: key, topic: value));
    });
    return Future.wait(subList);
  }

  Future<List<bool>> batchUnSubTopic(Map<String, String> topics) async {
    final List<Future<bool>> unSubList = <Future<bool>>[];
    topics.forEach((String key, String value) {
      unSubList.add(basicUnSubTopic(topicKey: key, topic: value));
    });
    return Future.wait(unSubList);
  }
}
