import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:glassfy_flutter/utils/constants.dart';
import 'models.dart';

typedef DidPurchaseListener = void Function(
  GlassfyTransaction transaction,
);

class Glassfy {
  static final Set<DidPurchaseListener> _didPurchaseListenerListeners = {};

  static final MethodChannel _channel = const MethodChannel('glassfy_flutter')
    ..setMethodCallHandler((call) async {
      switch (call.method) {
        case Constants.mGy_did_purchase_product:
          for (final listener in _didPurchaseListenerListeners) {
            try {
              final transaction =
                  GlassfyTransaction.fromJson(jsonDecode(call.arguments));
              listener(transaction);
            } catch (e) {
              debugPrint("Invalid didPurchaseListner Argument");
            }
          }
          break;
      }
    });

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod(Constants.mGetPlatformVersion);
    return version;
  }

  static Future<GlassfyVersion> sdkVersion() async {
    final json = await _channel.invokeMethod(Constants.mSdkVersion);
    return GlassfyVersion.fromJson(jsonDecode(json));
  }

  static Future<void> initialize(String apiKey, {bool watcherMode = false}) =>
      _channel.invokeMethod(Constants.mInitialize, {
        Constants.pApiKey: apiKey,
        Constants.pWatcherMode: watcherMode,
        Constants.pVersion: "1.3.9"
      });

  static setLogLevel(int logLevel) {
    _channel.invokeMethod(Constants.mSetLogLevel, {
      Constants.pLogLevel: logLevel,
    });
  }

  static Future<GlassfyOfferings> offerings() async {
    final json = await _channel.invokeMethod(Constants.mOfferings);
    return GlassfyOfferings.fromJson(jsonDecode(json));
  }

  static Future<GlassfyPurchasesHistory> purchaseHistory() async {
    final json = await _channel.invokeMethod(Constants.mPurchaseHistory);
    return GlassfyPurchasesHistory.fromJson(jsonDecode(json));
  }

  static Future<GlassfySku> skuWithId(String identifier) async {
    final json =
        await _channel.invokeMethod(Constants.mSkuWithId, {Constants.pIdentifier: identifier});

    return GlassfySku.fromJson(jsonDecode(json));
  }

  static Future<GlassfySkuBase> skuWithIdAndStore(
      String identifier, GlassfyStore store) async {
    final st = glassfyStoreToInt(store);
    final json = await _channel.invokeMethod(
        Constants.mSkuWithIdAndStore, {Constants.pIdentifier: identifier, Constants.pStore: st});

    final skuBase = GlassfySkuBase.fromJson(jsonDecode(json));
    if (skuBase.store == GlassfyStore.storeAppStore) {
      return GlassfySku.fromJson(jsonDecode(json));
    } else if (skuBase.store == GlassfyStore.storePlayStore) {
      return GlassfySku.fromJson(jsonDecode(json));
    } else if (skuBase.store == GlassfyStore.storePaddle) {
      return GlassfySku.fromJson(jsonDecode(json));
    } else if (skuBase.store == GlassfyStore.storeStripe) {
      return GlassfySku.fromJson(jsonDecode(json));
    } else if (skuBase.store == GlassfyStore.storeGlassfy) {
      return GlassfySku.fromJson(jsonDecode(json));
    }
    return skuBase;
  }

  @Deprecated('Use the connectCustomSubscriber function instead.')
  static Future<void> login(String userid) async {
    await _channel.invokeMethod(Constants.mLogin, {Constants.pUserId: userid});
  }

  @Deprecated('Use the connectCustomSubscriber with "null" function instead.')
  static Future<void> logout() async {
    await _channel.invokeMethod(Constants.mLogOut);
  }

  static Future<GlassfyPermissions> permissions() async {
    final json = await _channel.invokeMethod(Constants.mPermissions);
    return GlassfyPermissions.fromJson(jsonDecode(json));
  }

  static Future<GlassfyTransaction> purchaseSku(GlassfySku sku,
      [GlassfySku? skuToUpgrade,
      GlassfyProrationMode prorationMode =
          GlassfyProrationMode.immediateWithTimeProration]) async {
    final param = {
      Constants.pSku: sku.toJson(),
      Constants.pSkuToUpgrade: skuToUpgrade?.toJson(),
      Constants.pProrationMode: glassfyProrationModeToInt(prorationMode),
    };

    final json = await _channel.invokeMethod(Constants.mPurchaseSku, param);
    return GlassfyTransaction.fromJson(jsonDecode(json));
  }

  static Future<GlassfyPermissions> restorePurchases() async {
    final json = await _channel.invokeMethod(Constants.mRestorePurchases);
    return GlassfyPermissions.fromJson(jsonDecode(json));
  }

  static Future<void> setDeviceToken(String token) async {
    await _channel.invokeMethod(Constants.mSetDeviceToken, {Constants.pToken: token});
  }

  static Future<void> setEmailUserProperty(String email) async {
    await _channel.invokeMethod(Constants.mSetEmailUserProperty, {Constants.pEmail: email});
  }

  static Future<void> setExtraUserProperty(
      Map<String, String> extraProp) async {
    await _channel
        .invokeMethod(Constants.mSetExtraUserProperty, {Constants.pExtraProp: extraProp});
  }

  static Future<Map<String, dynamic>> getExtraUserProperty() async {
    final json = await _channel.invokeMethod(Constants.mGetExtraUserProperty);
    const JsonDecoder decoder = JsonDecoder();
    return decoder.convert(json);
  }

  static Future<void> connectCustomSubscriber(String? subscriberId) async {
    await _channel.invokeMethod(
        Constants.mConnectCustomSubscriber, {Constants.pSubscriberId: subscriberId});
  }

  static Future<void> connectPaddleLicenseKey(String licenseKey, [force = false]) async {
    await _channel.invokeMethod(
        Constants.mConnectPaddleLicenseKey, {Constants.pLicenseKey: licenseKey, Constants.pForce: force});
  }

  static Future<void> connectGlassfyUniversalCode(String universalCode, [force = false]) async {
    await _channel.invokeMethod(
        Constants.mConnectGlassfyUniversalCode, {Constants.pUniversalCode: universalCode, Constants.pForce: force});
  }

  static Future<void> setAttribution(
      GlassfyAttribution type, String? value) async {
    final ty = glassfyAttributionToInt(type);
    await _channel.invokeMethod(Constants.mSetAttribution, {Constants.pType: ty, Constants.pType: value});
  }

  static Future<void> setAttributions(
      List<GlassfyAttributionItem>? items) async {
    final itemsList = items?.map((item) => item.toJson()).toList();
    await _channel.invokeMethod(Constants.mSetAttributions, {Constants.pItems: itemsList});
  }

  static void addDidPurchaseListener(
    DidPurchaseListener didPurchaseListenerListener,
  ) =>
      _didPurchaseListenerListeners.add(didPurchaseListenerListener);

  static void removeDidPurchaseListener(
    DidPurchaseListener didPurchaseListenerListener,
  ) =>
      _didPurchaseListenerListeners.remove(didPurchaseListenerListener);
}
