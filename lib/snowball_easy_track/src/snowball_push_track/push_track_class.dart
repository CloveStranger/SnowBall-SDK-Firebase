class PushTrackInfo {
  PushTrackInfo({
    required this.timezone,
    required this.country,
    required this.language,
    required this.localeId,
    required this.isPro,
  });

  String timezone;
  String country;
  String language;
  String localeId;
  bool isPro;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'timezone': timezone,
      'country': country,
      'language': language,
      'localeId': localeId,
      'isPro': isPro,
    };
  }

  Map<String, dynamic> toEventJson() {
    return <String, dynamic>{
      'timezone_label': timezone,
      'country': country,
      'language': language,
      'locale_id': localeId,
      'is_pro': isPro,
    };
  }
}
