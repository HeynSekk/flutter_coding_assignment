import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserResponse {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final AddressResponse? address;
  final String? phone;
  final String? website;
  final CompanyResponse? company;

  const UserResponse({
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable()
class AddressResponse {
  final String? street;
  final String? suite;
  final String? city;
  final String? zipcode;
  final GeoResponse? geo;

  const AddressResponse({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      _$AddressResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AddressResponseToJson(this);
}

@JsonSerializable()
class GeoResponse {
  final String? lat;
  final String? lng;

  const GeoResponse({
    this.lat,
    this.lng,
  });

  factory GeoResponse.fromJson(Map<String, dynamic> json) => _$GeoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GeoResponseToJson(this);
}

@JsonSerializable()
class CompanyResponse {
  final String? name;
  final String? catchPhrase;
  final String? bs;

  const CompanyResponse({
    this.name,
    this.catchPhrase,
    this.bs,
  });

  factory CompanyResponse.fromJson(Map<String, dynamic> json) =>
      _$CompanyResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyResponseToJson(this);
}
