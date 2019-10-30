import '../models/food_profile_model.dart';

abstract class FoodProfileLocalDataSource {
  /// Gets the cached [FoodProfileModel] which as gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<FoodProfileModel>> getLastFoodProfiles();

  Future<void> cacheFoodProfiles(List<FoodProfileModel> foodProfiles);
}
