import 'package:flutter/material.dart';
import 'package:glassfy_flutter/models.dart';
import 'package:glassfy_flutter/paywall.dart';
import 'design.dart';

class PaywallSection extends StatefulWidget {
  const PaywallSection({super.key});

  @override
  PaywallSectionState createState() => PaywallSectionState();
}

class PaywallSectionState extends State<PaywallSection> {
  final paywallListener = PaywallListener(
      onCloseCallback: (GlassfyTransaction? transaction, dynamic error) {
    debugPrint("Paywall is closing");
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Paywall'),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: showHtmlPaywall,
          child: const Text("Show HTML Paywall"),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: showNoCodePaywall,
          child: const Text("Show NoCode Paywall"),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: showPreloadedHtmlPaywall,
          child: const Text("Show Preloaded HTML Paywall"),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: showPreloadedNoCodePaywall,
          child: const Text("Show Preloaded NoCode Paywall"),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void showHtmlPaywall() {
    showPaywall("remoteconfig001", false);
  }

  void showNoCodePaywall() {
    showPaywall("remoteconfig002", false);
  }

  void showPreloadedHtmlPaywall() {
    showPaywall("remoteconfig001", true);
  }

  void showPreloadedNoCodePaywall() {
    showPaywall("remoteconfig002", true);
  }

  void showPaywall(String remoteConfigId, bool awaitLoading) async {
    try {
      GlassfyPaywall.showPaywall(
          remoteConfig: remoteConfigId,
          awaitLoading: awaitLoading,
          listener: paywallListener);
    } catch (error) {
      debugPrint("Error fetching paywall: $error");
    }
  }
}
