// lib/features/dashboard/presentation/pages/main_dashboard_page.dart

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'explore_page.dart';
import 'bookings_page.dart';
import 'profile_page.dart';

@RoutePage()
class MainDashboardPage extends StatefulWidget {
  const MainDashboardPage({super.key});

  @override
  _MainDashboardPageState createState() => _MainDashboardPageState();
}

class _MainDashboardPageState extends State<MainDashboardPage> {
  // Index to track the selected tab
  int _selectedIndex = 0;

  // List of pages to display based on the selected tab
  final List<Widget> _pages = [
    DashboardPage(),
    ExplorePage(),
    BookingsPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sports Arena App"),
        backgroundColor: Colors.blueAccent,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_selectedIndex],
      ), //  // Show selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Update the selected index on tap
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
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
      ),
    );
  }
}
