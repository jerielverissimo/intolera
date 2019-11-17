import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:logger/logger.dart';

import '../../../../core/network/network_info.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../food_profile/domain/entities/food_profile.dart';
import '../../../food_profile/domain/repositories/food_profile_repository.dart';
import '../datasources/food_profile_local_data_source.dart';
import '../datasources/food_profile_remote_data_source.dart';

class FoodProfileRepositoryImpl implements FoodProfileRepository {
  final FoodProfileRemoteDataSource remoteDataSource;
  final FoodProfileLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final logger = Logger();

  FoodProfileRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  Future<Either<Failure, FoodProfile>> getFoodProfileFrom(
      String category) async {
    if (await networkInfo.isConnected) {
      try {
        logger.d(
            '[FoodProfileRepository] - Getting food profile from remote data source!');

        final remoteProfile =
            await remoteDataSource.getFoodProfileFrom(category);
        return Right(remoteProfile);
      } on ServerException {
        logger.e(
            '[FoodProfileRepository] - Failure on retreive food profile from remote data source!');
        return Left(ServerFailure());
      }
    } else {
      logger.e("[FoodProfileRepository] - There's not internet connection!");
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<FoodProfile>>> getFoodProfiles() async {
    if (await networkInfo.isConnected) {
      try {
        logger.d(
            '[FoodProfileRepository] - Getting food profiles from remote data source!');
        final remoteProfiles = await remoteDataSource.getFoodProfiles();

        logger.d(
            '[FoodProfileRepository] - Calling local data source to cache food profiles!');
        localDataSource.cacheFoodProfiles(remoteProfiles);

        return Right(remoteProfiles);
      } on ServerException {
        logger.e(
            '[FoodProfileRepository] - Failure on retreive food profiles from remote data source!');
        return Left(ServerFailure());
      }
    } else {
      try {
        logger.d(
            '[FoodProfileRepository] - Getting food profiles from local data source!');
        final localProfiles = await localDataSource.getLastFoodProfiles();
        return Right(localProfiles);
      } on CacheException {
        logger.e(
            '[FoodProfileRepository] - failure on retreive food profiles from local data source!');
        return Left(CacheFailure());
      }
    }
  }
}
