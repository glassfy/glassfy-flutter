import 'package:flutter/material.dart';
import 'package:glassfy_flutter/models.dart';

import 'sku.dart';

class OfferingItem extends StatefulWidget {
  final GlassfyOffering offering;

  const OfferingItem(this.offering, {super.key});

  @override
  _OfferingItemState createState() => _OfferingItemState(offering);
}

class _OfferingItemState extends State<OfferingItem> {
  GlassfyOffering offering;

  _OfferingItemState(this.offering);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Semantics(
            label: 'offering',
            value: 'offering',
            child: Text('${offering.offeringId}'),
          ),
          const Text(' ('),
          Semantics(
            label: 'numberOfSkus',
            value: 'numberOfSkus',
            child: Text('${offering.skus?.length ?? 0}'),
          ),
          const Text(' skus)')
        ]),
        const SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: offering.skus?.length ?? 0,
          itemBuilder: (context, index) {
            var sku = offering.skus![index];
            return InkWell(
              child: Container(
                  padding: const EdgeInsets.all(10), child: SkuItem(sku)),
            );
          },
        ),
      ],
    );
  }
}
