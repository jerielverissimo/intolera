import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Words extends Equatable {
  final List<String> wordsFound;

  Words({@required this.wordsFound}) : super([wordsFound]);
}

