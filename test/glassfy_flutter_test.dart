import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glassfy_flutter/glassfy_flutter.dart';

void main() {
  const MethodChannel channel = MethodChannel('glassfy_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Glassfy.platformVersion, '42');
  });
}
