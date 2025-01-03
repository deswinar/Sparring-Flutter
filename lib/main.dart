import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:sparring/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:sparring/injection_container.dart';
import 'package:sparring/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/cubit/theme_cubit.dart';
import 'core/theme/cubit/theme_state.dart';
import 'home_screen.dart';
import 'package:path_provider/path_provider.dart';

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

  setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ThemeCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<AuthCubit>(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
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
                theme: state.map(
                  light: (_) => AppTheme.lightTheme, // Apply light theme
                  dark: (_) => AppTheme.darkTheme, // Apply dark theme
                ),
              );
            },
          );
        },
      ),
    );
  }
}
