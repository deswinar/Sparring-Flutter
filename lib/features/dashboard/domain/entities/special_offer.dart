// lib/features/dashboard/domain/entities/special_offer.dart

class SpecialOffer {
  final String id; // Unique ID for the special offer
  final String arenaId; // The ID of the arena offering the promotion
  final String title; // The title or name of the special offer (e.g., "Summer Discount")
  final String description; // Description of the offer (e.g., "Get 20% off on weekdays")
  final double discountPercentage; // The percentage discount (0 to 100)
  final DateTime startDate; // The start date of the offer
  final DateTime endDate; // The end date of the offer
  final String status; // Status of the offer (e.g., 'active', 'expired', 'inactive')
  final DateTime createdAt; // Timestamp when the offer was created
  final DateTime updatedAt; // Timestamp when the offer was last updated

  // Constructor
  SpecialOffer({
    required this.id,
    required this.arenaId,
    required this.title,
    required this.description,
    required this.discountPercentage,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  // Method to copy the special offer with modified fields (immutability)
  SpecialOffer copyWith({
    String? id,
    String? arenaId,
    String? title,
    String? description,
    double? discountPercentage,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SpecialOffer(
      id: id ?? this.id,
      arenaId: arenaId ?? this.arenaId,
      title: title ?? this.title,
      description: description ?? this.description,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Method to check if the special offer is active (based on current date)
  bool get isActive {
    final now = DateTime.now();
    return startDate.isBefore(now) && endDate.isAfter(now) && status == 'active';
  }

  // Method to check if the special offer is expired
  bool get isExpired {
    return endDate.isBefore(DateTime.now()) && status == 'active';
  }

  // Method to get the duration of the special offer in days
  int get durationInDays {
    return endDate.difference(startDate).inDays;
  }
}
