import 'package:flutter/material.dart';

class WelcomeMessage extends StatelessWidget {
  final String userName;

  const WelcomeMessage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Hi, $userName!",
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
