// lib/features/dashboard/data/models/booking_model.dart

import '../../domain/entities/booking.dart';

class BookingModel extends Booking {
  // Constructor
  BookingModel({
    required String id,
    required String arenaId,
    required String userId,
    required String fieldId,
    required DateTime startTime,
    required DateTime endTime,
    required double totalPrice,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: id,
          arenaId: arenaId,
          userId: userId,
          fieldId: fieldId,
          startTime: startTime,
          endTime: endTime,
          totalPrice: totalPrice,
          status: status,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  // Factory constructor to create an instance of BookingModel from JSON
  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String,
      arenaId: json['arena_id'] as String,
      userId: json['user_id'] as String,
      fieldId: json['field_id'] as String,
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: DateTime.parse(json['end_time'] as String),
      totalPrice: (json['total_price'] as num).toDouble(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  // Method to convert BookingModel to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'arena_id': arenaId,
      'user_id': userId,
      'field_id': fieldId,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'total_price': totalPrice,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
