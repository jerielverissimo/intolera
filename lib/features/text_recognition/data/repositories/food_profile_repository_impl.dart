import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../core/platform/network_info.dart';
import '../../../core/error/failures.dart';
import '../../../core/error/exceptions.dart';
import '../../../text_recognition/domain/entities/food_profile.dart';
import '../../../text_recognition/domain/repositories/food_profile_repository.dart';
import '../datasources/food_profile_local_data_source.dart';
import '../datasources/food_profile_remote_data_source.dart';

class FoodProfileRepositoryImpl implements FoodProfileRepository {
  final FoodProfileRemoteDataSource remoteDataSource;
  final FoodProfileLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  FoodProfileRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  Future<Either<Failure, FoodProfile>> getFoodProfileFrom(
      String category) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProfile =
            await remoteDataSource.getFoodProfileFrom(category);
        return Right(remoteProfile);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<FoodProfile>>> getFoodProfiles() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProfiles = await remoteDataSource.getFoodProfiles();
        localDataSource.cacheFoodProfiles(remoteProfiles);
        return Right(remoteProfiles);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localProfiles = await localDataSource.getLastFoodProfiles();
        return Right(localProfiles);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
