//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <sqflite_plugin/sqflite_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) sqflite_plugin_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "SqflitePlugin");
  sqflite_plugin_register_with_registrar(sqflite_plugin_registrar);
}
