import 'package:flutter_test/flutter_test.dart';
import 'package:xu_sqflite_plugin/xu_sqflite_plugin.dart';
import 'package:xu_sqflite_plugin/xu_sqflite_plugin_platform_interface.dart';
import 'package:xu_sqflite_plugin/xu_sqflite_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockXuSqflitePluginPlatform
    with MockPlatformInterfaceMixin
    implements XuSqflitePluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final XuSqflitePluginPlatform initialPlatform = XuSqflitePluginPlatform.instance;

  test('$MethodChannelXuSqflitePlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelXuSqflitePlugin>());
  });

  test('getPlatformVersion', () async {
    MockXuSqflitePluginPlatform fakePlatform = MockXuSqflitePluginPlatform();
    XuSqflitePluginPlatform.instance = fakePlatform;

  });
}
