// import 'package:flutter_test/flutter_test.dart';
// import 'package:sqflite_plugin/sqflite_plugin.dart';
// import 'package:sqflite_plugin/sqflite_plugin_platform_interface.dart';
// import 'package:sqflite_plugin/sqflite_plugin_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockSqflitePluginPlatform
//     with MockPlatformInterfaceMixin
//     implements SqflitePluginPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final SqflitePluginPlatform initialPlatform = SqflitePluginPlatform.instance;
//
//   test('$MethodChannelSqflitePlugin is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelSqflitePlugin>());
//   });
//
//   test('getPlatformVersion', () async {
//     SqflitePlugin sqflitePlugin = SqflitePlugin();
//     MockSqflitePluginPlatform fakePlatform = MockSqflitePluginPlatform();
//     SqflitePluginPlatform.instance = fakePlatform;
//
//     expect(await sqflitePlugin.getPlatformVersion(), '42');
//   });
// }
