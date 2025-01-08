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
}
