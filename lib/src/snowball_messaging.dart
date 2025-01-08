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
}
