// home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/cubit/theme_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Theme with HydratedCubit")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Toggle the theme on button press
            context.read<ThemeCubit>().toggleTheme();
          },
          child: const Text("Toggle Theme"),
        ),
      ),
    );
  }
}
