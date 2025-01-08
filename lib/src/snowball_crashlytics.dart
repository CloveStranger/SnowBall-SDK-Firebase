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
}
