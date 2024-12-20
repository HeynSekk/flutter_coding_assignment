import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final Address? address;
  final String? phone;
  final String? website;
  final Company? company;

  const User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@JsonSerializable()
class Address {
  final String? street;
  final String? suite;
  final String? city;
  final String? zipcode;
  final Geo? geo;

  const Address({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

@JsonSerializable()
class Geo {
  final String? lat;
  final String? lng;

  const Geo({
    this.lat,
    this.lng,
  });

  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);
}

@JsonSerializable()
class Company {
  final String? name;
  final String? catchPhrase;
  final String? bs;

  const Company({
    this.name,
    this.catchPhrase,
    this.bs,
  });

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
}
