import '../models/food_profile_model.dart';
import '../../../../core/error/exceptions.dart';
import '../transforms/food_profile_transform.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';

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

  FoodProfileRemoteDataSourceImpl({@required this.client});

  Future<List<FoodProfileModel>> getFoodProfiles() async {
    final response = await client.get('http://134.209.41.142/profiles',
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return FoodProfileTransform.fromListJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  Future<FoodProfileModel> getFoodProfileFrom(String category) async {
    final response = await client.get('http://134.209.41.142/$category',
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return FoodProfileModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
