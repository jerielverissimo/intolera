import 'package:meta/meta.dart';

import '../../domain/entities/words.dart';

class FoundedWordsModel extends FoundedWords {
  FoundedWordsModel({
    @required wordsFound,
  }) : super(wordsFound: wordsFound);
}
