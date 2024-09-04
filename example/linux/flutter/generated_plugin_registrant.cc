//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <xu_sqflite_plugin/xu_sqflite_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) xu_sqflite_plugin_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "XuSqflitePlugin");
  xu_sqflite_plugin_register_with_registrar(xu_sqflite_plugin_registrar);
}
