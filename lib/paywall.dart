import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:glassfy_flutter/glassfy_flutter.dart';
import 'package:glassfy_flutter/models.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class PaywallView extends StatefulWidget {
  final GlassfyPaywall paywall;
  final void Function(GlassfyTransaction? transaction, Object? error)? onClose;
  final void Function(Uri url)? onLink;
  final void Function()? onRestore;
  final void Function(GlassfySku sku)? onPurchase;

  const PaywallView({
    Key? key,
    required this.paywall,
    this.onClose,
    this.onLink,
    this.onRestore,
    this.onPurchase,
  }) : super(key: key);

  @override
  State<PaywallView> createState() => PaywallViewState();
}

class PaywallViewState extends State<PaywallView> {
  late final WebViewController controller;
  bool contentLoaded = false;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.paywall.contentUrl ?? ""))
      ..removeJavaScriptChannel("AndroidHandler")
      ..addJavaScriptChannel("AndroidHandler",
          onMessageReceived: (JavaScriptMessage message) {
        onPostedMessage(message);
      })
      ..setNavigationDelegate(NavigationDelegate(onPageFinished: (String url) {
        onPageFinished(url);
      }));
  }

  void onPageFinished(String url) {
    debugPrint('Page finished: $url');
    if (url != widget.paywall.contentUrl) {
      return;
    }
    if (contentLoaded) {
      return;
    }
    contentLoaded = true;
    initializeJs();
  }

  Future<String> uiStyle() async {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return isDarkMode ? 'dark' : 'light';
  }

  void initializeJs() async {
    final script = buildJSCode('setSkuDetails', widget.paywall.config);
    if (script.isNotEmpty == true) {
      controller.runJavaScript(script);
    }
  }

  String buildJSCode(String action, Map<String, dynamic> data) {
    final jsonObject = {'action': action, 'data': data};
    final jsonString = jsonEncode(jsonObject);
    final bytes = utf8.encode(jsonString);
    final base64String = base64.encode(bytes);
    return "callJs('$base64String');";
  }

  void onPostedMessage(JavaScriptMessage message) {
    final msg = jsonDecode(message.message);
    debugPrint('PAYWALL - postMessage ${msg['action']}');
    switch (msg['action']) {
      case 'restore':
        onRestore();
        break;
      case 'link':
        final urlStr = msg['data']?['url'] as String?;
        if (urlStr == null || urlStr.isEmpty) {
          debugPrint('PAYWALL Link action: url is missing');
          return;
        }
        try {
          final url = Uri.parse(urlStr);
          onLink(url);
        } catch (e) {
          debugPrint('PAYWALL Link action: url malformed');
        }
        break;
      case 'purchase':
        final skuId = msg['data']?['sku'] as String?;
        if (skuId == null || skuId.isEmpty) {
          debugPrint('PAYWALL Purchase action: SKU is missing');
          return;
        }
        onPurchaseAction(skuId);
        break;
      case 'close':
        onClose(null, null);
        break;
      case '':
        debugPrint('PAYWALL Missing action from paywall\'s js');
        break;
      default:
        debugPrint('PAYWALL Paywall message not handled');
    }
  }

  void postMessage(String text) {
    controller.runJavaScript('window.alert("$text")');
  }

  void onClose(GlassfyTransaction? transaction, Object? error) {
    widget.onClose?.call(transaction, error);
  }

  void onLink(Uri url) async {
    if (widget.onLink != null) {
      widget.onLink?.call(url);
      return;
    }
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void onRestore() async {
    if (widget.onRestore != null) {
      widget.onRestore?.call();
      return;
    }
    try {
      await Glassfy.restorePurchases();
      onClose(null, null);
    } catch (error) {
      onClose(null, error);
    }
  }

  void onPurchase(GlassfySku sku) async {
    if (widget.onPurchase != null) {
      widget.onPurchase?.call(sku);
      return;
    }
    try {
      var transaction = await Glassfy.purchaseSku(sku);
      onClose(transaction, null);
    } catch (error) {
      onClose(null, error);
    }
  }

  void onPurchaseAction(String skuId) async {
    final sku = widget.paywall.skus?.firstWhere((s) => s.skuId == skuId);
    if (sku != null) {
      onPurchase(sku);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}
