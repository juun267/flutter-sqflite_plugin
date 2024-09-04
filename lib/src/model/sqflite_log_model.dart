import 'package:sqflite_plugin/sqflite_plugin.dart';

class SqfliteLogModel extends SQFLiteHandler implements SQFLiteBaseTable {
  final String? tableModelName;
  final num? version;
  final String? tableScripts;

  SqfliteLogModel({
    this.tableModelName,
    this.version,
    this.tableScripts,
  });

  @override
  String get tableName => 'SqfliteLogModel';

  @override
  List<SQFLiteColumnModel> get columns => [
    SQFLiteColumnModel(name: 'tableModelName', type: String, isPrimaryKey: true),
    SQFLiteColumnModel(name: 'version', type: int),
    SQFLiteColumnModel(name: 'tableScripts', type: String),
  ];

  @override
  String get createTableSql => SQFLiteDDLUtil.create(model: SqfliteLogModel());

  @override
  Map<String, dynamic> toMap() {
    return {
    'tableModelName': tableModelName,
    'version': version,
    'tableScripts': tableScripts,
    };
  }

  factory SqfliteLogModel.fromJson(Map<String, dynamic> jsonData) {
    return SqfliteLogModel(
      tableModelName: jsonData['tableModelName'] as String?,
      version: jsonData['version'] as num?,
      tableScripts: jsonData['tableScripts'] as String?,
    );
  }
}
