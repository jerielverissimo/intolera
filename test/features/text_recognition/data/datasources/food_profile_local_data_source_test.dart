import '../../../../fixtures/fixture_reader.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'package:matcher/matcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intolera/features/text_recognition/data/datasources/food_profile_local_data_source.dart';
import 'package:intolera/features/text_recognition/data/transforms/food_profile_transform.dart';
import 'package:intolera/features/text_recognition/data/models/food_profile_model.dart';
import 'package:intolera/features/text_recognition/domain/entities/food_profile.dart';
import 'package:intolera/core/error/exceptions.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  FoodProfileLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  const CACHED_FOOD_PROFILES = 'CACHED_FOOD_PROFILES';

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = FoodProfileLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group('getLastFoodProfiles', () {
    test(
      'should retrun a FoodProfile list from SharedPreferences when there is one in the cache',
      () async {
        final jsonDecoded = json.decode(fixture('food_profiles_cached.json'));
        final tProfiles = FoodProfileTransform.fromListJson(jsonDecoded);
        // arrage
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('food_profiles_cached.json'));
        // act
        final result = await dataSource.getLastFoodProfiles();
        // assert
        verify(mockSharedPreferences.getString(CACHED_FOOD_PROFILES));
        expect(result, equals(tProfiles));
      },
    );

    test('should throw a CacheException when there is not a cached value',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final call = dataSource.getLastFoodProfiles;
      // assert
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('cacheFoodProfiles', () {
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

    test('should call SharedPreferences to cache data', () async {
      // act
      dataSource.cacheFoodProfiles(tProfiles);
      // assert
      final expectedJsonString =
          json.encode(FoodProfileTransform.toListJson(tProfiles));
      verify(mockSharedPreferences.setString(
          CACHED_FOOD_PROFILES, expectedJsonString));
    });
  });
}
