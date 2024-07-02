class SplitFoodFieldsUtil {
  List<String> splitFields(Map<String, dynamic> food, String key) {
    List<String> ingredients = [];

    for (int i = 1; i <= 20; i++) {
      String? ingredient = food['$key$i'];

      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add(ingredient);
      }
    }

    return ingredients;
  }
}
