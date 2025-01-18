class Booking {
  final String id; // Unique ID for the booking
  final String arenaId; // The ID of the arena being booked
  final String userId; // The user who made the booking
  final String fieldId; // The specific field within the arena being booked
  final DateTime date; // The date of the booking
  final List<Map<String, String>> timeSlots; // List of time slots {"start": "HH:mm", "end": "HH:mm"}
  final double totalPrice; // Total price for the booking
  final String status; // Status of the booking (e.g., 'confirmed', 'pending', 'canceled')
  final DateTime createdAt; // Timestamp when the booking was created
  final DateTime updatedAt; // Timestamp when the booking was last updated

  // Constructor
  Booking({
    required this.id,
    required this.arenaId,
    required this.userId,
    required this.fieldId,
    required this.date,
    required this.timeSlots,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  // CopyWith Method
  Booking copyWith({
    String? id,
    String? arenaId,
    String? userId,
    String? fieldId,
    DateTime? date,
    List<Map<String, String>>? timeSlots,
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
      date: date ?? this.date,
      timeSlots: timeSlots ?? this.timeSlots,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Check if the booking is for a specific date
  bool isForDate(DateTime targetDate) {
    return date.year == targetDate.year &&
        date.month == targetDate.month &&
        date.day == targetDate.day;
  }
}
