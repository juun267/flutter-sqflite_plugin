
class SQFLiteColumnModel {
  final String name;
  final Object type;
  final bool isPrimaryKey;
  final String foreignKey;

  SQFLiteColumnModel({
    required this.name,
    required this.type,
    this.isPrimaryKey = false,
    this.foreignKey = '',
  });
}