// theme_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../app_theme.dart';  // Import your AppTheme

part 'theme_state.freezed.dart';

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState.light() = LightTheme;
  const factory ThemeState.dark() = DarkTheme;
}
