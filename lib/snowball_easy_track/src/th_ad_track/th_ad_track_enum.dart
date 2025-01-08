enum EventAdType {
  Interstitial,
  RewardedVideo,
  Banner,
  Native,
  AppOpen,
  RewardedInterstitial,
  UnKnow,
}

enum EventAdKey {
  th_ad_impression,
  th_revenue,
  th_revenue_estimate,
  Total_Ads_Revenue_001,
}

extension EventAdTypeExtension on EventAdType {
  String getName() {
    switch (this) {
      case EventAdType.Interstitial:
        return 'Fullscreen';
      case EventAdType.RewardedVideo:
        return 'Rewarded Video';
      case EventAdType.Banner:
        return 'Banner';
      case EventAdType.Native:
        return 'Native';
      case EventAdType.AppOpen:
        return 'app_open';
      case EventAdType.RewardedInterstitial:
        return 'RewardedInterstitial';
      default:
        return 'Unknown';
    }
  }

  String getShortName() {
    switch (this) {
      case EventAdType.Interstitial:
        return 'I';
      case EventAdType.RewardedVideo:
        return 'R';
      case EventAdType.Banner:
        return 'B';
      case EventAdType.Native:
        return 'N';
      case EventAdType.AppOpen:
        return 'O';
      case EventAdType.RewardedInterstitial:
        return 'RI';
      default:
        return 'UN';
    }
  }
}
