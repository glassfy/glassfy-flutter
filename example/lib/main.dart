import 'package:flutter/material.dart';
import 'package:glassfy_flutter_example/permissions.dart';
import 'package:glassfy_flutter/glassfy_flutter.dart';
import 'package:glassfy_flutter/models.dart';

import 'offerings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'SDK Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String glassfyVersion = "...";
  bool sdkInitialized = false;

  @override
  void initState() {
    super.initState();
    setupSdk();
  }

  Future<void> setupSdk() async {
    debugPrint("Setting up Glassfy SDK...");

    try {
      const apiKey = "50af3c1afb6f473bbaf1ad0d5fb19b41";
      Glassfy.setLogLevel(GlassfyLogLevel.logLevelAll);
      Glassfy.initialize(apiKey);
    } catch (error) {
      debugPrint('Error setting up sdk $error');
    }
    await Future.delayed(const Duration(seconds: 5));

    final sdkVersion = await Glassfy.sdkVersion();
    debugPrint("SDK Version is ${sdkVersion.version}");

    setState(() {
      glassfyVersion = sdkVersion.version ?? "unknown";
      sdkInitialized = true;
    });
  }

  Future<void> restorePurchases() async {
    debugPrint("Restoring purchases...");
    setState(() {
      sdkInitialized = false;
    });
    await Glassfy.restorePurchases();

    setState(() {
      sdkInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Container(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Text('Glassfy version is $glassfyVersion'),
                  const SizedBox(height: 20),
                  if (sdkInitialized) ...[
                    const PermissionsSection(),
                    const OfferingsSection(),
                    // const RestorePurchases(),
                    // const UniversalCodesSection(),
                    // const PaywallSection(),
                    // const PurchasesSection(),
                  ],
                ]))));
  }
}
