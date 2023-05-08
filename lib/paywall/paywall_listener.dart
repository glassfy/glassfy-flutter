import 'package:glassfy_flutter/models.dart';

abstract class PaywallListener {
  void onClose(GlassfyTransaction? transaction, Error? error);
  void onLink(Uri url);
  void onRestore();
  void onPurchase(GlassfySku sku);
}