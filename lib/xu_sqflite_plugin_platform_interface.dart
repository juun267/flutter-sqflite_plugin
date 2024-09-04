import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'xu_sqflite_plugin_method_channel.dart';

abstract class XuSqflitePluginPlatform extends PlatformInterface {
  /// Constructs a XuSqflitePluginPlatform.
  XuSqflitePluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static XuSqflitePluginPlatform _instance = MethodChannelXuSqflitePlugin();

  /// The default instance of [XuSqflitePluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelXuSqflitePlugin].
  static XuSqflitePluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [XuSqflitePluginPlatform] when
  /// they register themselves.
  static set instance(XuSqflitePluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
