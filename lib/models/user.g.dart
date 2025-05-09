// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => $checkedCreate(
      'User',
      json,
      ($checkedConvert) {
        final val = User(
          id: $checkedConvert('id', (v) => (v as num?)?.toInt()),
          name: $checkedConvert('name', (v) => v as String?),
          username: $checkedConvert('username', (v) => v as String?),
          email: $checkedConvert('email', (v) => v as String?),
          address: $checkedConvert(
              'address',
              (v) => v == null
                  ? null
                  : Address.fromJson(v as Map<String, dynamic>)),
          phone: $checkedConvert('phone', (v) => v as String?),
          website: $checkedConvert('website', (v) => v as String?),
          company: $checkedConvert(
              'company',
              (v) => v == null
                  ? null
                  : Company.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'address': instance.address?.toJson(),
      'phone': instance.phone,
      'website': instance.website,
      'company': instance.company?.toJson(),
    };

Address _$AddressFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Address',
      json,
      ($checkedConvert) {
        final val = Address(
          street: $checkedConvert('street', (v) => v as String?),
          suite: $checkedConvert('suite', (v) => v as String?),
          city: $checkedConvert('city', (v) => v as String?),
          zipcode: $checkedConvert('zipcode', (v) => v as String?),
          geo: $checkedConvert(
              'geo',
              (v) =>
                  v == null ? null : Geo.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'street': instance.street,
      'suite': instance.suite,
      'city': instance.city,
      'zipcode': instance.zipcode,
      'geo': instance.geo?.toJson(),
    };

Geo _$GeoFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Geo',
      json,
      ($checkedConvert) {
        final val = Geo(
          lat: $checkedConvert('lat', (v) => v as String?),
          lng: $checkedConvert('lng', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$GeoToJson(Geo instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Company _$CompanyFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Company',
      json,
      ($checkedConvert) {
        final val = Company(
          name: $checkedConvert('name', (v) => v as String?),
          catchPhrase: $checkedConvert('catch_phrase', (v) => v as String?),
          bs: $checkedConvert('bs', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'catchPhrase': 'catch_phrase'},
    );

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'name': instance.name,
      'catch_phrase': instance.catchPhrase,
      'bs': instance.bs,
    };
