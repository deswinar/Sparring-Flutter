import 'package:flutter/material.dart';

class RecentBookingsWidget extends StatelessWidget {
  final List<String> bookings;

  const RecentBookingsWidget({super.key, required this.bookings});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: bookings.map((booking) {
        return ListTile(
          title: Text(booking),
          trailing: const Icon(Icons.arrow_forward),
        );
      }).toList(),
    );
  }
}
