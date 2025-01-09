import 'package:flutter/material.dart';

class UpcomingBookingCard extends StatelessWidget {
  final String venueName;
  final String sport;
  final DateTime dateTime;
  final VoidCallback onManage;

  const UpcomingBookingCard({
    super.key,
    required this.venueName,
    required this.sport,
    required this.dateTime,
    required this.onManage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$sport at $venueName",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              "Date: ${dateTime.toLocal()}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: onManage,
              child: const Text("Manage Booking"),
            ),
          ],
        ),
      ),
    );
  }
}
