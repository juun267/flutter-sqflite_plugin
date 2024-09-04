import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xu_sqflite_plugin/xu_sqflite_plugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelXuSqflitePlugin platform = MethodChannelXuSqflitePlugin();
  const MethodChannel channel = MethodChannel('xu_sqflite_plugin');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
