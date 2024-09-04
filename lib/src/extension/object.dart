

extension ObjectExtension on Object {
  String toSQFLiteFormat() {
    switch (this) {
      case int:
        return "INTEGER";
      case String:
        return "TEXT";
      default:
        return "NULL";
    }
  }
}
