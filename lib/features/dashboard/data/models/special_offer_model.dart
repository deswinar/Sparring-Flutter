// lib/features/dashboard/data/models/special_offer_model.dart

import '../../domain/entities/special_offer.dart';

class SpecialOfferModel extends SpecialOffer {
  // Constructor
  SpecialOfferModel({
    required String id,
    required String arenaId,
    required String title,
    required String description,
    required double discountPercentage,
    required DateTime startDate,
    required DateTime endDate,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: id,
          arenaId: arenaId,
          title: title,
          description: description,
          discountPercentage: discountPercentage,
          startDate: startDate,
          endDate: endDate,
          status: status,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  // Factory constructor to create an instance of SpecialOfferModel from JSON
  factory SpecialOfferModel.fromJson(Map<String, dynamic> json) {
    return SpecialOfferModel(
      id: json['id'] as String,
      arenaId: json['arena_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      discountPercentage: (json['discount_percentage'] as num).toDouble(),
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  // Method to convert SpecialOfferModel to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'arena_id': arenaId,
      'title': title,
      'description': description,
      'discount_percentage': discountPercentage,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
