import '../../domain/entities/user.dart';

/// Model class for User to handle data between API and domain
class UserModel extends User {
  const UserModel({
    required int id,
    required String name,
    required String username,
    required String email,
    required String phone,
    required String website,
    AddressModel? address,
    CompanyModel? company,
  }) : super(
          id: id,
          name: name,
          username: username,
          email: email,
          phone: phone,
          website: website,
          address: address,
          company: company,
        );

  /// Factory constructor to create a UserModel from a JSON response
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      address: AddressModel.fromJson(json['address']),
      company: CompanyModel.fromJson(json['company']),
    );
  }

  /// Convert UserModel to JSON (used for API requests)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'website': website,
      'address': (address as AddressModel).toJson(),
      'company': (company as CompanyModel).toJson(),
    };
  }

  // Convert UserModel to a domain entity (User)
  User toEntity() {
    return User(
      id: id,
      name: name,
      username: username,
      email: email,
      phone: phone,
      website: website,
      address: address,
      company: company,
    );
  }
}

/// Address model class
class AddressModel extends Address {
  const AddressModel({
    required String street,
    required String suite,
    required String city,
    required String zipcode,
    required GeoModel geo,
  }) : super(
            street: street,
            suite: suite,
            city: city,
            zipcode: zipcode,
            geo: geo);

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      street: json['street'],
      suite: json['suite'],
      city: json['city'],
      zipcode: json['zipcode'],
      geo: GeoModel.fromJson(json['geo']),
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
}

/// Geo model class
class GeoModel extends Geo {
  const GeoModel({required String lat, required String lng})
      : super(lat: lat, lng: lng);

  factory GeoModel.fromJson(Map<String, dynamic> json) {
    return GeoModel(
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}

/// Company model class
class CompanyModel extends Company {
  const CompanyModel({
    required String name,
    required String catchPhrase,
    required String bs,
  }) : super(name: name, catchPhrase: catchPhrase, bs: bs);

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      name: json['name'],
      catchPhrase: json['catchPhrase'],
      bs: json['bs'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'catchPhrase': catchPhrase,
      'bs': bs,
    };
  }
}
