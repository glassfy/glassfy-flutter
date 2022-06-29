import 'dart:convert';

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

  void printObject(Object object) {
    // Encode your object and then decode your object to Map variable
    Map jsonMapped = json.decode(json.encode(object));

    // Using JsonEncoder for spacing
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');

    // encode it to string
    String prettyPrint = encoder.convert(jsonMapped);

    // print or debugPrint your object
    debugPrint(prettyPrint);
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    try {
      var version = await Glassfy.sdkVersion();
      platformVersion = version.version!;

      await Glassfy.initialize('50af3c1afb6f473bbaf1ad0d5fb19b41');

      Glassfy.addDidPurchaseListener((transaction) async{
        printObject(transaction);
      });

      // Glassfy.addDidPurchaseListener((transaction) {
      //   printObject(transaction);
      // });

      // set custom identifier (optional)
      await Glassfy.connectCustomSubscriber("my_custom_identifier");

      // set user email (optional)
      await Glassfy.setEmailUserProperty("my@email.com");

      Map<String, String> extraProp = {
        "lastactivity": "Bike",
        "usage_count": "3"
      };
      // set extra property (optional)
      await Glassfy.setExtraUserProperty(extraProp);

      // connect a paddle license key
      await Glassfy.connectPaddleLicenseKey("89bf4c748e4a45e5829e6ee6", true);

      // get subscriber current subscriptions
      var permissions = await Glassfy.permissions();

      // extract subscriber current permissions
      for (var permission in permissions.all!) {
        printObject(permission);
      }

      // fetch 'subscription_articles' offering
      var offerings = await Glassfy.offerings();
      printObject(offerings);
      GlassfyOffering? result;
      result = offerings.all?.firstWhere(
          (offering) => offering.offeringId == "subscription_articles");

      // purchase first sku in the offering
      var sku = result?.skus?.first;
      printObject(sku!);

      var purchase = await Glassfy.purchaseSku(sku);
      printObject(purchase);
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
