import 'package:meta/meta.dart';
import 'package:intolera/features/text_recognition/domain/entities/food_profile.dart';

class FoodProfileModel extends FoodProfile {
  FoodProfileModel({
    @required category,
    @required foodsToExclude,
    @required recipes,
    @required processedsFoods,
    ingredientsOnLabeling,
  }) : super(
          category: category,
          foodsToExclude: foodsToExclude,
          ingredientsOnLabeling: ingredientsOnLabeling,
          recipes: recipes,
          processedsFoods: processedsFoods,
        );

  factory FoodProfileModel.fromJson(Map<String, dynamic> json) {
    return json['category'] == null
        ? null
        : FoodProfileModel(
            category: json['category'],
            foodsToExclude:
                json['foodsToExclude'].map<Food>((s) => Food(name: s)).toList(),
            ingredientsOnLabeling: json['ingredientsOnLabeling'] != null
                ? json['ingredientsOnLabeling']
                    .map<Ingredient>((s) => Ingredient(name: s))
                    .toList()
                : null,
            recipes:
                json['recipes'].map<Recipe>((s) => Recipe(name: s)).toList(),
            processedsFoods: json['processedsFoods']
                .map<ProcessedFood>((s) => ProcessedFood(name: s))
                .toList(),
          );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'foodsToExclude': foodsToExclude.map((f) => f.name).toList(),
      'ingredientsOnLabeling':
          ingredientsOnLabeling.map((i) => i.name).toList(),
      'recipes': recipes.map((r) => r.name).toList(),
      'processedsFoods': processedsFoods.map((p) => p.name).toList(),
    };
  }
}

