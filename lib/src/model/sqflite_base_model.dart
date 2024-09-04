
import 'sqflite_column_model.dart';

abstract class SQFLiteBaseTable {
  String get tableName;
  List<SQFLiteColumnModel> get columns;
  Map<String, dynamic> toMap();
}