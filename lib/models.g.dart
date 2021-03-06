// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
      json['description'] as String?,
      json['currencyCode'] as String?,
      json['price'] as num?,
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
      'description': instance.description,
      'currencyCode': instance.currencyCode,
      'price': instance.price,
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
      json['expireDate'] as int?,
      (json['accountableSkus'] as List<dynamic>?)
          ?.map((e) => GlassfySkuBase.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GlassfyPermissionToJson(GlassfyPermission instance) =>
    <String, dynamic>{
      'permissionId': instance.permissionId,
      'entitlement': _$GlassfyEntitlementEnumMap[instance.entitlement],
      'isValid': instance.isValid,
      'expireDate': instance.expireDate,
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
      json['originalApplicationDate'] as int?,
      (json['all'] as List<dynamic>?)
          ?.map((e) => GlassfyPermission.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GlassfyPermissionsToJson(GlassfyPermissions instance) =>
    <String, dynamic>{
      'installationId': instance.installationId,
      'subscriberId': instance.subscriberId,
      'originalApplicationVersion': instance.originalApplicationVersion,
      'originalApplicationDate': instance.originalApplicationDate,
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

GlassfySubscriptionUpdate _$GlassfySubscriptionUpdateFromJson(
        Map<String, dynamic> json) =>
    GlassfySubscriptionUpdate(
      json['originalSkuIdentifier'],
      json['proration'],
    );

Map<String, dynamic> _$GlassfySubscriptionUpdateToJson(
        GlassfySubscriptionUpdate instance) =>
    <String, dynamic>{
      'originalSkuIdentifier': instance.originalSkuIdentifier,
      'proration': _$GlassfyProrationModeEnumMap[instance.proration],
    };

const _$GlassfyProrationModeEnumMap = {
  GlassfyProrationMode.unKnownUpgradeDowngradePolicy: 0,
  GlassfyProrationMode.immediateWithTimeProration: 1,
  GlassfyProrationMode.immediateWithChargeProratedPrice: 2,
  GlassfyProrationMode.immediateWithoutProration: 3,
  GlassfyProrationMode.deferred: 4,
  GlassfyProrationMode.immediateAndChargeFullPrice: 4,
};
