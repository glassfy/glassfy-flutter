import 'package:flutter/material.dart';
import 'package:glassfy_flutter/glassfy_flutter.dart';
import 'package:glassfy_flutter/models.dart';

import 'design.dart';

class PurchasesSection extends StatefulWidget {
  const PurchasesSection({super.key});

  @override
  _PurchasesSectionState createState() => _PurchasesSectionState();
}

class _PurchasesSectionState extends State<PurchasesSection> {
  List<GlassfyPurchaseHistory> purchases = [];

  @override
  void initState() {
    super.initState();
    getPurchases();
  }

  void getPurchases() async {
    try {
      debugPrint('Fetching purchase history');
      var result = await Glassfy.purchaseHistory();
      debugPrint('Got $result purchases');
      debugPrint('Got ${result.all?.length} purchases');
      setState(() {
        purchases = result.all ?? List.empty();
      });
    } catch (error) {
      debugPrint('Error getting Purchases: $error');
      setState(() {
        purchases = [];
      });
    }
  }

  void handlePress(GlassfyPurchaseHistory item) {
    debugPrint('You tapped on: ${item.transactionId}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Purchases'),
        Text('Found ${purchases.length} purchases'),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: purchases.length,
          itemBuilder: (context, index) {
            var purchase = purchases[index];
            return InkWell(
              onTap: () => handlePress(purchase),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Text('${purchase.productId} (${purchase.skuId})'),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
