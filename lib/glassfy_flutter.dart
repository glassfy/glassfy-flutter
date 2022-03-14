import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'models.dart';

class Glassfy {
  static const MethodChannel _channel = MethodChannel('glassfy_flutter');

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
      });

  static Future<GlassfyOfferings> offerings() async {
    final json = await _channel.invokeMethod('offerings');
    return GlassfyOfferings.fromJson(jsonDecode(json));
  }

  static Future<GlassfySku> skuWithId(String identifier) async {
    final json = await _channel
        .invokeMethod('skuWithIdentifier', {'identifier': identifier});
    return GlassfySku.fromJson(jsonDecode(json));
  }

  static Future<void> login(String userid) async {
    await _channel.invokeMethod('login', {'userid': userid});
  }

  static Future<void> logout() async {
    await _channel.invokeMethod('logout');
  }

  static Future<GlassfyPermissions> permissions() async {
    final json = await _channel.invokeMethod('permissions');
    return GlassfyPermissions.fromJson(jsonDecode(json));
  }

  static Future<GlassfyTransaction> purchaseSku(GlassfySku sku) async {
    final json =
        await _channel.invokeMethod('purchaseSku', {'sku': sku.toJson()});
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
      Map<String, dynamic> extraProp) async {
    await _channel.invokeMethod('setExtraUserProperty', {'extraProp': extraProp});
  }

  static Future<Map<String, dynamic>> getExtraUserProperty() async {
    final json = await _channel.invokeMethod('getExtraUserProperty');
    const JsonDecoder decoder = JsonDecoder();
    return decoder.convert(json);
  }
}
