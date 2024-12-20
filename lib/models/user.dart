import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:user_repository/user_repository.dart' as repo;

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
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

  factory User.fromRepo(repo.User user) {
    return User(
      id: user.id,
      name: user.name,
      username: user.username,
      email: user.email,
      address: Address(
        street: user.address?.street,
        suite: user.address?.suite,
        city: user.address?.city,
        zipcode: user.address?.zipcode,
        geo: Geo(
          lat: user.address?.geo?.lat,
          lng: user.address?.geo?.lng,
        ),
      ),
      phone: user.phone,
      website: user.website,
      company: Company(
        name: user.company?.name,
        catchPhrase: user.company?.catchPhrase,
        bs: user.company?.bs,
      ),
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object> get props => [
        id ?? '',
        name ?? '',
        username ?? '',
        email ?? '',
        address ?? '',
        phone ?? '',
        website ?? '',
        company ?? ''
      ];
}

@JsonSerializable()
class Address extends Equatable {
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

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  List<Object> get props => [
        street ?? '',
        suite ?? '',
        city ?? '',
        zipcode ?? '',
        geo ?? '',
      ];
}

@JsonSerializable()
class Geo extends Equatable {
  final String? lat;
  final String? lng;

  const Geo({
    this.lat,
    this.lng,
  });

  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);

  Map<String, dynamic> toJson() => _$GeoToJson(this);

  @override
  List<Object> get props => [lat ?? '', lng ?? ''];
}

@JsonSerializable()
class Company extends Equatable {
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

  Map<String, dynamic> toJson() => _$CompanyToJson(this);

  @override
  List<Object> get props => [name ?? '', catchPhrase ?? '', bs ?? ''];
}
