// lib/features/dashboard/presentation/pages/dashboard_page.dart

import 'package:flutter/material.dart';
import '../../domain/entities/arena.dart';
import '../widgets/favorite_arenas_widget.dart';
import '../widgets/featured_arenas_widget.dart';
import '../widgets/filters_widget.dart';
import '../widgets/map_widget.dart';
import '../widgets/notification_bell.dart';
import '../widgets/profile_icon.dart';
import '../widgets/recent_bookings_widget.dart';
import '../widgets/special_offers_widget.dart';
import '../widgets/upcoming_booking_card.dart';
import '../widgets/welcome_message.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  // Centralized dummy data before the build method
  final List<Arena> featuredArenas = [
    Arena(
      id: "1",
      name: "Sky Sports Arena",
      location: "New York, USA",
      sportsTypes: ["Football", "Basketball"],
      rating: 4.5,
      description: "A premium sports arena with top-notch facilities.",
      images: [
        "https://via.placeholder.com/150",
        "https://via.placeholder.com/200"
      ],
      price: 50.0,
      isFeatured: true,
      amenities: ["Parking", "WiFi", "Locker Rooms"],
      availableFields: [
        {"name": "Field 1", "price": 20.0, "availability": true},
        {"name": "Field 2", "price": 25.0, "availability": false}
      ],
      reviews: ["Great place!", "Loved it!"],
    ),
    Arena(
      id: "2",
      name: "Green Valley Sports",
      location: "Los Angeles, USA",
      sportsTypes: ["Tennis", "Badminton"],
      rating: 4.0,
      description: "Affordable and well-maintained sports fields.",
      images: [
        "https://via.placeholder.com/150",
      ],
      price: 30.0,
      isFeatured: true,
      amenities: ["Parking", "Cafeteria"],
      availableFields: [
        {"name": "Court 1", "price": 15.0, "availability": true},
      ],
      reviews: ["Good experience.", "Highly recommend."],
    ),
  ];

  final List<String> recentBookings = const [
    "Booking 1",
    "Booking 2",
    "Booking 3",
  ];

  final List<String> favoriteArenas = const [
    "Arena 1",
    "Arena 4",
    "Arena 6",
  ];

  final List<String> specialOffers = const [
    "20% off on bookings!",
    "Buy 1 Get 1 Free for Tennis Fields!",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const WelcomeMessage(userName: "John Doe"),
            Row(
              children: [
                NotificationBell(notificationCount: 3, onTap: () {}),
                const SizedBox(width: 16),
                ProfileIcon(onTap: () {}),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Upcoming Booking Card
              UpcomingBookingCard(
                venueName: "Elite Sports Arena",
                sport: "Basketball",
                dateTime: DateTime.now().add(const Duration(days: 1)),
                onManage: () {},
              ),

              const SizedBox(height: 16),

              // Discover Section
              FeaturedArenasWidget(
                arenas: featuredArenas,
                onViewAll: () {
                  // Action when "View All" is clicked
                  print("View all featured arenas clicked!");
                },
              ),

              const SizedBox(height: 16),

              // Map & Filters
              Row(
                children: [
                  Expanded(
                    child: MapWidget(onOpenMap: () {}),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FiltersWidget(onApplyFilters: () {}),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Quick Actions
              Text(
                "Quick Actions",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              RecentBookingsWidget(bookings: recentBookings),
              const SizedBox(height: 8),
              FavoriteArenasWidget(favoriteArenas: favoriteArenas),

              const SizedBox(height: 16),

              // Special Offers
              Text(
                "Special Offers",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SpecialOffersWidget(offers: specialOffers),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
