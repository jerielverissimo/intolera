import 'package:intolera/features/food_profile/domain/usecases/get_food_profile.dart';
import 'package:intolera/features/text_recognition/domain/usecases/find_profiles.dart';
import 'package:intolera/core/usecases/usecase.dart';

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

class MockFindFoodProfiles extends Mock implements FindProfiles {}

void main() {
  FindProfiles usecase;
  MockFindFoodProfiles mockFindFoodProfiles;

  setUp(() {
    mockFindFoodProfiles = MockFindFoodProfiles();
    //usecase = FindProfiles(mockFindFoodProfiles);
  });
}

