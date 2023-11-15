import 'package:flutter/material.dart';
import 'package:glassfy_flutter/glassfy_flutter.dart';

class RestorePurchases extends StatefulWidget {
  const RestorePurchases({super.key});

  @override
  _RestorePurchasesState createState() => _RestorePurchasesState();
}

class _RestorePurchasesState extends State<RestorePurchases> {
  _RestorePurchasesState();

  @override
  void initState() {
    super.initState();
  }

  Future<void> restorePurchases() async {
    debugPrint("Restoring purchases...");
    await Glassfy.restorePurchases();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ElevatedButton(
        onPressed: restorePurchases,
        child: const Text("Restore Purchases"),
      ),
      const SizedBox(height: 20),
    ]);
  }
}
