import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/cloudinary_service.dart';
import 'core/theme/cubit/theme_cubit.dart';
import 'features/auth/data/datasources/auth_local_data_source.dart';
import 'features/auth/data/datasources/auth_local_data_source_impl.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/check_login_status_usecase.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/domain/usecases/register_usecase.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';

final sl = GetIt.instance;

Future<void> setup() async {
  // Initialize SharedPreferences asynchronously
  final sharedPreferences = await SharedPreferences.getInstance();
  // Register CloudinaryService as a singleton
  sl.registerLazySingleton(() => CloudinaryService(cloudName: 'djnfz4ehq'));

  // Register Firebase instances
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Register SharedPreferences instance in GetIt
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl(), sl()),
  );

  // Register local data source with Hive box
  try {
    final userBox = await Hive.openBox('userBox');
    sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(userBox),
    );
  } catch (e) {
    if (kDebugMode) print("Error opening Hive box: $e");
  }

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(localDataSource: sl(), remoteDataSource: sl()),
  );

  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => CheckLoginStatusUseCase(sl()));

  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  sl.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
        loginUseCase: sl(),
        registerUseCase: sl(),
        logoutUseCase: sl(),
        checkLoginStatusUseCase: sl()),
  );
}
