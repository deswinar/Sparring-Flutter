import 'package:flutter/material.dart';

class NotificationBell extends StatelessWidget {
  final int notificationCount;
  final VoidCallback onTap;

  const NotificationBell({
    super.key,
    required this.notificationCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Dynamically set the icon color based on the current theme
    final iconColor = Theme.of(context).brightness == Brightness.light
        ? Colors.black87 // Use dark color in light theme
        : Colors.white; // Use light color in dark theme

    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.notifications, color: iconColor),
          onPressed: onTap,
        ),
        if (notificationCount > 0)
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                "$notificationCount",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
