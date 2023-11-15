import 'package:flutter/material.dart';
import 'package:glassfy_flutter/models.dart';

class AccountableSkuItem extends StatefulWidget {
  final GlassfyAccountableSku sku;

  const AccountableSkuItem(this.sku, {super.key});

  @override
  _AccountableSkuItemState createState() => _AccountableSkuItemState(sku);
}

class _AccountableSkuItemState extends State<AccountableSkuItem> {
  GlassfyAccountableSku sku;

  _AccountableSkuItemState(this.sku);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
              const Text("ProductId"),
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
              const Text("Original Price"),
              Expanded(
                  child: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text("${sku.offerId}")))
            ]),
          ],
        )),
      ],
    );
  }
}
