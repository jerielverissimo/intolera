import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';

import 'package:intolera/features/text_recognition/domain/entities/words.dart';
import 'package:intolera/features/text_recognition/data/models/words_model.dart';

void main() {
  final tWordsModel = FoundedWordsModel(wordsFound: ['bla', 'teste']);

  test('should be a subclass of FoundedWords', () async {
    // assert
    expect(tWordsModel, isA<FoundedWords>());
  });
}
