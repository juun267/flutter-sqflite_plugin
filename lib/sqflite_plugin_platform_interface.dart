import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'sqflite_plugin_method_channel.dart';

abstract class SqflitePluginPlatform extends PlatformInterface {
  /// Constructs a SqflitePluginPlatform.
  SqflitePluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static SqflitePluginPlatform _instance = MethodChannelSqflitePlugin();

  /// The default instance of [SqflitePluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelSqflitePlugin].
  static SqflitePluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SqflitePluginPlatform] when
  /// they register themselves.
  static set instance(SqflitePluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
