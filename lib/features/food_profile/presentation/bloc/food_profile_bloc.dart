import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:intolera/core/usecases/usecase.dart';
import 'package:intolera/core/error/failures.dart';
import 'package:intolera/features/food_profile/domain/entities/food_profile.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import '../../domain/usecases/get_food_profiles.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class FoodProfileBloc extends Bloc<FoodProfileEvent, FoodProfileState> {
  final GetFoodProfiles getFoodProfiles;

  FoodProfileBloc({@required GetFoodProfiles profiles})
      : assert(profiles != null),
        getFoodProfiles = profiles;

  @override
  FoodProfileState get initialState => Empty();

  @override
  Stream<FoodProfileState> mapEventToState(FoodProfileEvent event) async* {
    if (event is GetFoodListProfiles) {
      yield Loading();
      final failureOrProfiles = await getFoodProfiles(NoParams());
      print('Vou pro carregado!');
      yield* _eitherLoadedOrErrorState(failureOrProfiles);
    }
  }

  Stream<FoodProfileState> _eitherLoadedOrErrorState(
      Either<Failure, List<FoodProfile>> failureOrProfiles) async* {
    print('Estou no carregado!');
    yield failureOrProfiles.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (profiles) => Loaded(profiles: profiles),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
