class IapBeginInfo {
  final String scene;
  final String skuId;

  const IapBeginInfo({
    required this.scene,
    required this.skuId,
  });

  Map<String, dynamic> toJson() {
    return {
      'scene': scene,
      'skuId': skuId,
    };
  }
}

class IapSuccessInfo {
  final String scene;

  const IapSuccessInfo({
    required this.scene,
  });

  Map<String, dynamic> toJson() {
    return {
      'scene': scene,
    };
  }
}

class IapTrackInfo {
  final String currency;
  final double value;
  final String type;
  final bool isFreeTrial;
  final String productId;
  final String? freeTrailPeriod;

  IapTrackInfo({
    required this.currency,
    required this.value,
    required this.type,
    required this.isFreeTrial,
    required this.productId,
    this.freeTrailPeriod,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> params = {
      'currency': currency,
      'value': value,
      'type': type,
      'isFreeTrial': isFreeTrial,
      'productId': productId,
    };
    if (isFreeTrial && freeTrailPeriod != null) {
      params['freeTrailPeriod'] = freeTrailPeriod!;
    }
    return params;
  }
}

class IapFailedInfo {
  final String scene;

  final String? code;

  final String? message;

  final String? detail;

  final String reason;

  const IapFailedInfo({
    required this.scene,
    this.code,
    this.message,
    this.detail,
    required this.reason,
  });

  Map<String, dynamic> toJson() {
    return {
      'scene': scene,
      'code': code,
      'message': message,
      'detail': detail,
      'reason': reason,
    };
  }
}
