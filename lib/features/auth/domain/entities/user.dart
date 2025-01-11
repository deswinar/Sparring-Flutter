// lib/features/auth/domain/entities/user.dart

import 'package:equatable/equatable.dart';

/// Core business entity representing a User.
class User extends Equatable {
  final String id; // Unique identifier for the user
  final String name; // User's full name
  final String email; // User's email address
  final String? photoUrl;
  final String? phone; // User's phone number
  final String? website; // User's website
  final Address? address; // User's address

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.phone,
    this.website,
    this.address,
  });

  @override
  List<Object?> get props =>
      [id, name, email, photoUrl, phone, website, address];
}

/// Represents a User's Address
class Address extends Equatable {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;

  const Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  @override
  List<Object?> get props => [street, suite, city, zipcode, geo];
}

/// Represents geographic coordinates
class Geo extends Equatable {
  final String lat;
  final String lng;

  const Geo({required this.lat, required this.lng});

  @override
  List<Object?> get props => [lat, lng];
}
