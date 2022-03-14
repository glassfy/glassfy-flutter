import 'package:flutter/material.dart';
import 'dart:async';

import 'package:glassfy_flutter/glassfy_flutter.dart';

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

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      var version = await Glassfy.sdkVersion();
      platformVersion = version.version!;

      // await Glassfy.initialize(
      //     '8NOV6FQBHHRJ4F9N2HV0HUXOQ5LL0QA3/OBMVM0E1ZZQ77TZOQNOETSHHPQOZX6LQ');
      await Glassfy.initialize(
          '50af3c1afb6f473bbaf1ad0d5fb19b41');
          
    } catch(e) {
      debugPrint(e.toString());
      platformVersion = e.toString();
    }
    try {
      var offerings = await Glassfy.offerings();
      debugPrint(offerings.toString());

      var permission = await Glassfy.permissions();
      debugPrint(permission.toString());

      var sku = await Glassfy.skuWithId('monthly_article_subscription');
      debugPrint(sku.toString());

      await Glassfy.purchaseSku(sku);

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
