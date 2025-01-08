import 'package:flutter/foundation.dart';

@immutable
class PushLibSubConstants {
  static String regionTopicKey = 'th_topic_region';
  static String languageTopicKey = 'th_topic_language';
  static String localeTopicKey = 'th_topic_locale';
  static String timeZoneTopicKey = 'th_topic_time_zone';
  static String manufacturerTopicKey = 'th_topic_manufacturer';
  static String allUserTopicKey = 'th_topic_all_user';
  static String licenseTopicKey = 'th_topic_license';

  static String topicAllUser = 'all_user';
  static String topicFree = 'license_free';
  static String topicPro = 'license_pro';

  static String topicStorePath = 'th_common_push_topic_store_path';

  static String licenseTopic(bool isPro) {
    return isPro ? topicPro : topicFree;
  }
}
