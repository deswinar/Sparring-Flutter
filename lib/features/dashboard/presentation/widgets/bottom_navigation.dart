// lib/features/dashboard/presentation/widgets/bottom_navigation.dart

import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomNavigation({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed, // Allows label + icon layout
      backgroundColor: Colors.blueAccent,  // Set your background color
      unselectedItemColor: Colors.white70, // Color for unselected items
      selectedItemColor: Colors.white,    // Color for selected items
      showUnselectedLabels: true, // Show labels when not selected
      selectedFontSize: 14, // Size of the font for selected items
      unselectedFontSize: 12, // Size of the font for unselected items
      iconSize: 28, // Icon size
      elevation: 10, // Shadow effect
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
      ],
    );
  }
}
