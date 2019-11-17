import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class FoundedWords extends Equatable {
  final List<String> wordsFound;

  FoundedWords({@required this.wordsFound}) : super([wordsFound]);
}

