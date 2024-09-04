import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'sqflite_plugin_platform_interface.dart';

/// An implementation of [SqflitePluginPlatform] that uses method channels.
class MethodChannelSqflitePlugin extends SqflitePluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('sqflite_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
