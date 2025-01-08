class IapBeginInfo {
  const IapBeginInfo({
    required this.scene,
    required this.skuId,
  });

  final String scene;
  final String skuId;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'scene': scene,
      'skuId': skuId,
    };
  }
}

class IapSuccessInfo {
  const IapSuccessInfo({
    required this.scene,
  });

  final String scene;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'scene': scene,
    };
  }
}

class IapTrackInfo {
  IapTrackInfo({
    required this.currency,
    required this.value,
    required this.type,
    required this.isFreeTrial,
    required this.productId,
    this.freeTrailPeriod,
  });

  final String currency;
  final double value;
  final String type;
  final bool isFreeTrial;
  final String productId;
  final String? freeTrailPeriod;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> params = <String, dynamic>{
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
  const IapFailedInfo({
    required this.scene,
    this.code,
    this.message,
    this.detail,
    required this.reason,
  });

  final String scene;

  final String? code;

  final String? message;

  final String? detail;

  final String reason;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'scene': scene,
      'code': code,
      'message': message,
      'detail': detail,
      'reason': reason,
    };
  }
}
