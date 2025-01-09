// lib/features/dashboard/domain/entities/arena.dart

class Arena {
  final String id;
  final String name;
  final String location;
  final List<String> sportsTypes; // e.g. ["Football", "Tennis"]
  final double rating; // Average rating, could be from 1 to 5
  final String description;
  final List<String> images; // List of image URLs
  final double price; // Price for booking (hourly or flat rate)
  final bool isFeatured; // Whether the arena is featured for promotions
  final List<String> amenities; // List of amenities e.g. ["Parking", "WiFi", "Locker Rooms"]
  final List<Map<String, dynamic>> availableFields; // List of fields available for booking (name, price, availability)
  final List<String> reviews; // List of reviews or review IDs, can be extended to review objects

  // Constructor (Immutability is key)
  Arena({
    required this.id,
    required this.name,
    required this.location,
    required this.sportsTypes,
    required this.rating,
    required this.description,
    required this.images,
    required this.price,
    required this.isFeatured,
    required this.amenities,
    required this.availableFields,
    required this.reviews,
  });

  // We can also define a copyWith method for immutability
  Arena copyWith({
    String? id,
    String? name,
    String? location,
    List<String>? sportsTypes,
    double? rating,
    String? description,
    List<String>? images,
    double? price,
    bool? isFeatured,
    List<String>? amenities,
    List<Map<String, dynamic>>? availableFields,
    List<String>? reviews,
  }) {
    return Arena(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      sportsTypes: sportsTypes ?? this.sportsTypes,
      rating: rating ?? this.rating,
      description: description ?? this.description,
      images: images ?? this.images,
      price: price ?? this.price,
      isFeatured: isFeatured ?? this.isFeatured,
      amenities: amenities ?? this.amenities,
      availableFields: availableFields ?? this.availableFields,
      reviews: reviews ?? this.reviews,
    );
  }
}
