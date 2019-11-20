import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:intolera/features/text_recognition/domain/entities/words.dart';

@immutable
abstract class TextRecognizerEvent extends Equatable {
  TextRecognizerEvent([List props = const <dynamic>[]]) : super(props);
}

class FindFoodListProfiles extends TextRecognizerEvent {
  final FoundedWords words;

  FindFoodListProfiles(this.words) : super([words]);
}
