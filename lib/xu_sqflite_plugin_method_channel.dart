import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'xu_sqflite_plugin_platform_interface.dart';

/// An implementation of [XuSqflitePluginPlatform] that uses method channels.
class MethodChannelXuSqflitePlugin extends XuSqflitePluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('xu_sqflite_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
