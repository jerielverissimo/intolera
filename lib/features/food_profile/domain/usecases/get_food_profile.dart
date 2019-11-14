import 'package:intolera/core/error/failures.dart';
import 'package:intolera/core/usecases/usecase.dart';
import 'package:intolera/features/text_recognition/domain/entities/food_profile.dart';
import '../repositories/food_profile_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

class GetFoodProfile implements UseCase<FoodProfile, Params> {
  final FoodProfileRepository repository;

  GetFoodProfile(this.repository);

  @override
  Future<Either<Failure, FoodProfile>> call(Params params) async {
    return await repository.getFoodProfileFrom(params.category);
  }
}

class Params extends Equatable {
  final String category;

  Params({@required this.category}) : super([category]);
}
