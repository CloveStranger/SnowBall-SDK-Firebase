class SnowballFirebaseCore {
  factory SnowballFirebaseCore() {
    return SnowballFirebaseCore._makeInstance();
  }

  factory SnowballFirebaseCore._makeInstance() {
    _instance ??= SnowballFirebaseCore._();
    return _instance!;
  }

  SnowballFirebaseCore._();

  static SnowballFirebaseCore? _instance;

  static SnowballFirebaseCore get instance =>
      SnowballFirebaseCore._makeInstance();
}
