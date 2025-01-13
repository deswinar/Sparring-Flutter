import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/dashboard/presentation/cubit/change_password/change_password_cubit.dart';
import 'features/dashboard/presentation/cubit/profile/profile_cubit.dart';
import 'injection_container.dart';
import 'router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/cubit/theme_cubit.dart';
import 'core/theme/cubit/theme_state.dart';
import 'package:path_provider/path_provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize HydratedStorage
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  ).then((storage) => HydratedBloc.storage = storage);

  // Ensure that HydratedBloc storage is properly initialized
  HydratedBloc.storage = storage;

  // Initialize Firebase
  // Check if Firebase is already initialized
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if (kDebugMode) print("Firebase initialized successfully");
  } catch (e) {
    if (e is FirebaseException && e.code == 'duplicate-app') {
      if (kDebugMode) print("Firebase has already been initialized.");
    } else {
      if (kDebugMode) print("Error initializing Firebase: $e");
    }
  }

  await setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<ThemeCubit>(),
        ),
        BlocProvider(
          create: (_) => sl<AuthCubit>()..checkLoginStatus(),
        ),
        BlocProvider(
          create: (_) => sl<ChangePasswordCubit>(),
        ),
        BlocProvider(
          create: (_) => sl<ProfileCubit>(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          if (kDebugMode) print(state.toString());
          // Initialize ScreenUtil here before any UI elements are rendered
          return ScreenUtilInit(
            designSize: const Size(
                360, 690), // You can adjust the design size as needed
            minTextAdapt: true,
            builder: (context, child) {
              // Apply the theme based on the state
              return MaterialApp.router(
                title: 'Sparring',
                routerConfig: AppRouter().config(),
                theme: state is LightTheme
                    ? AppTheme.lightTheme // Apply light theme
                    : AppTheme.darkTheme, // Apply dark theme
              );
            },
          );
        },
      ),
    );
  }
}
