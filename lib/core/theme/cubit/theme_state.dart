// theme_state.dart
import '../app_theme.dart';  // Import your AppTheme

abstract class ThemeState {
  const ThemeState();

  // Optionally add methods to define common behavior if needed
}

class LightTheme extends ThemeState {
  const LightTheme();
}

class DarkTheme extends ThemeState {
  const DarkTheme();
}