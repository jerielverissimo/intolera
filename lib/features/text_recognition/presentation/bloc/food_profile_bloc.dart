import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:intolera/core/usecases/usecase.dart';
import 'package:intolera/core/error/failures.dart';
import 'package:intolera/features/text_recognition/domain/entities/food_profile.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
//import '../../domain/usecases/get_food_profile.dart';
import 'package:intolera/features/text_recognition/domain/usecases/get_food_profiles.dart';

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
      print('init');
      yield Loading();
      print('loading');
      final failureOrProfiles = await getFoodProfiles(NoParams());
      print('called usecase');
      yield failureOrProfiles.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (profiles) => Loaded(profiles: profiles),
      );
    }
  }

  Stream<FoodProfileState> _eitherLoadedOrErrorState(
      Either<Failure, List<FoodProfile>> failureOrProfiles) async* {
    print('Passou por aqui - Either');
    yield failureOrProfiles.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (profiles) => Loaded(profiles: profiles),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    print('deu merda');
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
