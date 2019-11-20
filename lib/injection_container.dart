import 'package:get_it/get_it.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/food_profile/presentation/bloc/food_profile_bloc.dart';
import 'features/food_profile/domain/usecases/get_food_profiles.dart';
import 'features/food_profile/data/repositories/food_profile_repository_impl.dart';
import 'features/food_profile/domain/repositories/food_profile_repository.dart';
import 'features/food_profile/data/datasources/food_profile_remote_data_source.dart';
import 'features/food_profile/data/datasources/food_profile_local_data_source.dart';
import 'features/text_recognition/presentation/bloc/text_recognition_bloc.dart';
import 'features/text_recognition/domain/usecases/find_profiles.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Food Profiles
  // Bloc
  sl.registerFactory(() => FoodProfileBloc(profiles: sl()));
  sl.registerFactory(() => TextRecognizerBloc(profiles: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetFoodProfiles(sl()));
  sl.registerLazySingleton(() => FindProfiles(sl()));

  // Repository
  sl.registerLazySingleton<FoodProfileRepository>(
    () => FoodProfileRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<FoodProfileRemoteDataSource>(
    () => FoodProfileRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<FoodProfileLocalDataSource>(
    () => FoodProfileLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
