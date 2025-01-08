import '../../src/snowball_messaging.dart';
import 'push_lib_abstract_class.dart';
import 'push_lib_sub_constants.dart';
import 'push_lib_utils.dart';

class PushLib extends PushLibSubUtils {
  factory PushLib() {
    return PushLib._instanceMake();
  }

  PushLib._();

  factory PushLib._instanceMake() {
    _instance ??= PushLib._();
    return _instance!;
  }

  static PushLib? _instance;

  static PushLib get instance => PushLib._instanceMake();

  final SnowballMessaging _messagingLib = SnowballMessaging();

  @override
  Future<bool> subRegionTopic() async {
    final String regionTopic = PushLibUtils.getRegionTopic();
    return _messagingLib.basicSubTopic(
      topicKey: PushLibSubConstants.regionTopicKey,
      topic: regionTopic,
    );
  }

  @override
  Future<bool> subLanguageTopic() async {
    final String languageTopic = PushLibUtils.getLanguageTopic();
    return _messagingLib.basicSubTopic(
      topicKey: PushLibSubConstants.languageTopicKey,
      topic: languageTopic,
    );
  }

  @override
  Future<bool> subLocaleTopic() async {
    final String localeTopic = PushLibUtils.getLocaleTopic();
    return _messagingLib.basicSubTopic(
      topicKey: PushLibSubConstants.localeTopicKey,
      topic: localeTopic,
    );
  }

  @override
  Future<bool> subTimeZoneTopic() async {
    final String timeZoneTopic = PushLibUtils.getTimezoneByOffsetTopic();
    return _messagingLib.basicSubTopic(
      topicKey: PushLibSubConstants.timeZoneTopicKey,
      topic: timeZoneTopic,
    );
  }

  @override
  Future<bool> subManufacturerTopic() async {
    final String? manufacturerTopic = await PushLibUtils.getManufacturerTopic();
    if (manufacturerTopic == null) {
      return false;
    }
    return _messagingLib.basicSubTopic(
      topicKey: PushLibSubConstants.manufacturerTopicKey,
      topic: manufacturerTopic,
    );
  }

  @override
  Future<bool> subAllUserTopic() async {
    return _messagingLib.basicSubTopic(
      topicKey: PushLibSubConstants.topicAllUser,
      topic: PushLibSubConstants.topicAllUser,
    );
  }

  @override
  Future<bool> subUserLicenseTopic(bool isPro) async {
    return _messagingLib.basicSubTopic(
      topicKey: PushLibSubConstants.licenseTopicKey,
      topic: PushLibSubConstants.licenseTopic(isPro),
    );
  }

  @override
  Future<bool> unSubRegionTopic() async {
    return _messagingLib.basicUnSubTopic(
      topicKey: PushLibSubConstants.regionTopicKey,
    );
  }

  @override
  Future<bool> unSubAllUserTopic() async {
    return _messagingLib.basicUnSubTopic(
      topicKey: PushLibSubConstants.allUserTopicKey,
    );
  }

  @override
  Future<bool> unSubLanguageTopic() async {
    return _messagingLib.basicUnSubTopic(
      topicKey: PushLibSubConstants.languageTopicKey,
    );
  }

  @override
  Future<bool> unSubLocaleTopic() async {
    return _messagingLib.basicUnSubTopic(
      topicKey: PushLibSubConstants.localeTopicKey,
    );
  }

  @override
  Future<bool> unSubManufacturerTopic() async {
    return _messagingLib.basicUnSubTopic(
      topicKey: PushLibSubConstants.manufacturerTopicKey,
    );
  }

  @override
  Future<bool> unSubTimeZoneTopic() async {
    return _messagingLib.basicUnSubTopic(
      topicKey: PushLibSubConstants.timeZoneTopicKey,
    );
  }

  @override
  Future<bool> unSubUserLicenseTopic(bool isPro) async {
    return _messagingLib.basicUnSubTopic(
      topicKey: PushLibSubConstants.licenseTopicKey,
    );
  }

  Future<List<bool>> subAllNeedTopic({
    bool requestPermission = true,
  }) async {
    await _messagingLib.handleRequestPermission();
    final List<Future<bool>> subFutures = <Future<bool>>[
      subAllUserTopic(),
      subTimeZoneTopic(),
      subRegionTopic(),
      subLanguageTopic(),
      subLocaleTopic(),
      subManufacturerTopic(),
    ];
    return Future.wait(subFutures);
  }

  Future<List<bool>> unSubAllNeedTopic() async {
    final List<Future<bool>> unSubFutures = <Future<bool>>[
      unSubAllUserTopic(),
      unSubTimeZoneTopic(),
      unSubRegionTopic(),
      unSubLanguageTopic(),
      unSubLocaleTopic(),
      unSubManufacturerTopic(),
    ];
    return Future.wait(unSubFutures);
  }

  Future<String?> getFcmToken() async {
    return _messagingLib.getUserFcmToken();
  }
}
