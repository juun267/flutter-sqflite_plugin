
import '../model/sqflite_base_model.dart';
import '../extension/object.dart';

class SQFLiteDQLUtil {
  static String joinQuery<T extends SQFLiteBaseTable>({
    required String targetTable,
    required String foreignKey,
    required List<String> mainTableColumns,
    required String joinTable,
    required String onCondition
  }) {
    String columnsToSelect = mainTableColumns.map((column) => '$targetTable.$column').join(', ');

    String joinStatements = 'INNER JOIN $joinTable ON $targetTable.$foreignKey = $joinTable.$onCondition';

    String query = '''
      SELECT $columnsToSelect
      FROM $targetTable
      $joinStatements;
    ''';

    return query;
  }
}
