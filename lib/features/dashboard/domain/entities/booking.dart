// lib/features/dashboard/domain/entities/booking.dart

class Booking {
  final String id; // Unique ID for the booking
  final String arenaId; // The ID of the arena being booked
  final String userId; // The user who made the booking
  final String fieldId; // The specific field within the arena being booked
  final DateTime startTime; // The start time of the booking
  final DateTime endTime; // The end time of the booking
  final double totalPrice; // Total price for the booking (can vary based on the time, field, etc.)
  final String status; // Status of the booking (e.g., 'confirmed', 'pending', 'canceled')
  final DateTime createdAt; // Timestamp when the booking was created
  final DateTime updatedAt; // Timestamp when the booking was last updated

  // Constructor
  Booking({
    required this.id,
    required this.arenaId,
    required this.userId,
    required this.fieldId,
    required this.startTime,
    required this.endTime,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  // Method to copy the booking with modified fields (immutability)
  Booking copyWith({
    String? id,
    String? arenaId,
    String? userId,
    String? fieldId,
    DateTime? startTime,
    DateTime? endTime,
    double? totalPrice,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Booking(
      id: id ?? this.id,
      arenaId: arenaId ?? this.arenaId,
      userId: userId ?? this.userId,
      fieldId: fieldId ?? this.fieldId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Method to calculate the booking duration in hours
  double get bookingDurationInHours {
    return endTime.difference(startTime).inMinutes / 60.0;
  }

  // Method to determine if the booking is in the future
  bool get isFutureBooking {
    return startTime.isAfter(DateTime.now());
  }
}
