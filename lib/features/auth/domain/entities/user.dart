// user.dart
import 'package:equatable/equatable.dart';

/// Core business entity representing a User.
class User extends Equatable {
  final String id;        // Unique identifier for the user
  final String name;      // User's full name
  final String email;     // User's email address
  final String? phone;    // Optional: User's phone number

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
  });

  @override
  List<Object?> get props => [id, name, email, phone];
}
