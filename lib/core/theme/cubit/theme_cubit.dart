// theme_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../app_theme.dart';  // Import your themes
import 'theme_state.dart';  // Import the state class

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(const ThemeState.light());

  void toggleTheme() {
    if (state is LightTheme) {
      emit(const ThemeState.dark());
    } else {
      emit(const ThemeState.light());
    }
  }

  @override
  ThemeState fromJson(Map<String, dynamic> json) {
    if (json['theme'] == 'dark') {
      return const ThemeState.dark();
    } else {
      return const ThemeState.light();
    }
  }

  @override
  Map<String, dynamic> toJson(ThemeState state) {
    return {'theme': state.map(
      light: (_) => 'light',
      dark: (_) => 'dark',
    )};
  }
}
