import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:intolera/features/food_profile/domain/entities/food_profile.dart';
import 'package:intolera/features/food_profile/data/transforms/food_profile_transform.dart';
import 'package:intolera/features/food_profile/data/models/food_profile_model.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {


  group('toListJson', () {
    final tFirstProfile = FoodProfileModel(
      category: 'Test',
      foodsToExclude: [Food(name: 'food'), Food(name: 'drink')],
      ingredientsOnLabeling: [Ingredient(name: 'ingredient')],
      recipes: [Recipe(name: 'recipe')],
      processedsFoods: [ProcessedFood(name: 'processed')],
    );
    final tSecondProfile = FoodProfileModel(
      category: 'Test',
      foodsToExclude: [Food(name: 'food'), Food(name: 'drink')],
      ingredientsOnLabeling: [Ingredient(name: 'ingredient')],
      recipes: [Recipe(name: 'recipe')],
      processedsFoods: [ProcessedFood(name: 'processed')],
    );

    final tProfiles = [tFirstProfile, tSecondProfile];

    test('should return a JSON list containing the proper data', () async {
      // act
      final result = FoodProfileTransform.toListJson(tProfiles); 
      // assert
      final expectedMap = [{
        "category": "Test",
        "foods_to_exclude": ["food", "drink"],
        "ingredients_on_labeling": ["ingredient"],
        "recipes": ["recipe"],
        "processed_foods": ["processed"],
      },{
        "category": "Test",
        "foods_to_exclude": ["food", "drink"],
        "ingredients_on_labeling": ["ingredient"],
        "recipes": ["recipe"],
        "processed_foods": ["processed"],
      }];

      expect(result, expectedMap);
    });
  });

}
