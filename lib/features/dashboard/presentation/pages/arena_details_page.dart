import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../domain/entities/arena.dart';

@RoutePage()
class ArenaDetailsPage extends StatelessWidget {
  final Arena arena;

  // Constructor accepting the arena details
  const ArenaDetailsPage({super.key, required this.arena});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        title: Text(arena.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // Save to favorites functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share arena functionality
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          // 1. Header Section (Top)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Arena Name
                Text(
                  arena.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8.0),

                // Hero Image or Carousel
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: height / 2),
                  child: CarouselView(
                    itemExtent: MediaQuery.sizeOf(context).width - 32,
                    itemSnapping: true,
                    elevation: 4,
                    padding: const EdgeInsets.all(8),
                    children: arena.images.map((image) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: double.infinity,
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: double.infinity,
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  color: Colors.grey,
                                  size: 40,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 8.0),

                // Rating & Reviews
                Row(
                  children: [
                    RatingBar.builder(
                      initialRating: arena.rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 24.0,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      '${arena.rating} (${arena.reviews.length} reviews)',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),

                // Location
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.red),
                    const SizedBox(width: 8.0),
                    Text(arena.location,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
          ),

          // 2. Arena Overview (Sub-Header)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Overview',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8.0),

                // Short Description
                Text(
                  arena.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16.0),

                // Sports Available
                Text(
                  'Sports Available:',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Wrap(
                  spacing: 8.0,
                  children: arena.sportsTypes
                      .map(
                        (sport) => Chip(label: Text(sport)),
                      )
                      .toList(),
                ),
                const SizedBox(height: 16.0),

                // Price Range
                Text(
                  'Price: \$${arena.price.toStringAsFixed(2)} per hour',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),

          // 3. Gallery Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Gallery',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8.0),

                // Image Carousel
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: height / 2),
                  child: CarouselView(
                    itemExtent: MediaQuery.sizeOf(context).width - 32,
                    itemSnapping: true,
                    elevation: 4,
                    padding: const EdgeInsets.all(8),
                    children: arena.images.map((image) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: double.infinity,
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: double.infinity,
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  color: Colors.grey,
                                  size: 40,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16.0),

                // Video Tour (Optional)
                // Implement this if you have a video tour
                // Video player widget here...
              ],
            ),
          ),

          // 4. Amenities & Features
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Amenities & Features',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8.0),

                // Icons with Text
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: arena.amenities.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const Icon(Icons.check_circle, color: Colors.green),
                        const SizedBox(height: 4.0),
                        Text(arena.amenities[index]),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),

          // 5. Field Booking Details
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Available Fields',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8.0),

                // Available Fields List
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: arena.availableFields.length,
                  itemBuilder: (context, index) {
                    var field = arena.availableFields[index];
                    return ListTile(
                      title: Text(field['name']),
                      subtitle: Text(
                        'Price: \$${field['price'].toStringAsFixed(2)} per hour',
                      ),
                      trailing: Text('Available: ${field['availability']}'),
                      onTap: () {
                        // Handle booking logic here
                      },
                    );
                  },
                ),
                const SizedBox(height: 16.0),

                // Booking Button
                ElevatedButton(
                  onPressed: () {
                    // Handle booking
                  },
                  child: const Text('Book Now'),
                ),
              ],
            ),
          ),

          // 6. Reviews Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Reviews',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8.0),

                // Review Highlights
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: arena.reviews.length,
                  itemBuilder: (context, index) {
                    var review = arena.reviews[index];
                    return ListTile(
                      title: Text(review),
                      subtitle: const Text('User: John Doe'),
                    );
                  },
                ),
                const SizedBox(height: 16.0),

                // See All Reviews Button
                TextButton(
                  onPressed: () {
                    // Navigate to full review page
                  },
                  child: const Text('See All Reviews'),
                ),
              ],
            ),
          ),

          // 7. Location & Directions
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Location & Directions',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8.0),

                // Map Widget (Use Google Maps API or something similar)
                Container(
                  height: 200.0,
                  color: Colors.grey[300], // Placeholder for the map
                  child: const Center(child: Text('Map Placeholder')),
                ),
                const SizedBox(height: 8.0),

                // Distance
                const Text('Distance: 5.5 km from your location'),
                const SizedBox(height: 16.0),

                // Open in Google Maps
                ElevatedButton(
                  onPressed: () {
                    // Open Google Maps with the location
                  },
                  child: const Text('Open in Google Maps'),
                ),
              ],
            ),
          ),

          // 8. Related Arenas (Carousel/Slider)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Related Arenas',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8.0),

                // Related Arenas Carousel
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: height / 2),
                  child: CarouselView(
                    itemExtent: MediaQuery.sizeOf(context).width - 32,
                    itemSnapping: true,
                    elevation: 4,
                    padding: const EdgeInsets.all(8),
                    children: const [
                      // Add related arenas as Carousel items here
                      Text('Related Arena 1'),
                      Text('Related Arena 2'),
                      Text('Related Arena 3'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 9. Quick Actions (Save, Share, Contact)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {
                    // Save to favorites
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    // Share functionality
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.message),
                  onPressed: () {
                    // Contact functionality
                  },
                ),
              ],
            ),
          ),

          // 10. Footer Section (Legal & Policies)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    // Navigate to Terms & Conditions
                  },
                  child: const Text('Terms & Conditions'),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to Privacy Policy
                  },
                  child: const Text('Privacy Policy'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
