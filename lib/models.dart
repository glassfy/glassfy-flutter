
import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

enum GlassfyElegibility {
  @JsonValue(1)
  elegibile,

  @JsonValue(-1)
  nonElegible,

  @JsonValue(0)
  unknown,
}

enum GlassfyEntitlement {
  @JsonValue(-9)
  neverbuy,

  // The customer received a refund for the subscription.
  @JsonValue(-8)
  otherrefund,

  // The customer received a refund due to a perceived issue with the app.
  @JsonValue(-7)
  issuerefund,

  // The system canceled the subscription because the customer upgraded.
  @JsonValue(-6)
  upgraded,

  // The customer intentionally cancelled the subscription.
  @JsonValue(-5)
  expiredvoluntary,

  // The product is no longer available.
  @JsonValue(-4)
  productnotavailable,

  // The customer did not accept the price increase.
  @JsonValue(-3)
  failtoacceptincrease,

  // The receipt is fully expired due to a billing issue.
  @JsonValue(-2)
  expiredfrombilling,

  // The receipt is expired but the subscription is still in a billing-retry state.
  // If grace period is enabled this state excludes subscriptions in grace period.
  @JsonValue(-1)
  inretry,

  // The receipt is out of date or there is another purchase issue.
  @JsonValue(0)
  missinginfo,

  // The subscription expired but is in grace period.
  @JsonValue(1)
  expiredingrace,

  // The subscription is an off-platform subscription.
  @JsonValue(2)
  offplatform,

  // The subscription is a non-renewing subscription.
  @JsonValue(3)
  nonrenewing,

  // The subscription is active and auto-renew is off.
  @JsonValue(4)
  autorenewoff,

  // The subscription is active and auto-renew is on.
  @JsonValue(5)
  autorenewon,
}

@JsonSerializable()
class GlassfySku {
  final String? skuId;
  final String? productId;
  final GlassfyElegibility? introductoryEligibility;
  final GlassfyElegibility? promotionalEligibility;

  GlassfySku(this.skuId, this.productId, this.introductoryEligibility,
      this.promotionalEligibility);

  factory GlassfySku.fromJson(Map<String, dynamic> json) =>
      _$GlassfySkuFromJson(json);
  Map<String, dynamic> toJson() => _$GlassfySkuToJson(this);
}

@JsonSerializable()
class GlassfyOffering {
  final String? offeringId;
  final List<GlassfySku>? skus;

  GlassfyOffering(this.offeringId, this.skus);

  factory GlassfyOffering.fromJson(Map<String, dynamic> json) =>
      _$GlassfyOfferingFromJson(json);
  Map<String, dynamic> toJson() => _$GlassfyOfferingToJson(this);
}

@JsonSerializable()
class GlassfyOfferings {
  List<GlassfyOffering>? all;

  factory GlassfyOfferings.fromJson(Map<String, dynamic> json) =>
      _$GlassfyOfferingsFromJson(json);

  GlassfyOfferings(this.all);

  Map<String, dynamic> toJson() => _$GlassfyOfferingsToJson(this);
}

@JsonSerializable()
class GlassfyVersion {
  final String? version;

  GlassfyVersion(this.version);

  factory GlassfyVersion.fromJson(Map<String, dynamic> json) =>
      _$GlassfyVersionFromJson(json);
  Map<String, dynamic> toJson() => _$GlassfyVersionToJson(this);
}

@JsonSerializable()
class GlassfyPermission {
  final String? permissionId;
  final GlassfyEntitlement? entitlement;
  final bool? isValid;
  final String? expireDate;
  final List<String>? accountableSkus;

  GlassfyPermission(this.permissionId, this.entitlement,this.isValid,
      this.expireDate,this.accountableSkus);
  factory GlassfyPermission.fromJson(Map<String, dynamic> json) =>
      _$GlassfyPermissionFromJson(json);
  Map<String, dynamic> toJson() => _$GlassfyPermissionToJson(this);
}

@JsonSerializable()
class GlassfyPermissions {
  final String? installationId;
  final String? subscriberId;
  List<GlassfyPermission>? all;

  GlassfyPermissions(this.installationId, this.subscriberId);
  factory GlassfyPermissions.fromJson(Map<String, dynamic> json) =>
      _$GlassfyPermissionsFromJson(json);
  Map<String, dynamic> toJson() => _$GlassfyPermissionsToJson(this);
}

@JsonSerializable()
class GlassfyTransaction {
  final String? productIdentifier;
  final bool? receiptValidated;
  final GlassfyPermissions? permissions;

  GlassfyTransaction(this.productIdentifier, this.receiptValidated, this.permissions);

  factory GlassfyTransaction.fromJson(Map<String, dynamic> json) =>
      _$GlassfyTransactionFromJson(json);
  Map<String, dynamic> toJson() => _$GlassfyTransactionToJson(this);
}
