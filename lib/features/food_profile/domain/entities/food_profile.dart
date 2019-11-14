import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class FoodProfile extends Equatable {
  final String category;
  final List<Food> foodsToExclude;
  final List<Ingredient> ingredientsOnLabeling;
  final List<Recipe> recipes;
  final List<ProcessedFood> processedsFoods;

  FoodProfile({
    @required this.category,
    @required this.foodsToExclude,
    @required this.recipes,
    @required this.processedsFoods,
    this.ingredientsOnLabeling,
  }) : super(
          [
            category,
            foodsToExclude,
            ingredientsOnLabeling,
            recipes,
            processedsFoods
          ],
        );
}

class Food extends Equatable {
  final String name;
  Food({@required this.name});
}

class Ingredient extends Equatable {
  final String name;
  Ingredient({@required this.name});
}

class Recipe extends Equatable {
  final String name;
  Recipe({@required this.name});
}

class ProcessedFood extends Equatable {
  final String name;
  ProcessedFood({@required this.name});
}
