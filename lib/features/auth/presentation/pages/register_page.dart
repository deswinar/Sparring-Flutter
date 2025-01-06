import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/cubit/theme_cubit.dart';
import '../widgets/register_form.dart';

@RoutePage()
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main Content
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        // Custom Header
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).primaryColor.withOpacity(0.8),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 48.0,
                            horizontal: 24.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Create Account',
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                      color: Theme.of(context).secondaryHeaderColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'Fill the details to register',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).secondaryHeaderColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        // Form Card
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              elevation: 8.0,
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: RegisterForm(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          ),
          // Theme Toggle Button
          Positioned(
            top: 16.0,
            right: 16.0,
            child: IconButton(
              icon: Icon(
                Icons.brightness_6,
                color: Theme.of(context).iconTheme.color,
              ),
              tooltip: 'Toggle Light/Dark Mode',
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
            ),
          ),
        ],
      ),
    );
  }
}
