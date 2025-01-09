import 'package:equatable/equatable.dart';

/// Core business entity representing a User.
class User extends Equatable {
  final int id; // Unique identifier for the user
  final String name; // User's full name
  final String username;
  final String email; // User's email address
  final String phone; // User's phone number
  final String website; // User's website
  final Address? address; // User's address
  final Company? company; // User's company details

  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    this.address,
    this.company,
  });

  @override
  List<Object?> get props =>
      [id, name, username, email, phone, website, address, company];
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

/// Represents a User's Company
class Company extends Equatable {
  final String name;
  final String catchPhrase;
  final String bs;

  const Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  @override
  List<Object?> get props => [name, catchPhrase, bs];
}
