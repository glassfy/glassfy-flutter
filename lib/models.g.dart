// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlassfySku _$GlassfySkuFromJson(Map<String, dynamic> json) => GlassfySku(
      json['skuId'] as String?,
      json['productId'] as String?,
      $enumDecodeNullable(
          _$GlassfyElegibilityEnumMap, json['introductoryEligibility']),
      $enumDecodeNullable(
          _$GlassfyElegibilityEnumMap, json['promotionalEligibility']),
    );

Map<String, dynamic> _$GlassfySkuToJson(GlassfySku instance) =>
    <String, dynamic>{
      'skuId': instance.skuId,
      'productId': instance.productId,
      'introductoryEligibility':
          _$GlassfyElegibilityEnumMap[instance.introductoryEligibility],
      'promotionalEligibility':
          _$GlassfyElegibilityEnumMap[instance.promotionalEligibility],
    };

const _$GlassfyElegibilityEnumMap = {
  GlassfyElegibility.elegibile: 1,
  GlassfyElegibility.nonElegible: -1,
  GlassfyElegibility.unknown: 0,
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
      'skus': instance.skus,
    };

GlassfyOfferings _$GlassfyOfferingsFromJson(Map<String, dynamic> json) =>
    GlassfyOfferings(
      (json['all'] as List<dynamic>?)
          ?.map((e) => GlassfyOffering.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GlassfyOfferingsToJson(GlassfyOfferings instance) =>
    <String, dynamic>{
      'all': instance.all,
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
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$GlassfyPermissionToJson(GlassfyPermission instance) =>
    <String, dynamic>{
      'permissionId': instance.permissionId,
      'entitlement': _$GlassfyEntitlementEnumMap[instance.entitlement],
      'isValid': instance.isValid,
      'expireDate': instance.expireDate,
      'accountableSkus': instance.accountableSkus,
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
      'all': instance.all,
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
      'permissions': instance.permissions,
    };
