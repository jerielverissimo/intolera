import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import 'package:intolera/core/error/failures.dart';
import 'package:intolera/core/usecases/usecase.dart';
import 'package:intolera/features/food_profile/domain/entities/food_profile.dart';
import '../repositories/food_profile_repository.dart';

class GetFoodProfiles implements UseCase<List<FoodProfile>, NoParams> {
  final FoodProfileRepository repository;
  final logger = Logger();

  GetFoodProfiles(this.repository);

  @override
  Future<Either<Failure, List<FoodProfile>>> call(NoParams params) async {
    logger.d('[GetFoodProfiles] - Getting food profiles!');
    return await repository.getFoodProfiles();
  }
}
