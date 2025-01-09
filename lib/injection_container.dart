import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparring/core/network/api_client.dart';
import 'core/theme/cubit/theme_cubit.dart';
import 'core/utils/constants.dart';
import 'features/auth/data/datasources/auth_local_data_source.dart';
import 'features/auth/data/datasources/auth_local_data_source_impl.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/register_usecase.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  // Initialize SharedPreferences asynchronously
  final sharedPreferences = await SharedPreferences.getInstance();

  // Register SharedPreferences instance in GetIt
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Register other services and dependencies
  getIt.registerLazySingleton(
      () => ApiClient(baseUrl)); // baseUrl from constants
  getIt.registerLazySingleton(() => http.Client());

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(localDataSource: getIt()),
  );

  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => RegisterUseCase(getIt()));

  getIt.registerFactory<ThemeCubit>(() => ThemeCubit());
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(loginUseCase: getIt(), registerUseCase: getIt()),
  );
}
