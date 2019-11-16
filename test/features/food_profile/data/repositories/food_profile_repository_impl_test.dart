import 'package:intolera/core/error/exceptions.dart';
import 'package:intolera/core/error/failures.dart';
import 'package:intolera/core/network/network_info.dart';
import 'package:intolera/features/food_profile/data/datasources/food_profile_local_data_source.dart';
import 'package:intolera/features/food_profile/data/datasources/food_profile_remote_data_source.dart';
import 'package:intolera/features/food_profile/data/repositories/food_profile_repository_impl.dart';
import 'package:intolera/features/food_profile/data/models/food_profile_model.dart';
import 'package:intolera/features/food_profile/domain/entities/food_profile.dart';

import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockRemoteDataSource extends Mock implements FoodProfileRemoteDataSource {
}

class MockLocalDataSource extends Mock implements FoodProfileLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  FoodProfileRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = FoodProfileRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getFoodProfileFrom', () {
    final tCategory = 'camarão';
    final tFoodProfileModel = FoodProfileModel(
      category: tCategory,
      foodsToExclude: [Food(name: 'food'), Food(name: 'drink')],
      ingredientsOnLabeling: [Ingredient(name: 'ingredient')],
      recipes: [Recipe(name: 'recipe')],
      processedsFoods: [ProcessedFood(name: 'processed')],
    );
    final FoodProfile tFoodProfile = tFoodProfileModel;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.getFoodProfileFrom(tCategory);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getFoodProfileFrom(any))
              .thenAnswer((_) async => tFoodProfileModel);
          // act
          final result = await repository.getFoodProfileFrom(tCategory);
          // assert
          verify(mockRemoteDataSource.getFoodProfileFrom(tCategory));
          expect(result, equals(Right(tFoodProfile)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getFoodProfileFrom(any))
              .thenThrow(ServerException());
          // act
          final result = await repository.getFoodProfileFrom(tCategory);
          // assert
          verify(mockRemoteDataSource.getFoodProfileFrom(tCategory));
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return Failure when is offline.',
        () async {
          // act
          final result = await repository.getFoodProfileFrom(tCategory);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          //expect(Left(ServerFailure), equals(result));
        },
      );
    });
  });

  group('getFoodProfiles', () {
    final tFirstProfile = FoodProfileModel(
      category: 'first',
      foodsToExclude: [Food(name: 'food'), Food(name: 'drink')],
      ingredientsOnLabeling: [Ingredient(name: 'ingredient')],
      recipes: [Recipe(name: 'recipe')],
      processedsFoods: [ProcessedFood(name: 'processed')],
    );

    final tSecondProfile = FoodProfileModel(
      category: 'second',
      foodsToExclude: [Food(name: 'food'), Food(name: 'drink')],
      ingredientsOnLabeling: [Ingredient(name: 'ingredient')],
      recipes: [Recipe(name: 'recipe')],
      processedsFoods: [ProcessedFood(name: 'processed')],
    );

    final tProfiles = [tFirstProfile, tSecondProfile];

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.getFoodProfiles();
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getFoodProfiles())
              .thenAnswer((_) async => tProfiles);
          // act
          final result = await repository.getFoodProfiles();
          // assert
          verify(mockRemoteDataSource.getFoodProfiles());
          expect(result, equals(Right(tProfiles)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getFoodProfiles())
              .thenThrow(ServerException());
          // act
          final result = await repository.getFoodProfiles();
          // assert
          verify(mockRemoteDataSource.getFoodProfiles());
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastFoodProfiles())
              .thenAnswer((_) async => tProfiles);
          // act
          final result = await repository.getFoodProfiles();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastFoodProfiles());
          expect(result, equals(Right(tProfiles)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastFoodProfiles())
              .thenThrow(CacheException());
          // act
          final result = await repository.getFoodProfiles();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastFoodProfiles());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
