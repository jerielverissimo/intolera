import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:intolera/features/text_recognition/domain/entities/food_profile.dart';
import 'package:intolera/features/text_recognition/data/models/food_profile_model.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tFoodProfileModel = FoodProfileModel(
    category: 'Test',
    foodsToExclude: [Food(name: 'food'), Food(name: 'drink')],
    ingredientsOnLabeling: [Ingredient(name: 'ingredient')],
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
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('food_profile.json'));
      // act
      final result = FoodProfileModel.fromJson(jsonMap);
      // assert
      expect(result, tFoodProfileModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // act
      final result = tFoodProfileModel.toJson();
      // assert
      final expectedMap = {
        "category": "Test",
        "foodsToExclude": ["food", "drink"],
        "ingredientsOnLabeling": ["ingredient"],
        "recipes": ["recipe"],
        "processedsFoods": ["processed"],
      };

      expect(result, expectedMap);
    });
  });
}