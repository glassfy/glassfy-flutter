import 'package:flutter/material.dart';
import 'dart:async';

import 'package:glassfy_flutter/glassfy_flutter.dart';
import 'package:glassfy_flutter/models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    try {
      var version = await Glassfy.sdkVersion();
      platformVersion = version.version!;

      Glassfy.setLogLevel(GlassfyLogLevel.logLevelAll);
      await Glassfy.initialize('50af3c1afb6f473bbaf1ad0d5fb19b41');

      var offerings = await Glassfy.offerings();
      debugPrint(offerings.toString());
      var permission1 = await Glassfy.permissions();

      await Glassfy.connectPaddleLicenseKey("89bf4c748e4a45e5829e6ee6",true);
      await Glassfy.connectCustomSubscriber("topolino");

      var permission = await Glassfy.permissions();
      debugPrint(permission.toString());

      var sku = await Glassfy.skuWithId('weekly_article_subscription');
      debugPrint(sku.toString());

      await Glassfy.setEmailUserProperty("ppp4@email.com");

      Map<String, String> extraProp = {
        // "name": "Pinco Pallino22",
        // "count": "3"
      };

      await Glassfy.setExtraUserProperty(extraProp);

      var purchase = await Glassfy.purchaseSku(sku);
      debugPrint(purchase.toString());

      debugPrint("Done");
    } catch (e) {
      debugPrint(e.toString());
      platformVersion = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
