import 'package:intolera/core/error/failures.dart';
import 'package:intolera/features/food_profile/domain/entities/food_profile.dart';
import 'package:dartz/dartz.dart';

abstract class FoodProfileRepository {
  Future<Either<Failure, FoodProfile>> getFoodProfileFrom(String category);
  Future<Either<Failure, List<FoodProfile>>> getFoodProfiles();
}
