import 'package:intolera/features/food_profile/domain/repositories/food_profile_repository.dart';
import 'package:intolera/features/food_profile/domain/usecases/get_food_profile.dart';
import 'package:intolera/features/food_profile/domain/entities/food_profile.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

class MockFoodProfileRepository extends Mock implements FoodProfileRepository {}

void main() {
  GetFoodProfile usecase;
  MockFoodProfileRepository mockFoodProfileRepository;

  setUp(() {
    mockFoodProfileRepository = MockFoodProfileRepository();
    usecase = GetFoodProfile(mockFoodProfileRepository);
  });

  final tCategory = 'Alergia a Camarão';
  final tProfile = FoodProfile(
    category: 'Alergia a Camarão',
    foodsToExclude: [Food(name: 'Doritos')],
    recipes: [Recipe(name: 'recipe')],
    processedsFoods: [ProcessedFood(name: 'salgadinho')],
  );

  test('should get food profile for category from repository', () async {
    // arrange
    when(mockFoodProfileRepository.getFoodProfileFrom(any))
        .thenAnswer((_) async => Right(tProfile));

    // act
    final result = await usecase(Params(category: tCategory));
    // assert
    expect(result, Right(tProfile));
    verify(mockFoodProfileRepository.getFoodProfileFrom(tCategory));
    verifyNoMoreInteractions(mockFoodProfileRepository);
  });
}
