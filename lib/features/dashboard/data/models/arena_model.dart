// lib/features/dashboard/data/models/arena_model.dart

import '../../domain/entities/arena.dart';

class ArenaModel extends Arena {
  // Constructor
  ArenaModel({
    required String id,
    required String name,
    required String location,
    required List<String> sportsTypes,
    required double rating,
    required String description,
    required List<String> images,
    required double price,
    required bool isFeatured,
    required List<String> amenities,
    required List<Map<String, dynamic>> availableFields,
    required List<String> reviews,
  }) : super(
          id: id,
          name: name,
          location: location,
          sportsTypes: sportsTypes,
          rating: rating,
          description: description,
          images: images,
          price: price,
          isFeatured: isFeatured,
          amenities: amenities,
          availableFields: availableFields,
          reviews: reviews,
        );

  // Factory constructor for creating an instance of ArenaModel from JSON
  factory ArenaModel.fromJson(Map<String, dynamic> json) {
    return ArenaModel(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      sportsTypes: List<String>.from(json['sports_types'] as List),
      rating: (json['rating'] as num).toDouble(),
      description: json['description'] as String,
      images: List<String>.from(json['images'] as List),
      price: (json['price'] as num).toDouble(),
      isFeatured: json['is_featured'] as bool,
      amenities: List<String>.from(json['amenities'] as List),
      availableFields: List<Map<String, dynamic>>.from(
        (json['available_fields'] as List).map(
          (field) => field as Map<String, dynamic>,
        ),
      ),
      reviews: List<String>.from(json['reviews'] as List),
    );
  }

  // Method to convert ArenaModel to JSON format (for API requests)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'sports_types': sportsTypes,
      'rating': rating,
      'description': description,
      'images': images,
      'price': price,
      'is_featured': isFeatured,
      'amenities': amenities,
      'available_fields': availableFields,
      'reviews': reviews,
    };
  }
}
