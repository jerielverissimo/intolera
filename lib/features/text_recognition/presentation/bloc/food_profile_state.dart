import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:intolera/features/text_recognition/domain/entities/food_profile.dart';

@immutable
abstract class FoodProfileState extends Equatable {
  FoodProfileState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends FoodProfileState {}

class Loading extends FoodProfileState {}

class Loaded extends FoodProfileState {
  final List<FoodProfile> profiles;
  Loaded({@required this.profiles}) : super([profiles]);
}

class Error extends FoodProfileState {
  final String message;

  Error({@required this.message}) : super([message]);
}
