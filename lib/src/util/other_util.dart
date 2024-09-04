

import 'package:sqflite_plugin/src/extension/string.dart';
import 'package:sqflite_plugin/src/model/sqflite_log_model.dart';

class Util {

  static Future<SqfliteLogModel> getLog(String tableName) async {
    final SqfliteLogModel model = SqfliteLogModel();
    final SqfliteLogModel whereModel = SqfliteLogModel(tableModelName: tableName);
    final List<Map<String, dynamic>> mapList = await model.selectMatching(model: whereModel);
    final SqfliteLogModel log = SqfliteLogModel.fromJson(mapList.last);
    return log;
  }

  static String? getCreateTableScripts(String? scripts) {
    if(scripts == null) {
      return null;
    }
    final String removeReferencesScripts = removeReferences(scripts);
    final RegExp regExp = RegExp(r'\(([^)]+)\)');
    final List<RegExpMatch> part = regExp.allMatches(removeReferencesScripts).toList();
    return part.first.group(1);
  }

  static String removeReferences(String createTableScript) {
    // 使用正则表达式匹配并移除从 'REFERENCES' 到下一个 ',' 的所有内容
    String modifiedScript = createTableScript.replaceAll(RegExp(r'REFERENCES[^,]+'), '');
    return modifiedScript;
  }

  static Future<bool> checkLogContain(SqfliteLogModel checkModel) async {
    final SqfliteLogModel model = SqfliteLogModel();
    final SqfliteLogModel whereModel = SqfliteLogModel(
      tableModelName: checkModel.tableModelName,
      version: checkModel.version,
      tableScripts: checkModel.tableScripts
    );
    final List<Map<String, dynamic>> mapList = await model.selectMatching(model: whereModel);
    return mapList.isNotEmpty;
  }

  static Future<List<Map<String, String>>> getLackMapList({required String tableName, required String createTableSql}) async {
    /// 取得log db 目前版本的資料
    final SqfliteLogModel log = await getLog(tableName);
    final Map<String, String> scriptsMap = _getScriptsMap(log.tableScripts);

    /// 取得最新版本的table 資料
    final Map<String, String> tableScriptsMap = _getScriptsMap(createTableSql);

    /// 比對缺少參數
    final List<MapEntry<String, String>> lackKeysList = tableScriptsMap.entries.where((entry) => !scriptsMap.containsKey(entry.key)).toList();
    final List<Map<String, String>> lackKeysListMaps = lackKeysList.map((entry) => {entry.key: entry.value}).toList();
    return lackKeysListMaps;
  }

  static Map<String, String> _getScriptsMap(String? createTableSql) {
    final String tableScripts = Util.getCreateTableScripts(createTableSql) ?? '';
    final Map<String, String> tableScriptsMap = tableScripts.toMapFormat(',');
    return tableScriptsMap;
  }
}
