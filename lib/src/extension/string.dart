

extension StringExtension on String {
  Map<String, String> toMapFormat(String split) {
    Map<String, String> keyValueMap = {};

    /// 移除 PRIMARY KEY 字眼
    final String str = this.split(split).where((element) => !element.trim().startsWith('PRIMARY KEY')).join(split);

    /// 分割字符串
    final List<String> fields = str.split(split);
    fields.forEach((field) {
      final List<String> parts = field.trim().split(' ');
      if (parts.length >= 2) {
        keyValueMap[parts[0].trim()] = parts[1].trim();
      }
    });

    return keyValueMap;
  }
}
