
import 'package:xu_sqflite_plugin/src/model/sqflite_base_model.dart';

class SQFLiteDMLUtil {
  static String search<T extends SQFLiteBaseTable>({required T model}) {
    String searchTableSQL = 'SELECT * FROM ${model.tableName}';
    return searchTableSQL;
  }

  static String update<T extends SQFLiteBaseTable>({
    required T model,
    required String updateName,
    required dynamic updateValue,
    required String selectName,
    required dynamic selectValue,
  }) {
    String updateTableSQL = 'UPDATE ${model.tableName} SET $updateName = $updateValue WHERE $selectName = $selectValue';
    return updateTableSQL;
  }

  static String delete<T extends SQFLiteBaseTable>({
    required T model,
    required String selectName,
    required dynamic selectValue,
  }) {
    String deleteTableSQL = 'DELETE FROM ${model.tableName} WHERE $selectName = $selectValue';
    return deleteTableSQL;
  }
}
