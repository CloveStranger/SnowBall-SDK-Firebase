class PushTrackInfo {
  String timezone;
  String country;
  String language;
  String localeId;
  bool isPro;

  PushTrackInfo({
    required this.timezone,
    required this.country,
    required this.language,
    required this.localeId,
    required this.isPro,
  });

  Map<String, dynamic> toJson() {
    return {
      'timezone': timezone,
      'country': country,
      'language': language,
      'localeId': localeId,
      'isPro': isPro,
    };
  }

  Map<String, dynamic> toEventJson() {
    return {
      'timezone_label': timezone,
      'country': country,
      'language': language,
      'locale_id': localeId,
      'is_pro': isPro,
    };
  }
}
