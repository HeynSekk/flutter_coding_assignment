import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:user_remote_source/user_remote_source.dart';

part 'user.g.dart';

@JsonSerializable()
class UserEntity extends Equatable {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final AddressEntity? address;
  final String? phone;
  final String? website;
  final CompanyEntity? company;

  const UserEntity({
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        username,
        email,
        address,
        phone,
        website,
        company,
      ];
}

@JsonSerializable()
class AddressEntity extends Equatable {
  final String? street;
  final String? suite;
  final String? city;
  final String? zipcode;
  final GeoEntity? geo;

  const AddressEntity({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });

  factory AddressEntity.fromJson(Map<String, dynamic> json) =>
      _$AddressEntityFromJson(json);
  Map<String, dynamic> toJson() => _$AddressEntityToJson(this);

  @override
  List<Object?> get props => [street, suite, city, zipcode, geo];
}

@JsonSerializable()
class GeoEntity extends Equatable {
  final String? lat;
  final String? lng;

  const GeoEntity({
    this.lat,
    this.lng,
  });

  factory GeoEntity.fromJson(Map<String, dynamic> json) => _$GeoEntityFromJson(json);
  Map<String, dynamic> toJson() => _$GeoEntityToJson(this);

  @override
  List<Object?> get props => [lat, lng];
}

@JsonSerializable()
class CompanyEntity extends Equatable {
  final String? name;
  final String? catchPhrase;
  final String? bs;

  const CompanyEntity({
    this.name,
    this.catchPhrase,
    this.bs,
  });

  factory CompanyEntity.fromJson(Map<String, dynamic> json) =>
      _$CompanyEntityFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyEntityToJson(this);

  @override
  List<Object?> get props => [name, catchPhrase, bs];
}

extension UserResponseX on UserResponse {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      username: username,
      email: email,
      address: address?.toEntity(),
      phone: phone,
      website: website,
      company: company?.toEntity(),
    );
  }
}

extension AddressResponseX on AddressResponse {
  AddressEntity toEntity() {
    return AddressEntity(
      street: street,
      suite: suite,
      city: city,
      zipcode: zipcode,
      geo: geo?.toEntity(),
    );
  }
}

extension GeoResponseX on GeoResponse {
  GeoEntity toEntity() {
    return GeoEntity(
      lat: lat,
      lng: lng,
    );
  }
}

extension CompanyResponseX on CompanyResponse {
  CompanyEntity toEntity() {
    return CompanyEntity(
      name: name,
      catchPhrase: catchPhrase,
      bs: bs,
    );
  }
}
