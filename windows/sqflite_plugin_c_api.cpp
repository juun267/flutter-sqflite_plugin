#include "include/sqflite_plugin/sqflite_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "sqflite_plugin.h"

void SqflitePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  sqflite_plugin::SqflitePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
