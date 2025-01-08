import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/widgets.dart';

class PushLibUtils {
  static Locale get _locale =>
      WidgetsBinding.instance.platformDispatcher.locale;

  static Locale localeFormContext(BuildContext context) {
    return Localizations.localeOf(context);
  }

  static String getRegionTopic([BuildContext? context]) {
    const String prefix = 'region_';
    final Locale locale =
        context != null ? localeFormContext(context) : _locale;
    final String countryCode = locale.countryCode ?? 'misc';
    return '$prefix${countryCode.toLowerCase()}';
  }

  static String getLanguageTopic([BuildContext? context]) {
    const String prefix = 'lang_';
    final Locale locale =
        context != null ? localeFormContext(context) : _locale;
    final String languageCode = locale.languageCode;
    return '$prefix${languageCode.toLowerCase()}';
  }

  static String getLocaleTopic([BuildContext? context]) {
    const String prefix = 'locale_id_';
    final Locale locale =
        context != null ? localeFormContext(context) : _locale;
    final String countryCode = locale.countryCode ?? 'misc';
    final String languageCode = locale.languageCode;
    return '$prefix${languageCode.toLowerCase()}_${countryCode.toLowerCase()}';
  }

  static String getTimezoneByOffsetTopic() {
    //获取当前时间
    final DateTime now = DateTime.now();
    //获取当前时区与UTC/GMT时间差
    final int timezoneOffset = now.timeZoneOffset.inHours;
    //根据偏移量决定东西时区
    final String prefix = timezoneOffset >= 0 ? 'plus_' : 'minus_';
    //取偏移量绝对值
    final int offsetHours = timezoneOffset.abs();
    //拼接时区字符串，格式如：tz_gmt_plus_8
    /**
     * 释义
     * tz_gmt_ 代表时区为UTC/GMT
     * plus_ 代表东时区
     * minus_ 代表西时区
     * 8 代表UTC/GMT+8
     *
     **/
    return 'tz_gmt_$prefix$offsetHours';
  }

  static Future<String?> getManufacturerTopic() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    const String prefix = 'manufacture_';
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return '$prefix${androidInfo.manufacturer.toLowerCase()}';
    } else if (Platform.isIOS) {
      return '${prefix}ios';
    }
    return null;
  }
}
