// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlassfyAttributionItem _$GlassfyAttributionItemFromJson(
        Map<String, dynamic> json) =>
    GlassfyAttributionItem(
      $enumDecodeNullable(_$GlassfyAttributionEnumMap, json['type']),
      json['value'] as String?,
    );

Map<String, dynamic> _$GlassfyAttributionItemToJson(
        GlassfyAttributionItem instance) =>
    <String, dynamic>{
      'type': _$GlassfyAttributionEnumMap[instance.type],
      'value': instance.value,
    };

const _$GlassfyAttributionEnumMap = {
  GlassfyAttribution.AdjustID: 1,
  GlassfyAttribution.AppsFlyerID: 2,
  GlassfyAttribution.IP: 3,
  GlassfyAttribution.IDFA: 4,
  GlassfyAttribution.IDFV: 5,
  GlassfyAttribution.GAID: 6,
  GlassfyAttribution.ASID: 7,
  GlassfyAttribution.AID: 8,
};

GlassfyProductDiscount _$GlassfyProductDiscountFromJson(
        Map<String, dynamic> json) =>
    GlassfyProductDiscount(
      json['price'] as num?,
      json['period'] as String?,
      json['numberOfPeriods'] as int?,
      json['type'] as String?,
    );

Map<String, dynamic> _$GlassfyProductDiscountToJson(
        GlassfyProductDiscount instance) =>
    <String, dynamic>{
      'price': instance.price,
      'period': instance.period,
      'numberOfPeriods': instance.numberOfPeriods,
      'type': instance.type,
    };

