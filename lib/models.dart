import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

class GlassfyLogLevel {
  static int get logLevelOff => 0;
  static int get logLevelError => 1;
  static int get logLevelDebug => 2;
  static int get logLevelInfo => 3;
  static int get logLevelAll => 4;
}

enum GlassfyElegibility {
  @JsonValue(1)
  elegibile,

  @JsonValue(-1)
  nonElegible,

  @JsonValue(0)
  unknown,
}

enum GlassfyAttribution {
  @JsonValue(1)
  AdjustID,

  @JsonValue(2)
  AppsFlyerID,

  @JsonValue(3)
  IP,

  @JsonValue(4)
  IDFA,

  @JsonValue(5)
  IDFV,

  @JsonValue(6)
  GAID,

  @JsonValue(7)
  ASID,

  @JsonValue(8)
  AID,
}

int glassfyAttributionToInt(GlassfyAttribution attribution) {
  return _$GlassfyAttributionEnumMap[attribution] ?? -1;
}

enum GlassfyEventType {
  @JsonValue(5001)
  InitialBuy,

  @JsonValue(5002)
  Restarted,

  @JsonValue(5003)
  Renewed,

  @JsonValue(5004)
  Expired,
  
  @JsonValue(5005)
  DidChangeRenewalStatus,

  @JsonValue(5006)
  IsInBillingRetryPeriod,

  @JsonValue(5007)
  ProductChange,

  @JsonValue(5008)
  InAppPurchase,

  @JsonValue(5009)
  Refund,

  @JsonValue(5010)
  Paused,

  @JsonValue(5011)
  Resumed,

  @JsonValue(5012)
  ConnectLicense,

  @JsonValue(5013)
  DisconnectLicense
}

enum GlassfyStore {
  @JsonValue(1)
  storeAppStore,

  @JsonValue(2)
  storePlayStore,

  @JsonValue(3)
  storePaddle,
}

enum GlassfyProrationMode {
  @JsonValue(0)
  unKnownUpgradeDowngradePolicy,

  @JsonValue(1)
  immediateWithTimeProration,

  @JsonValue(2)
  immediateWithChargeProratedPrice,

  @JsonValue(3)
  immediateWithoutProration,

  @JsonValue(4)
  deferred,

  @JsonValue(5)
  immediateAndChargeFullPrice,
}

int glassfyProrationModeToInt(GlassfyProrationMode mode) {
  switch (mode) {
    case GlassfyProrationMode.unKnownUpgradeDowngradePolicy:
      return 0;
    case GlassfyProrationMode.immediateWithTimeProration:
      return 1;
    case GlassfyProrationMode.immediateWithChargeProratedPrice:
      return 2;
    case GlassfyProrationMode.immediateWithoutProration:
      return 3;
    case GlassfyProrationMode.deferred:
      return 4;
    case GlassfyProrationMode.immediateAndChargeFullPrice:
      return 5;
    default:
      return -1;
  }
}

