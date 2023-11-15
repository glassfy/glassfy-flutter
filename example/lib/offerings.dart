import 'package:flutter/material.dart';
import 'package:glassfy_flutter/glassfy_flutter.dart';
import 'package:glassfy_flutter/models.dart';

import 'design.dart';
import 'offering.dart';

class OfferingsSection extends StatefulWidget {
  const OfferingsSection({super.key});

  @override
  _OfferingsSectionState createState() => _OfferingsSectionState();
}

class _OfferingsSectionState extends State<OfferingsSection> {
  List<GlassfyOffering> offerings = [];

  @override
  void initState() {
    super.initState();
    getOfferings();
  }

  void getOfferings() async {
    try {
      debugPrint('Fetching offerings');
      var result = await Glassfy.offerings();
      debugPrint('Got ${result.all?.length} offerings');
      setState(() {
        offerings = result.all ?? List.empty();
      });
    } catch (error) {
      debugPrint('Error getting Offerings: $error');
      setState(() {
        offerings = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Offerings'),
        Text('Found ${offerings.length} offerings'),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: offerings.length,
          itemBuilder: (context, index) {
            var offering = offerings[index];
            return InkWell(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  child: OfferingItem(offering)),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
