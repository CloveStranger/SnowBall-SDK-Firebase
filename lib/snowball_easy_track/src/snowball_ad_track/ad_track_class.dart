import 'ad_track_enum.dart';

class ILRDInfo {
  ILRDInfo({
    required this.mediation,
    required this.revenueFrom,
    required this.impRecordId,
    required this.countryCode,
    required this.networkName,
    required this.adUnitId,
    required this.adType,
    required this.currency,
    required this.revenue,
    required this.revenuePrecision,
    required this.scene,
    this.thirdPartyAdPlacementId,
  });

  final String mediation; // max, admob, self
  final String
      revenueFrom; // impression revenue provider, "applovin_max_ilrd, admob_pingback, self"
  final String impRecordId;
  final String
      countryCode; // "US" for the United States, etc - Note: Do not confuse this with currency code which is "USD" in most cases!
  final String
      networkName; // Display name of the network which showed the ad (e.g. "AdColony")
  final String adUnitId; // The Ad Unit ID
  final String?
      thirdPartyAdPlacementId; // The ad's placement id, if any (bidding may not have one)
  final EventAdType
      adType; // The ad format of the ad (e.g. "BANNER", "MREC", "INTER", "REWARDED", "REWARDED_INTER")
  final String currency;
  final double revenue;
  final String revenuePrecision;
  final String scene;

  Map<String, dynamic> toJSON() {
    return {
      'mediation': mediation,
      'revenueFrom': revenueFrom,
      'impRecordId': impRecordId,
      'countryCode': countryCode,
      'networkName': networkName,
      'adUnitId': adUnitId,
      'thirdPartyAdPlacementId': thirdPartyAdPlacementId,
      'adType': adType.name,
      'currency': currency,
      'revenue': revenue,
      'revenuePrecision': revenuePrecision,
      'scene': scene,
    };
  }

  Map<String, dynamic> toEventJSON() {
    return {
      'id': impRecordId,
      'mediation': mediation,
      'report_from': revenueFrom,
      'report_data_version': 1,
      'adunit_id': adUnitId,
      'adunit_name': adUnitId,
      'adunit_format': adType.getName(),
      'currency': currency,
      'publisher_revenue': revenue,
      'value': revenue,
      'country': countryCode,
      'precision': revenuePrecision,
      'network_name': networkName,
      'network_placement_id': thirdPartyAdPlacementId,
      'scene': scene,
    };
  }
}
