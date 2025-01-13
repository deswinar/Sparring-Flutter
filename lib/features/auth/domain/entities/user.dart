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

  /// Creates a copy of the User object with the given fields updated.
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? phone,
    String? website,
    Address? address,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      address: address ?? this.address,
    );
  }

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

  /// Creates a copy of the Address object with the given fields updated.
  Address copyWith({
    String? street,
    String? suite,
    String? city,
    String? zipcode,
    Geo? geo,
  }) {
    return Address(
      street: street ?? this.street,
      suite: suite ?? this.suite,
      city: city ?? this.city,
      zipcode: zipcode ?? this.zipcode,
      geo: geo ?? this.geo,
    );
  }

  @override
  List<Object?> get props => [street, suite, city, zipcode, geo];
}

/// Represents geographic coordinates
class Geo extends Equatable {
  final String lat;
  final String lng;

  const Geo({required this.lat, required this.lng});

  /// Creates a copy of the Geo object with the given fields updated.
  Geo copyWith({
    String? lat,
    String? lng,
  }) {
    return Geo(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  @override
  List<Object?> get props => [lat, lng];
}
