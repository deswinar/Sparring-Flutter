import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../router/app_router.dart';
import '../cubit/auth_cubit.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onLoginPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().login(
            _emailController.text.trim(),
            _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login successful!')),
          );
          context.replaceRoute(const MainDashboardRoute());
          // Navigate to the next page or dashboard
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Email field with icon
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Password field with icon
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),

              // Login button with a gradient effect
              state is AuthLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _onLoginPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context)
                            .primaryColor, // Default background color
                        foregroundColor: Theme.of(context)
                            .secondaryHeaderColor, // Text color
                        padding: const EdgeInsets.symmetric(
                            vertical: 16), // Padding inside the button
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12.0), // Rounded corners
                        ),
                        elevation: 4, // Button shadow (depth)
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight:
                              FontWeight.bold, // Bold text for prominence
                        ),
                        overlayColor: Theme.of(context)
                            .primaryColor
                            .withOpacity(0.2), // Change color on press
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
              const SizedBox(height: 16),

              // Option to register
              TextButton(
                onPressed: () {
                  // Navigate to registration page
                  context.pushRoute(const RegisterRoute());
                },
                child: Text(
                  'Don\'t have an account? Register here.',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),

              // Forgot password option
              TextButton(
                onPressed: () {
                  // Navigate to Forgot Password page
                  // context.pushRoute(const ForgotPasswordRoute());
                },
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
