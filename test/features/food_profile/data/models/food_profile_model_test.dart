import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:intolera/features/food_profile/domain/entities/food_profile.dart';
import 'package:intolera/features/food_profile/data/models/food_profile_model.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tFoodProfileModel = FoodProfileModel(
    category: 'Test',
    foodsToExclude: [Food(name: 'food'), Food(name: 'drink')],
    ingredientsOnLabeling: [Ingredient(name: 'ingredient')],
    recipes: [Recipe(name: 'recipe')],
    processedsFoods: [ProcessedFood(name: 'processed')],
  );

  final tFoodProfileModelWithoutIngredient = FoodProfileModel(
    category: 'Test',
    foodsToExclude: [Food(name: 'food'), Food(name: 'drink')],
    recipes: [Recipe(name: 'recipe')],
    processedsFoods: [ProcessedFood(name: 'processed')],
  );

  test('should be a subclass of FoodProfile', () async {
    // assert
    expect(tFoodProfileModel, isA<FoodProfile>());
  });

  group('fromJson', () {
    test('should return a valid model when all the JSON properties is present',
        () async {
      // arrange
      final jsonMap = json.decode(fixture('food_profile.json'));
      // act
      final result = FoodProfileModel.fromJson(jsonMap);
      // assert
      expect(result, tFoodProfileModel);
    });

    test(
        'should return a valid model when the JSON ingredientsOnLabeling is not present',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('food_profile_without_ingredients.json'));
      // act
      final result = FoodProfileModel.fromJson(jsonMap);
      // assert
      expect(result, tFoodProfileModelWithoutIngredient);
    });

    test(
        'should not return a valid model when the JSON category is not present',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('food_profile_without_category.json'));
      // act
      final result = FoodProfileModel.fromJson(jsonMap);
      // assert
      expect(result, null);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // act
      final result = tFoodProfileModel.toJson();
      // assert
      final expectedMap = {
        "category": "Test",
        "foods_to_exclude": ["food", "drink"],
        "ingredients_on_labeling": ["ingredient"],
        "recipes": ["recipe"],
        "processed_foods": ["processed"],
      };

      expect(result, expectedMap);
    });
  });
}
