import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:logger/logger.dart';

import './bloc.dart';
import 'package:intolera/core/error/failures.dart';
import 'package:intolera/features/text_recognition/domain/usecases/find_profiles.dart';
import 'package:intolera/features/food_profile/domain/entities/food_profile.dart';
import 'package:intolera/features/text_recognition/domain/entities/words.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class TextRecognizerBloc
    extends Bloc<TextRecognizerEvent, TextRecognizerState> {
  final FindProfiles findProfiles;
  final words = FoundedWords(wordsFound: []);
  final logger = Logger();

  TextRecognizerBloc({@required FindProfiles profiles})
      : assert(profiles != null),
        findProfiles = profiles;

  @override
  TextRecognizerState get initialState => Empty();

  @override
  Stream<TextRecognizerState> mapEventToState(
      TextRecognizerEvent event) async* {
    if (event is FindFoodListProfiles) {
      logger.d('[FindFoodListProfiles Loading] - finding food profiles!');
      yield Loading();

      final failureOrProfiles = await findProfiles(Params(words: event.words));
      print(failureOrProfiles);
      yield* _eitherLoadedOrErrorState(failureOrProfiles);
    }
  }

  Stream<TextRecognizerState> _eitherLoadedOrErrorState(
      Either<Failure, List<FoodProfile>> failureOrProfiles) async* {
    logger.d('[FindFoodListProfiles ] - Result!');
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
