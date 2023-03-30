import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'models.dart';

typedef DidPurchaseListener = void Function(
  GlassfyTransaction transaction,
);

class Glassfy {
  static final Set<DidPurchaseListener> _didPurchaseListenerListeners = {};

  static final MethodChannel _channel = const MethodChannel('glassfy_flutter')
    ..setMethodCallHandler((call) async {
      switch (call.method) {
        case 'gy_did_purchase_product':
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
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<GlassfyVersion> sdkVersion() async {
    final json = await _channel.invokeMethod('sdkVersion');
    return GlassfyVersion.fromJson(jsonDecode(json));
  }

  static Future<void> initialize(String apiKey, {bool watcherMode = false}) =>
      _channel.invokeMethod('initialize', {
        'apiKey': apiKey,
        'watcherMode': watcherMode,
        'version': "1.3.8"
      });

  static setLogLevel(int logLevel) {
    _channel.invokeMethod('setLogLevel', {
      'logLevel': logLevel,
    });
  }

  static Future<GlassfyOfferings> offerings() async {
    final json = await _channel.invokeMethod('offerings');
    return GlassfyOfferings.fromJson(jsonDecode(json));
  }

  static Future<GlassfyPurchasesHistory> purchaseHistory() async {
    final json = await _channel.invokeMethod('purchaseHistory');
    return GlassfyPurchasesHistory.fromJson(jsonDecode(json));
  }

  static Future<GlassfySku> skuWithId(String identifier) async {
    final json =
        await _channel.invokeMethod('skuWithId', {'identifier': identifier});

    return GlassfySku.fromJson(jsonDecode(json));
  }

  static Future<GlassfySkuBase> skuWithIdAndStore(
      String identifier, GlassfyStore store) async {
    final st = glassfyStoreToInt(store);
    final json = await _channel.invokeMethod(
        'skuWithIdAndStore', {'identifier': identifier, 'store': st});

    final skuBase = GlassfySkuBase.fromJson(jsonDecode(json));
    if (skuBase.store == GlassfyStore.storeAppStore) {
      return GlassfySku.fromJson(jsonDecode(json));
    } else if (skuBase.store == GlassfyStore.storePlayStore) {
      return GlassfySku.fromJson(jsonDecode(json));
    } else if (skuBase.store == GlassfyStore.storePaddle) {
      return GlassfySku.fromJson(jsonDecode(json));
    }
    return skuBase;
  }

  @Deprecated('Use the connectCustomSubscriber function instead.')
  static Future<void> login(String userid) async {
    await _channel.invokeMethod('login', {'userid': userid});
  }

  @Deprecated('Use the connectCustomSubscriber with "null" function instead.')
  static Future<void> logout() async {
    await _channel.invokeMethod('logout');
  }

  static Future<GlassfyPermissions> permissions() async {
    final json = await _channel.invokeMethod('permissions');
    return GlassfyPermissions.fromJson(jsonDecode(json));
  }

  static Future<GlassfyTransaction> purchaseSku(GlassfySku sku,
      [GlassfySku? skuToUpgrade,
      GlassfyProrationMode prorationMode =
          GlassfyProrationMode.immediateWithTimeProration]) async {
    final param = {
      'sku': sku.toJson(),
      'skuToUpgrade': skuToUpgrade?.toJson(),
      'prorationMode': glassfyProrationModeToInt(prorationMode),
    };

    final json = await _channel.invokeMethod('purchaseSku', param);
    return GlassfyTransaction.fromJson(jsonDecode(json));
  }

  static Future<GlassfyPermissions> restorePurchases() async {
    final json = await _channel.invokeMethod('restorePurchases');
    return GlassfyPermissions.fromJson(jsonDecode(json));
  }

  static Future<void> setDeviceToken(String token) async {
    await _channel.invokeMethod('setDeviceToken', {'token': token});
  }

  static Future<void> setEmailUserProperty(String email) async {
    await _channel.invokeMethod('setEmailUserProperty', {'email': email});
  }

  static Future<void> setExtraUserProperty(
      Map<String, String> extraProp) async {
    await _channel
        .invokeMethod('setExtraUserProperty', {'extraProp': extraProp});
  }

  static Future<Map<String, dynamic>> getExtraUserProperty() async {
    final json = await _channel.invokeMethod('getExtraUserProperty');
    const JsonDecoder decoder = JsonDecoder();
    return decoder.convert(json);
  }

  static Future<void> connectCustomSubscriber(String? subscriberId) async {
    await _channel.invokeMethod(
        'connectCustomSubscriber', {'subscriberId': subscriberId});
  }

  static Future<void> connectPaddleLicenseKey(String licenseKey,
      [force = false]) async {
    await _channel.invokeMethod(
        'connectPaddleLicenseKey', {'licenseKey': licenseKey, 'force': force});
  }

  static Future<void> setAttribution(
      GlassfyAttribution type, String? value) async {
    final ty = glassfyAttributionToInt(type);
    await _channel.invokeMethod('setAttribution', {'type': ty, "value": value});
  }

  static Future<void> setAttributions(
      List<GlassfyAttributionItem>? items) async {
    final itemsList = items?.map((item) => item.toJson()).toList();
    await _channel.invokeMethod('setAttributions', {'items': itemsList});
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
