import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FoodProfileEvent extends Equatable {
  FoodProfileEvent([List props = const <dynamic>[]]) : super(props);
}

class GetFoodListProfiles extends FoodProfileEvent {}

class GetFoodProfileForCategory extends FoodProfileEvent {}
