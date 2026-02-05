import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/datasources/auth_local_datasource_impl.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/datasources/auth_remote_datasource_impl.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/get_current_user_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../constants/app_constants.dart';
import '../network/network_client.dart';
import '../network/network_info.dart';

/// Global service locator instance
final sl = GetIt.instance;

/// Initialize all dependencies
Future<void> initDependencies() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Open Hive boxes
  await _openHiveBoxes();

  // Core
  await _initCore();

  // Features
  await _initAuthFeature();
  // Add more feature initializations here
}

/// Open Hive boxes
Future<void> _openHiveBoxes() async {
  await Hive.openBox(AppConstants.settingsBox);
  await Hive.openBox(AppConstants.cacheBox);
}

/// Initialize core dependencies
Future<void> _initCore() async {
  // Network Info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // Dio
  sl.registerLazySingleton<Dio>(() => Dio());

  // Network Client
  sl.registerLazySingleton<NetworkClient>(
    () => NetworkClient(dio: sl(), networkInfo: sl()),
  );

  // Hive Boxes
  sl.registerLazySingleton<Box>(() => Hive.box(AppConstants.settingsBox));
}

/// Initialize auth feature dependencies
Future<void> _initAuthFeature() async {
  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(networkClient: sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(box: sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
}
