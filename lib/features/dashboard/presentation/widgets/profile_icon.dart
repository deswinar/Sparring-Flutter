import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  final VoidCallback onTap;

  const ProfileIcon({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Colors.grey[300],
        child: const Icon(Icons.person, color: Colors.blueAccent),
      ),
    );
  }
}
