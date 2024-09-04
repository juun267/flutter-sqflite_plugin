
import '../model/sqflite_base_model.dart';
import '../extension/object.dart';

class SQFLiteDDLUtil {
  static String create<T extends SQFLiteBaseTable>({required T model}) {
    List<String> columnDefs = [];
    List<String> primaryKeys = [];

    for (var column in model.columns) {
      String columnDef = '${column.name} ${column.type.toSQFLiteFormat()}';
      if (column.isPrimaryKey) {
        primaryKeys.add(column.name);
      }
      if (column.foreignKey.isNotEmpty) {
        columnDef += ' REFERENCES ${column.foreignKey}';
      }
      columnDefs.add(columnDef);
    }

    if (primaryKeys.isNotEmpty) {
      String primaryKeyDef = 'PRIMARY KEY(${primaryKeys.join(', ')})';
      columnDefs.add(primaryKeyDef);
    }

    String createTableSQL = 'CREATE TABLE ${model.tableName} (${columnDefs.join(', ')})';
    return createTableSQL;
  }
}