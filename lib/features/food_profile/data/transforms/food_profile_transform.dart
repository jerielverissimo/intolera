import 'package:intolera/features/food_profile/data/models/food_profile_model.dart';

class FoodProfileTransform {
  static List<Map<String, dynamic>> toListJson(
      List<FoodProfileModel> profiles) {
    return profiles
        .map((p) => {
              'category': p.category,
              'foods_to_exclude': p.foodsToExclude.map((f) => f.name).toList(),
              'ingredients_on_labeling':
                  p.ingredientsOnLabeling.map((i) => i.name).toList(),
              'recipes': p.recipes.map((r) => r.name).toList(),
              'processed_foods': p.processedsFoods.map((p) => p.name).toList(),
            })
        .toList();
  }

  static List<FoodProfileModel> fromListJson(List<dynamic> profiles) {
    return profiles.map<FoodProfileModel>((p) => FoodProfileModel.fromJson(p)).toList();
  }
}
