// lib/features/dashboard/data/models/booking_model.dart

import '../../domain/entities/booking.dart';

class BookingModel extends Booking {
  // Constructor
  BookingModel({
    required String id,
    required String arenaId,
    required String userId,
    required String fieldId,
    required DateTime date,
    required List<Map<String, String>> timeSlots,
    required double totalPrice,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: id,
          arenaId: arenaId,
          userId: userId,
          fieldId: fieldId,
          date: date,
          timeSlots: timeSlots,
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
      date: DateTime.parse(json['date'] as String),
      timeSlots: (json['time_slots'] as List<dynamic>)
          .map((slot) => {
                'start': slot['start'] as String,
                'end': slot['end'] as String,
              })
          .toList(),
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
      'date': date.toIso8601String(),
      'time_slots': timeSlots
          .map((slot) => {
                'start': slot['start'],
                'end': slot['end'],
              })
          .toList(),
      'total_price': totalPrice,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
