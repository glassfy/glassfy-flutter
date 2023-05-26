import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glassfy_flutter/glassfy_flutter.dart';
import 'package:glassfy_flutter/models.dart';
import 'dart:async';
import 'dart:convert';

class GlassfyPaywall {
  static const EventChannel _eventChannel = EventChannel('paywallEvent');
  static bool didSetupEventsChannel = false;
  static PaywallListener? _listener;

  static Future<void> showPaywall(
      {required String remoteConfig,
      bool awaitLoading = true,
      PaywallListener? listener}) async {
    _listener = listener;
    if (!didSetupEventsChannel) {
      setupEventsChannel();
    }
    Glassfy.showPaywall(remoteConfig, awaitLoading);
  }

  static void setupEventsChannel() {
    _eventChannel.receiveBroadcastStream().listen((event) {
      Map<String, dynamic> map = jsonDecode(event);
      var name = map['name'];
      var payload = map['payload'];

      switch (name) {
        case 'onClose':
          GlassfyTransaction? transaction;
          try {
            transaction = GlassfyTransaction.fromJson(payload['transaction']);
          } catch (_) {}
          var error = payload['error'];
          _listener?.onClose(transaction, error);
          break;

        case 'onPurchase':
          try {
            var sku = GlassfySku.fromJson(payload['sku']);
            _listener?.onPurchase(sku);
          } catch (_) {}
          break;

        case 'onLink':
          try {
            Uri url = Uri.parse(payload['url']);
            _listener?.onLink(url);
          } catch (_) {}
          break;

        case 'onRestore':
          _listener?.onRestore();
          break;

        default:
          debugPrint('PAYWALL - Received unknwon event $name');
      }
    });
  }

  static void close() {
    _listener = null;
    Glassfy.closePaywall();
  }
}

class PaywallListener {
  final Function(GlassfyTransaction?, dynamic)? onCloseCallback;
  final Function(Uri)? onLinkCallback;
  final Function()? onRestoreCallback;
  final Function(GlassfySku)? onPurchaseCallback;

  PaywallListener({
    this.onCloseCallback,
    this.onLinkCallback,
    this.onRestoreCallback,
    this.onPurchaseCallback,
  });

  void onClose(GlassfyTransaction? transaction, dynamic error) async {
    if (onCloseCallback != null) {
      onCloseCallback!(transaction, error);
    } else {
      GlassfyPaywall.close();
    }
  }

  void onLink(Uri url) async {
    if (onLinkCallback != null) {
      onLinkCallback!(url);
    } else {
      Glassfy.openUrl(url);
    }
  }

  void onRestore() async {
    if (onRestoreCallback != null) {
      onRestoreCallback!();
    } else {
      await Glassfy.restorePurchases();
      onClose(null, null);
    }
  }

  void onPurchase(GlassfySku sku) async {
    if (onPurchaseCallback != null) {
      onPurchaseCallback!(sku);
    } else {
      try {
        final transaction = await Glassfy.purchaseSku(sku);
        onClose(transaction, null);
      } catch (error) {
        onClose(null, error);
      }
    }
  }
}