int glassfyStoreToInt(GlassfyStore store) {
  return _$GlassfyStoreEnumMap[store] ?? 0;
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

@JsonSerializable(explicitToJson: true)
class GlassfyAttributionItem {
  final GlassfyAttribution? type;
  final String? value;

  GlassfyAttributionItem(this.type, this.value);
  factory GlassfyAttributionItem.fromJson(Map<String, dynamic> json) =>
      _$GlassfyAttributionItemFromJson(json);
  Map<String, dynamic> toJson() => _$GlassfyAttributionItemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GlassfyProductDiscount {
  final num? price;
  final String? period;
  final int? numberOfPeriods;
  final String? type;

  GlassfyProductDiscount(
      this.price, this.period, this.numberOfPeriods, this.type);
  factory GlassfyProductDiscount.fromJson(Map<String, dynamic> json) =>
      _$GlassfyProductDiscountFromJson(json);
  Map<String, dynamic> toJson() => _$GlassfyProductDiscountToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GlassfyProduct {
  final String? description;
  final String? currencyCode;
  final num? price;
  final GlassfyProductDiscount? introductoryPrice;
  final List<GlassfyProductDiscount>? discounts;

  GlassfyProduct(this.description, this.currencyCode, this.price,
      this.introductoryPrice, this.discounts);
  factory GlassfyProduct.fromJson(Map<String, dynamic> json) =>
      _$GlassfyProductFromJson(json);
  Map<String, dynamic> toJson() => _$GlassfyProductToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GlassfySkuBase {
  final String? skuId;
  final String? productId;
  final GlassfyStore? store;

  GlassfySkuBase(this.skuId, this.productId, this.store);
  factory GlassfySkuBase.fromJson(Map<String, dynamic> json) =>
      _$GlassfySkuBaseFromJson(json);
  Map<String, dynamic> toJson() => _$GlassfySkuBaseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GlassfyAccountableSku extends GlassfySkuBase {
  final bool? isInTrialPeriod;
  final bool? isInIntroOfferPeriod;

  GlassfyAccountableSku(String? skuId, String? productId, GlassfyStore? store,
      this.isInTrialPeriod, this.isInIntroOfferPeriod)
      : super(skuId, productId, store);

  factory GlassfyAccountableSku.fromJson(Map<String, dynamic> json) =>
      _$GlassfyAccountableSkuFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GlassfyAccountableSkuToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GlassfySku extends GlassfySkuBase {
  final GlassfyElegibility? introductoryEligibility;
  final GlassfyElegibility? promotionalEligibility;

  final GlassfyProduct? product;

  final Map<String, dynamic>? extravars;

  GlassfySku(
      String? skuId,
      String? productId,
      GlassfyStore? store,
      this.introductoryEligibility,
      this.promotionalEligibility,
      this.product,
      this.extravars)
      : super(skuId, productId, store);

  factory GlassfySku.fromJson(Map<String, dynamic> json) =>
      _$GlassfySkuFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GlassfySkuToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GlassfySkuPaddle extends GlassfySkuBase {
  final String? name;

  final num? initialPrice;
  final String? initialPriceCode;

  final num? recurringPrice;
  final String? recurringPriceCode;
  final Map<String, dynamic>? extravars;

  GlassfySkuPaddle(
      String? skuId,
      String? productId,
      GlassfyStore? store,
      this.name,
      this.initialPrice,
      this.initialPriceCode,
      this.recurringPrice,
      this.recurringPriceCode,
      this.extravars)
      : super(skuId, productId, null);

  factory GlassfySkuPaddle.fromJson(Map<String, dynamic> json) =>
      _$GlassfySkuPaddleFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GlassfySkuPaddleToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GlassfyOffering {
  final String? offeringId;
  final List<GlassfySku>? skus;

  GlassfyOffering(this.offeringId, this.skus);

  factory GlassfyOffering.fromJson(Map<String, dynamic> json) =>
      _$GlassfyOfferingFromJson(json);
  Map<String, dynamic> toJson() => _$GlassfyOfferingToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GlassfyOfferings {
  List<GlassfyOffering>? all;

  factory GlassfyOfferings.fromJson(Map<String, dynamic> json) =>
      _$GlassfyOfferingsFromJson(json);

  GlassfyOfferings(this.all);

  Map<String, dynamic> toJson() => _$GlassfyOfferingsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GlassfyPurchasesHistory {
  List<GlassfyPurchaseHistory>? all;

  factory GlassfyPurchasesHistory.fromJson(Map<String, dynamic> json) => _$GlassfyPurchasesHistoryFromJson(json);

  GlassfyPurchasesHistory(this.all);

  Map<String, dynamic> toJson() => _$GlassfyPurchasesHistoryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GlassfyPurchaseHistory {
  final String? offeringId;
  final String? productId;
  final String? skuId;
  final GlassfyEventType? type;
  final GlassfyStore? store;
  final int? purchaseDate;
  final int? expireDate;
  final String? transactionId;
  final String? subscriberId;
  final String? currencyCode;
  final String? countryCode;
  final bool? isInIntroOfferPeriod;
  final String? promotionalOfferId;
  final String? offerCodeRefName;
  final String? licenseCode;
  final String? webOrderLineItemId;

  GlassfyPurchaseHistory(
    this.offeringId,
    this.productId,
    this.skuId,
    this.type,
    this.store,
    this.purchaseDate,
    this.expireDate,
    this.transactionId,
    this.subscriberId,
    this.currencyCode,
    this.countryCode,
    this.isInIntroOfferPeriod,
    this.promotionalOfferId,
    this.offerCodeRefName,
    this.licenseCode,
    this.webOrderLineItemId
  );

  factory GlassfyPurchaseHistory.fromJson(Map<String, dynamic> json) => _$GlassfyPurchaseHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$GlassfyPurchaseHistoryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GlassfyVersion {
  final String? version;

  GlassfyVersion(this.version);

  factory GlassfyVersion.fromJson(Map<String, dynamic> json) =>
      _$GlassfyVersionFromJson(json);
  Map<String, dynamic> toJson() => _$GlassfyVersionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GlassfyPermission {
  final String? permissionId;
  final GlassfyEntitlement? entitlement;
  final bool? isValid;
  final int? expireDate;
  final List<GlassfyAccountableSku>? accountableSkus;

  GlassfyPermission(this.permissionId, this.entitlement, this.isValid,
      this.expireDate, this.accountableSkus);
  factory GlassfyPermission.fromJson(Map<String, dynamic> json) =>
      _$GlassfyPermissionFromJson(json);
  Map<String, dynamic> toJson() => _$GlassfyPermissionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GlassfyPermissions {
  final String? installationId;
  final String? subscriberId;
  final String? originalApplicationVersion;
  final int? originalApplicationDate;
  List<GlassfyPermission>? all;

  GlassfyPermissions(this.installationId, this.subscriberId,
      this.originalApplicationVersion, this.originalApplicationDate, this.all);
  factory GlassfyPermissions.fromJson(Map<String, dynamic> json) =>
      _$GlassfyPermissionsFromJson(json);
  Map<String, dynamic> toJson() => _$GlassfyPermissionsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GlassfyTransaction {
  final String? productIdentifier;
  final bool? receiptValidated;
  final GlassfyPermissions? permissions;

  GlassfyTransaction(
      this.productIdentifier, this.receiptValidated, this.permissions);

  factory GlassfyTransaction.fromJson(Map<String, dynamic> json) =>
      _$GlassfyTransactionFromJson(json);
  Map<String, dynamic> toJson() => _$GlassfyTransactionToJson(this);
}
