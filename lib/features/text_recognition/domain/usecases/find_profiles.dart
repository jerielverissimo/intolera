import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import 'package:intolera/core/error/failures.dart';
import 'package:intolera/core/usecases/usecase.dart';
import '../entities/words.dart';
import 'package:intolera/features/food_profile/domain/entities/food_profile.dart';
import 'package:intolera/features/food_profile/domain/usecases/get_food_profiles.dart';

class FindProfiles implements UseCase<List<FoodProfile>, Params> {
  final GetFoodProfiles usecase;
  final logger = Logger();
  final regex = r"(s\b|\b)";

  Either<Failure, List<FoodProfile>> profiles;

  FindProfiles(this.usecase);

  @override
  Future<Either<Failure, List<FoodProfile>>> call(Params params) async {
    this.profiles = await usecase.call(NoParams());

    print(profiles);
    final wf = params.words.wordsFound;
    print(wf);

    logger.d('[FindProfiles] - Finding food profiles!');
    print('Onde estou?');
    profiles.forEach((p) => print(p));
    print('Passa daqui?');
    List<FoodProfile> res;
    profiles.fold(
      (failure) => [],
      (profiles) =>
          res = profiles.where((p) => _searchForWords(wf, p)).toList(),
    );

    res.forEach((p) => print(p.category));
    print('SIM!');
    return Right(res);
  }

  bool _searchForWords(List<String> words, FoodProfile p) {
    return _searchOnCategory(words, p) ||
        _searchOnFoodsToExclude(words, p) ||
        _searchOnIngredients(words, p) ||
        _searchOnRecipes(words, p) ||
        _searchOnProcesseds(words, p);
  }

  bool _searchOnCategory(List<String> words, FoodProfile profile) {
    return words.any((w) => w.contains(RegExp(
        "(" + profile.category + ")" + regex,
        caseSensitive: false)));
  }

  bool _searchOnFoodsToExclude(List<String> words, FoodProfile profile) {
    return words.any((w) => profile.foodsToExclude.any((f) => w.contains(
        RegExp("(" + f.name + ")" + regex, caseSensitive: false))));
  }

  bool _searchOnIngredients(List<String> words, FoodProfile profile) {
    return words.any((w) => profile.ingredientsOnLabeling.any((i) => w.contains(
        RegExp("(" + i.name + ")" + regex, caseSensitive: false))));
  }

  bool _searchOnRecipes(List<String> words, FoodProfile profile) {
    return words.any((w) => profile.recipes.any((r) => w.contains(
        RegExp("(" + r.name + ")" + regex, caseSensitive: false))));
  }

  bool _searchOnProcesseds(List<String> words, FoodProfile profile) {
    return words.any((w) => profile.processedsFoods.any((p) => w.contains(
        RegExp("(" + p.name + ")" + regex, caseSensitive: false))));
  }
}

class Params extends Equatable {
  final FoundedWords words;
  Params({@required this.words}) : super([words]);
}
