// theme_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../app_theme.dart'; // Import your themes
import 'theme_state.dart'; // Import the state classes

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(const LightTheme()); // Default to LightTheme

  void toggleTheme() {
    if (state is LightTheme) {
      emit(const DarkTheme());
    } else {
      emit(const LightTheme());
    }
  }

  @override
  ThemeState fromJson(Map<String, dynamic> json) {
    if (json['theme'] == 'dark') {
      return const DarkTheme();
    } else {
      return const LightTheme();
    }
  }

  @override
  Map<String, dynamic> toJson(ThemeState state) {
    return {'theme': state is DarkTheme ? 'dark' : 'light'};
  }
}
