import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class FoodProfile extends Equatable {
  final String category; // TODO: Transform to Enum?
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

class TypeValue extends Equatable {
  final String name;

  TypeValue({@required this.name}) : super([name]);
}

class Food extends TypeValue {
  Food({@required String name}) : super(name: name);
}

class Ingredient extends TypeValue {
  Ingredient({@required String name}) : super(name: name);
}

class Recipe extends TypeValue {
  Recipe({@required String name}) : super(name: name);
}

class ProcessedFood extends TypeValue {
  ProcessedFood({@required String name}) : super(name: name);
}
