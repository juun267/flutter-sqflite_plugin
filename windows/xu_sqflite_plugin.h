#ifndef FLUTTER_PLUGIN_XU_SQFLITE_PLUGIN_H_
#define FLUTTER_PLUGIN_XU_SQFLITE_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace xu_sqflite_plugin {

class XuSqflitePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  XuSqflitePlugin();

  virtual ~XuSqflitePlugin();

  // Disallow copy and assign.
  XuSqflitePlugin(const XuSqflitePlugin&) = delete;
  XuSqflitePlugin& operator=(const XuSqflitePlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace xu_sqflite_plugin

#endif  // FLUTTER_PLUGIN_XU_SQFLITE_PLUGIN_H_
