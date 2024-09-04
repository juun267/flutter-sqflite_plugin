#include "include/xu_sqflite_plugin/xu_sqflite_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "xu_sqflite_plugin.h"

void XuSqflitePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  xu_sqflite_plugin::XuSqflitePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
