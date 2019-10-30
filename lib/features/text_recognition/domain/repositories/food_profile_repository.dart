import 'package:intolera/core/error/failures.dart';
import 'package:intolera/features/text_recognition/domain/entities/food_profile.dart';
import 'package:dartz/dartz.dart';

abstract class FoodProfileRepository {
  Future<Either<Failure, FoodProfile>> getFoodProfileFrom(String category);
  Future<Either<Failure, List<FoodProfile>>> getFoodProfiles();
}
