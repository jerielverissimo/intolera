import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:intolera/features/food_profile/domain/entities/food_profile.dart';

@immutable
abstract class TextRecognizerState extends Equatable {
  TextRecognizerState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends TextRecognizerState {}

class Loading extends TextRecognizerState {}

class Loaded extends TextRecognizerState {
  final List<FoodProfile> profiles;
  Loaded({@required this.profiles}) : super([profiles]);
}

class Error extends TextRecognizerState {
  final String message;

  Error({@required this.message}) : super([message]);
}
