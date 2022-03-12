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
  GlassfyElegibility.nonElegible: 2,
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
      json['isValid'] as bool?,
      json['expireDate'] as int?,
    );

Map<String, dynamic> _$GlassfyPermissionToJson(GlassfyPermission instance) =>
    <String, dynamic>{
      'permissionId': instance.permissionId,
      'isValid': instance.isValid,
      'expireDate': instance.expireDate,
    };

GlassfyPermissions _$GlassfyPermissionsFromJson(Map<String, dynamic> json) =>
    GlassfyPermissions(
      json['installationId'] as String?,
      json['subscriberId'] as String?,
      json['originalApplicationVersion'] as String?,
      json['originalApplicationDate'] as String?,
    )..all = (json['all'] as List<dynamic>?)
        ?.map((e) => GlassfyPermission.fromJson(e as Map<String, dynamic>))
        .toList();

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
