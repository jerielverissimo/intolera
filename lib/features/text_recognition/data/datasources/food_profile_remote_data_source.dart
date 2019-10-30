import '../models/food_profile_model.dart';

abstract class FoodProfileRemoteDataSource {
  /// Calls the http://134.209.41.142/profiles endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<FoodProfileModel>> getFoodProfiles();

  /// Calls the http://134.209.41.142/{category} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<FoodProfileModel> getFoodProfileFrom(String category);
}
