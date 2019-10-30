import 'package:intolera/core/error/failures.dart';
import 'package:intolera/core/usecases/usecase.dart';
import 'package:intolera/features/text_recognition/domain/entities/food_profile.dart';
import '../repositories/food_profile_repository.dart';
import 'package:dartz/dartz.dart';

class GetFoodProfiles implements UseCase<List<FoodProfile>, NoParams> {
  final FoodProfileRepository repository;

  GetFoodProfiles(this.repository);

  @override
  Future<Either<Failure, List<FoodProfile>>> call(NoParams params) async {
    return await repository.getFoodProfiles();
  }
}