GlassfyProduct _$GlassfyProductFromJson(Map<String, dynamic> json) =>
    GlassfyProduct(
      json['title'] as String?,
      json['description'] as String?,
      json['identifier'] as String?,
      json['basePlanId'] as String?,
      json['price'] as num?,
      json['currencyCode'] as String?,
      json['period'] as String?,
      json['introductoryPrice'] == null
          ? null
          : GlassfyProductDiscount.fromJson(
              json['introductoryPrice'] as Map<String, dynamic>),
      (json['discounts'] as List<dynamic>?)
          ?.map(
              (e) => GlassfyProductDiscount.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GlassfyProductToJson(GlassfyProduct instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'identifier': instance.identifier,
      'basePlanId': instance.basePlanId,
      'price': instance.price,
      'currencyCode': instance.currencyCode,
      'period': instance.period,
      'introductoryPrice': instance.introductoryPrice?.toJson(),
      'discounts': instance.discounts?.map((e) => e.toJson()).toList(),
    };

GlassfySkuBase _$GlassfySkuBaseFromJson(Map<String, dynamic> json) =>
    GlassfySkuBase(
      json['skuId'] as String?,
      json['productId'] as String?,
      $enumDecodeNullable(_$GlassfyStoreEnumMap, json['store']),
    );

Map<String, dynamic> _$GlassfySkuBaseToJson(GlassfySkuBase instance) =>
    <String, dynamic>{
      'skuId': instance.skuId,
      'productId': instance.productId,
      'store': _$GlassfyStoreEnumMap[instance.store],
    };

const _$GlassfyStoreEnumMap = {
  GlassfyStore.storeAppStore: 1,
  GlassfyStore.storePlayStore: 2,
  GlassfyStore.storePaddle: 3,
  GlassfyStore.storeStripe: 4,
  GlassfyStore.storeGlassfy: 5,
};

GlassfyAccountableSku _$GlassfyAccountableSkuFromJson(
        Map<String, dynamic> json) =>
    GlassfyAccountableSku(
      json['skuId'] as String?,
      json['productId'] as String?,
      $enumDecodeNullable(_$GlassfyStoreEnumMap, json['store']),
      json['isInTrialPeriod'] as bool?,
      json['isInIntroOfferPeriod'] as bool?,
      json['basePlanId'] as String?,
      json['offerId'] as String?,
    );

Map<String, dynamic> _$GlassfyAccountableSkuToJson(
        GlassfyAccountableSku instance) =>
    <String, dynamic>{
      'skuId': instance.skuId,
      'productId': instance.productId,
      'store': _$GlassfyStoreEnumMap[instance.store],
      'isInTrialPeriod': instance.isInTrialPeriod,
      'isInIntroOfferPeriod': instance.isInIntroOfferPeriod,
      'basePlanId': instance.basePlanId,
      'offerId': instance.offerId,
    };

GlassfySku _$GlassfySkuFromJson(Map<String, dynamic> json) => GlassfySku(
      json['skuId'] as String?,
      json['productId'] as String?,
      $enumDecodeNullable(_$GlassfyStoreEnumMap, json['store']),
      $enumDecodeNullable(
          _$GlassfyElegibilityEnumMap, json['introductoryEligibility']),
      $enumDecodeNullable(
          _$GlassfyElegibilityEnumMap, json['promotionalEligibility']),
      json['product'] == null
          ? null
          : GlassfyProduct.fromJson(json['product'] as Map<String, dynamic>),
      json['extravars'] as Map<String, dynamic>?,
      json['basePlanId'] as String?,
      json['offerId'] as String?,
      json['discount'] == null
          ? null
          : GlassfyProductDiscount.fromJson(
              json['discount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GlassfySkuToJson(GlassfySku instance) =>
    <String, dynamic>{
      'skuId': instance.skuId,
      'productId': instance.productId,
      'store': _$GlassfyStoreEnumMap[instance.store],
      'introductoryEligibility':
          _$GlassfyElegibilityEnumMap[instance.introductoryEligibility],
      'promotionalEligibility':
          _$GlassfyElegibilityEnumMap[instance.promotionalEligibility],
      'product': instance.product?.toJson(),
      'extravars': instance.extravars,
      'basePlanId': instance.basePlanId,
      'offerId': instance.offerId,
      'discount': instance.discount?.toJson(),
    };

const _$GlassfyElegibilityEnumMap = {
  GlassfyElegibility.elegibile: 1,
  GlassfyElegibility.nonElegible: -1,
  GlassfyElegibility.unknown: 0,
};

GlassfySkuPaddle _$GlassfySkuPaddleFromJson(Map<String, dynamic> json) =>
    GlassfySkuPaddle(
      json['skuId'] as String?,
      json['productId'] as String?,
      $enumDecodeNullable(_$GlassfyStoreEnumMap, json['store']),
      json['name'] as String?,
      json['initialPrice'] as num?,
      json['initialPriceCode'] as String?,
      json['recurringPrice'] as num?,
      json['recurringPriceCode'] as String?,
      json['extravars'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$GlassfySkuPaddleToJson(GlassfySkuPaddle instance) =>
    <String, dynamic>{
      'skuId': instance.skuId,
      'productId': instance.productId,
      'store': _$GlassfyStoreEnumMap[instance.store],
      'name': instance.name,
      'initialPrice': instance.initialPrice,
      'initialPriceCode': instance.initialPriceCode,
      'recurringPrice': instance.recurringPrice,
      'recurringPriceCode': instance.recurringPriceCode,
      'extravars': instance.extravars,
    };

GlassfyOffering _$GlassfyOfferingFromJson(Map<String, dynamic> json) =>
    GlassfyOffering(
      json['offeringId'] as String?,
      (json['skus'] as List<dynamic>?)
          ?.map((e) => GlassfySku.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GlassfyOfferingToJson(GlassfyOffering instance) =>
    <String, dynamic>{
      'offeringId': instance.offeringId,
      'skus': instance.skus?.map((e) => e.toJson()).toList(),
    };

GlassfyOfferings _$GlassfyOfferingsFromJson(Map<String, dynamic> json) =>
    GlassfyOfferings(
      (json['all'] as List<dynamic>?)
          ?.map((e) => GlassfyOffering.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GlassfyOfferingsToJson(GlassfyOfferings instance) =>
    <String, dynamic>{
      'all': instance.all?.map((e) => e.toJson()).toList(),
    };

GlassfyPurchasesHistory _$GlassfyPurchasesHistoryFromJson(
        Map<String, dynamic> json) =>
    GlassfyPurchasesHistory(
      (json['all'] as List<dynamic>?)
          ?.map(
              (e) => GlassfyPurchaseHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GlassfyPurchasesHistoryToJson(
        GlassfyPurchasesHistory instance) =>
    <String, dynamic>{
      'all': instance.all?.map((e) => e.toJson()).toList(),
    };

GlassfyPurchaseHistory _$GlassfyPurchaseHistoryFromJson(
        Map<String, dynamic> json) =>
    GlassfyPurchaseHistory(
      json['offeringId'] as String?,
      json['productId'] as String?,
      json['skuId'] as String?,
      $enumDecodeNullable(_$GlassfyEventTypeEnumMap, json['type']),
      $enumDecodeNullable(_$GlassfyStoreEnumMap, json['store']),
      json['purchaseDate'] == null
          ? null
          : DateTime.parse(json['purchaseDate'] as String),
      json['expireDate'] == null
          ? null
          : DateTime.parse(json['expireDate'] as String),
      json['transactionId'] as String?,
      json['subscriberId'] as String?,
      json['currencyCode'] as String?,
      json['countryCode'] as String?,
      json['isInIntroOfferPeriod'] as bool?,
      json['promotionalOfferId'] as String?,
      json['offerCodeRefName'] as String?,
      json['licenseCode'] as String?,
      json['webOrderLineItemId'] as String?,
    );

Map<String, dynamic> _$GlassfyPurchaseHistoryToJson(
        GlassfyPurchaseHistory instance) =>
    <String, dynamic>{
      'offeringId': instance.offeringId,
      'productId': instance.productId,
      'skuId': instance.skuId,
      'type': _$GlassfyEventTypeEnumMap[instance.type],
      'store': _$GlassfyStoreEnumMap[instance.store],
      'purchaseDate': instance.purchaseDate?.toIso8601String(),
      'expireDate': instance.expireDate?.toIso8601String(),
      'transactionId': instance.transactionId,
      'subscriberId': instance.subscriberId,
      'currencyCode': instance.currencyCode,
      'countryCode': instance.countryCode,
      'isInIntroOfferPeriod': instance.isInIntroOfferPeriod,
      'promotionalOfferId': instance.promotionalOfferId,
      'offerCodeRefName': instance.offerCodeRefName,
      'licenseCode': instance.licenseCode,
      'webOrderLineItemId': instance.webOrderLineItemId,
    };

const _$GlassfyEventTypeEnumMap = {
  GlassfyEventType.InitialBuy: 5001,
  GlassfyEventType.Restarted: 5002,
  GlassfyEventType.Renewed: 5003,
  GlassfyEventType.Expired: 5004,
  GlassfyEventType.DidChangeRenewalStatus: 5005,
  GlassfyEventType.IsInBillingRetryPeriod: 5006,
  GlassfyEventType.ProductChange: 5007,
  GlassfyEventType.InAppPurchase: 5008,
  GlassfyEventType.Refund: 5009,
  GlassfyEventType.Paused: 5010,
  GlassfyEventType.Resumed: 5011,
  GlassfyEventType.ConnectLicense: 5012,
  GlassfyEventType.DisconnectLicense: 5013,
};

GlassfyVersion _$GlassfyVersionFromJson(Map<String, dynamic> json) =>
    GlassfyVersion(
      json['version'] as String?,
    );

Map<String, dynamic> _$GlassfyVersionToJson(GlassfyVersion instance) =>
    <String, dynamic>{
      'version': instance.version,
    };

GlassfyPermission _$GlassfyPermissionFromJson(Map<String, dynamic> json) =>
    GlassfyPermission(
      json['permissionId'] as String?,
      $enumDecodeNullable(_$GlassfyEntitlementEnumMap, json['entitlement']),
      json['isValid'] as bool?,
      json['expireDate'] == null
          ? null
          : DateTime.parse(json['expireDate'] as String),
      (json['accountableSkus'] as List<dynamic>?)
          ?.map(
              (e) => GlassfyAccountableSku.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GlassfyPermissionToJson(GlassfyPermission instance) =>
    <String, dynamic>{
      'permissionId': instance.permissionId,
      'entitlement': _$GlassfyEntitlementEnumMap[instance.entitlement],
      'isValid': instance.isValid,
      'expireDate': instance.expireDate?.toIso8601String(),
      'accountableSkus':
          instance.accountableSkus?.map((e) => e.toJson()).toList(),
    };

const _$GlassfyEntitlementEnumMap = {
  GlassfyEntitlement.neverbuy: -9,
  GlassfyEntitlement.otherrefund: -8,
  GlassfyEntitlement.issuerefund: -7,
  GlassfyEntitlement.upgraded: -6,
  GlassfyEntitlement.expiredvoluntary: -5,
  GlassfyEntitlement.productnotavailable: -4,
  GlassfyEntitlement.failtoacceptincrease: -3,
  GlassfyEntitlement.expiredfrombilling: -2,
  GlassfyEntitlement.inretry: -1,
  GlassfyEntitlement.missinginfo: 0,
  GlassfyEntitlement.expiredingrace: 1,
  GlassfyEntitlement.offplatform: 2,
  GlassfyEntitlement.nonrenewing: 3,
  GlassfyEntitlement.autorenewoff: 4,
  GlassfyEntitlement.autorenewon: 5,
};

GlassfyPermissions _$GlassfyPermissionsFromJson(Map<String, dynamic> json) =>
    GlassfyPermissions(
      json['installationId'] as String?,
      json['subscriberId'] as String?,
      json['originalApplicationVersion'] as String?,
      json['originalApplicationDate'] == null
          ? null
          : DateTime.parse(json['originalApplicationDate'] as String),
      (json['all'] as List<dynamic>?)
          ?.map((e) => GlassfyPermission.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GlassfyPermissionsToJson(GlassfyPermissions instance) =>
    <String, dynamic>{
      'installationId': instance.installationId,
      'subscriberId': instance.subscriberId,
      'originalApplicationVersion': instance.originalApplicationVersion,
      'originalApplicationDate':
          instance.originalApplicationDate?.toIso8601String(),
      'all': instance.all?.map((e) => e.toJson()).toList(),
    };

GlassfyTransaction _$GlassfyTransactionFromJson(Map<String, dynamic> json) =>
    GlassfyTransaction(
      json['productIdentifier'] as String?,
      json['receiptValidated'] as bool?,
      json['permissions'] == null
          ? null
          : GlassfyPermissions.fromJson(
              json['permissions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GlassfyTransactionToJson(GlassfyTransaction instance) =>
    <String, dynamic>{
      'productIdentifier': instance.productIdentifier,
      'receiptValidated': instance.receiptValidated,
      'permissions': instance.permissions?.toJson(),
    };
