import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:logger/logger.dart';
import 'dart:convert';

import '../models/food_profile_model.dart';
import '../../../../core/error/exceptions.dart';
import '../transforms/food_profile_transform.dart';

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

class FoodProfileRemoteDataSourceImpl implements FoodProfileRemoteDataSource {
  final http.Client client;
  final logger = Logger();

  FoodProfileRemoteDataSourceImpl({@required this.client});

  Future<List<FoodProfileModel>> getFoodProfiles() async {
    logger.d(
        '[FoodProfileRemoteDataSource] - Getting food profiles list from server!');

    final response = await client.get('http://134.209.41.142/profiles',
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      logger.d(
          '[FoodProfileRemoteDataSource] - Retrieved food profiles from server!');
      return FoodProfileTransform.fromListJson(json.decode(response.body));
    } else {
      logger.e(
          '[FoodProfileRemoteDataSource] - Failure on retreive food profiles from server!');
      throw ServerException();
    }
  }

  Future<FoodProfileModel> getFoodProfileFrom(String category) async {
    logger
        .d('[FoodProfileRemoteDataSource] - Getting food profile from server!');
    final response = await client.get('http://134.209.41.142/$category',
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      logger.d(
          '[FoodProfileRemoteDataSource] - Retrieved food profile from server!');
      return FoodProfileModel.fromJson(json.decode(response.body));
    } else {
      logger.e(
          '[FoodProfileRemoteDataSource] - Failure on retreive food profile from server!');
      throw ServerException();
    }
  }
}
