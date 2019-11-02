import '../models/food_profile_model.dart';
import '../transforms/food_profile_transform.dart';
import 'package:intolera/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

abstract class FoodProfileLocalDataSource {
  /// Gets the cached [FoodProfileModel] which as gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<FoodProfileModel>> getLastFoodProfiles();

  Future<void> cacheFoodProfiles(List<FoodProfileModel> foodProfiles);
}
  
const CACHED_FOOD_PROFILES = 'CACHED_FOOD_PROFILES';

class FoodProfileLocalDataSourceImpl implements FoodProfileLocalDataSource {
  final SharedPreferences sharedPreferences;

  FoodProfileLocalDataSourceImpl({@required this.sharedPreferences});

  Future<List<FoodProfileModel>> getLastFoodProfiles() {
    final jsonString = sharedPreferences.getString(CACHED_FOOD_PROFILES);

    if (jsonString != null) {
      final jsonDecoded = json.decode(jsonString);
      return Future.value(jsonDecoded
          .map<FoodProfileModel>((p) => FoodProfileModel.fromJson(p))
          .toList());
    } else {
      throw CacheException();
    }
  }

  Future<void> cacheFoodProfiles(List<FoodProfileModel> foodProfiles) {
    return sharedPreferences.setString(CACHED_FOOD_PROFILES, 
        json.encode(FoodProfileTransform.toListJson(foodProfiles)));
  }
}
