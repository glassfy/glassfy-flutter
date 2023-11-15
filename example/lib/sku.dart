import 'package:flutter/material.dart';
import 'package:glassfy_flutter/glassfy_flutter.dart';
import 'package:glassfy_flutter/models.dart';

class SkuItem extends StatefulWidget {
  final GlassfySku sku;

  const SkuItem(this.sku, {super.key});

  @override
  _SkuItemState createState() => _SkuItemState(sku);
}

class _SkuItemState extends State<SkuItem> {
  GlassfySku sku;

  _SkuItemState(this.sku);

  @override
  void initState() {
    super.initState();
  }

  void handlePress() async {
    debugPrint('Purchasing ${sku.skuId}');
    try {
      await Glassfy.purchaseSku(sku);
      debugPrint('Purchase completed!');
    } catch (error) {
      debugPrint('Error during purchase: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var price = "${sku.product?.price}";
    var introPrice = "--";

    var promoPrice = "--";
    if (sku.promotionalEligibility == GlassfyElegibility.elegibile) {
      promoPrice = "${sku.discount?.price}";
      price = promoPrice;
    }

    if (sku.introductoryEligibility == GlassfyElegibility.elegibile) {
      introPrice = "${sku.product?.introductoryPrice?.price}";
      price = introPrice;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
            onTap: () => handlePress(),
            child: Column(
              children: <Widget>[
                Row(children: [
                  const Text("SkuId"),
                  Expanded(
                      child: Container(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text("${sku.skuId}")))
                ]),
                Row(children: [
                  const Text("productId"),
                  Expanded(
                      child: Container(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text("${sku.productId}")))
                ]),
                Row(children: [
                  const Text("BasePlanId"),
                  Expanded(
                      child: Container(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text("${sku.basePlanId}")))
                ]),
                Row(children: [
                  const Text("OfferId"),
                  Expanded(
                      child: Container(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text("${sku.offerId}")))
                ]),
                Row(children: [
                  const Text("Original Price"),
                  Expanded(
                      child: Container(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text("${sku.product?.price}")))
                ]),
                Row(children: [
                  const Text("Intro Offer"),
                  Expanded(
                      child: Container(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(introPrice)))
                ]),
                Row(children: [
                  const Text("Promo Offer"),
                  Expanded(
                      child: Container(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(promoPrice)))
                ]),
                Row(children: [
                  const Text("FINAL Price"),
                  Expanded(
                      child: Container(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(price)))
                ]),
              ],
            )),
      ],
    );
  }
}
