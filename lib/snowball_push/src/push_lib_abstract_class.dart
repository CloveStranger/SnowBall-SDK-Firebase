abstract class PushLibSubUtils {
  Future<bool> subRegionTopic();

  Future<bool> subLanguageTopic();

  Future<bool> subLocaleTopic();

  Future<bool> subTimeZoneTopic();

  Future<bool> subManufacturerTopic();

  Future<bool> subAllUserTopic();

  Future<bool> subUserLicenseTopic(bool isPro);

  Future<bool> unSubRegionTopic();

  Future<bool> unSubLanguageTopic();

  Future<bool> unSubLocaleTopic();

  Future<bool> unSubTimeZoneTopic();

  Future<bool> unSubManufacturerTopic();

  Future<bool> unSubAllUserTopic();

  Future<bool> unSubUserLicenseTopic(bool isPro);
}
