// lib/features/auth/data/models/user_model.dart

import '../../domain/entities/user.dart';

/// Model class for User to handle data between API and domain
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.photoUrl,
    super.phone,
    super.website,
    super.address,
  });

  /// Factory constructor to create a UserModel from a JSON response
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      photoUrl: json['photoUrl'] as String?, // Nullable
      phone: json['phone'] as String?, // Nullable
      website: json['website'] as String?, // Nullable
      address: json['address'] != null
          ? AddressModel.fromJson(json['address'])
          : null, // Nullable
    );
  }

  /// Convert UserModel to JSON (used for API requests)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'phone': phone,
      'website': website,
      'address': address != null ? (address as AddressModel).toJson() : null,
    };
  }

  /// Convert UserModel to a domain entity (User)
  User toEntity() {
    return User(
      id: id,
      name: name,
      email: email,
      photoUrl: photoUrl,
      phone: phone,
      website: website,
      address: (address as AddressModel?)?.toEntity(),
    );
  }
}

/// Address model class
class AddressModel extends Address {
  const AddressModel({
    required super.street,
    required super.suite,
    required super.city,
    required super.zipcode,
    required GeoModel super.geo,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      street: json['street'] ?? '', // Default empty string for nullable fields
      suite: json['suite'] ?? '', // Default empty string
      city: json['city'] ?? '', // Default empty string
      zipcode: json['zipcode'] ?? '', // Default empty string
      geo: GeoModel.fromJson(json['geo'] ?? {}), // Empty object as fallback
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'suite': suite,
      'city': city,
      'zipcode': zipcode,
      'geo': (geo as GeoModel).toJson(),
    };
  }

  /// Convert AddressModel to a domain entity (Address)
  Address toEntity() {
    return Address(
      street: street,
      suite: suite,
      city: city,
      zipcode: zipcode,
      geo: (geo as GeoModel).toEntity(),
    );
  }
}

/// Geo model class
class GeoModel extends Geo {
  const GeoModel({required super.lat, required super.lng});

  factory GeoModel.fromJson(Map<String, dynamic> json) {
    return GeoModel(
      lat: json['lat'] ?? '', // Default empty string for nullable fields
      lng: json['lng'] ?? '', // Default empty string
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  /// Convert GeoModel to a domain entity (Geo)
  Geo toEntity() {
    return Geo(
      lat: lat,
      lng: lng,
    );
  }
}
