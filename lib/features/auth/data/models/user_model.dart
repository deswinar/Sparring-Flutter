import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

/// Model class for User to handle data between API and domain
class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;

  // Constructor
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  // Convert the UserModel to a User domain entity
  User toDomain() {
    return User(
      id: id,
      name: name,
      email: email,
    );
  }

  // Factory constructor to create a UserModel from a JSON response
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  // Method to convert UserModel to JSON (used for API requests)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  @override
  List<Object> get props => [id, name, email];

  // Convert UserModel to User entity
  User toEntity() {
    return User(id: id, name: name, email: email);
  }
}
