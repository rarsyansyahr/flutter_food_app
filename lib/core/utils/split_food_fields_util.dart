class SplitFoodFieldsUtil {
  List<String> splitFields(Map<String, dynamic> food, String key) {
    List<String> fields = [];

    for (int i = 1; i <= 20; i++) {
      String? field = food['$key$i'];

      if (field != null && field.isNotEmpty) {
        fields.add(field);
      }
    }

    return fields;
  }
}
