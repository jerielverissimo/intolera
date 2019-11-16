import 'package:intolera/features/food_profile/domain/repositories/food_profile_repository.dart';
import 'package:intolera/features/food_profile/domain/usecases/get_food_profiles.dart';
import 'package:intolera/features/food_profile/domain/entities/food_profile.dart';
import 'package:intolera/core/usecases/usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

class MockFoodProfileRepository extends Mock implements FoodProfileRepository {}

void main() {
  GetFoodProfiles usecase;
  MockFoodProfileRepository mockFoodProfileRepository;

  setUp(() {
    mockFoodProfileRepository = MockFoodProfileRepository();
    usecase = GetFoodProfiles(mockFoodProfileRepository);
  });

  final tFirstProfile = FoodProfile();
  final tSecondProfile = FoodProfile();
  final tProfiles = [tFirstProfile, tSecondProfile];

  test('should get food profiles from repository', () async {
    // arrange
    when(mockFoodProfileRepository.getFoodProfiles())
        .thenAnswer((_) async => Right(tProfiles));

    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, Right(tProfiles));
    verify(mockFoodProfileRepository.getFoodProfiles());
    verifyNoMoreInteractions(mockFoodProfileRepository);
  });
}
