// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => $checkedCreate(
      'UserEntity',
      json,
      ($checkedConvert) {
        final val = UserEntity(
          id: $checkedConvert('id', (v) => (v as num?)?.toInt()),
          name: $checkedConvert('name', (v) => v as String?),
          username: $checkedConvert('username', (v) => v as String?),
          email: $checkedConvert('email', (v) => v as String?),
          address: $checkedConvert(
              'address',
              (v) => v == null
                  ? null
                  : AddressEntity.fromJson(v as Map<String, dynamic>)),
          phone: $checkedConvert('phone', (v) => v as String?),
          website: $checkedConvert('website', (v) => v as String?),
          company: $checkedConvert(
              'company',
              (v) => v == null
                  ? null
                  : CompanyEntity.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'address': instance.address?.toJson(),
      'phone': instance.phone,
      'website': instance.website,
      'company': instance.company?.toJson(),
    };

AddressEntity _$AddressEntityFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'AddressEntity',
      json,
      ($checkedConvert) {
        final val = AddressEntity(
          street: $checkedConvert('street', (v) => v as String?),
          suite: $checkedConvert('suite', (v) => v as String?),
          city: $checkedConvert('city', (v) => v as String?),
          zipcode: $checkedConvert('zipcode', (v) => v as String?),
          geo: $checkedConvert(
              'geo',
              (v) => v == null
                  ? null
                  : GeoEntity.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$AddressEntityToJson(AddressEntity instance) =>
    <String, dynamic>{
      'street': instance.street,
      'suite': instance.suite,
      'city': instance.city,
      'zipcode': instance.zipcode,
      'geo': instance.geo?.toJson(),
    };

GeoEntity _$GeoEntityFromJson(Map<String, dynamic> json) => $checkedCreate(
      'GeoEntity',
      json,
      ($checkedConvert) {
        final val = GeoEntity(
          lat: $checkedConvert('lat', (v) => v as String?),
          lng: $checkedConvert('lng', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$GeoEntityToJson(GeoEntity instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

CompanyEntity _$CompanyEntityFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CompanyEntity',
      json,
      ($checkedConvert) {
        final val = CompanyEntity(
          name: $checkedConvert('name', (v) => v as String?),
          catchPhrase: $checkedConvert('catch_phrase', (v) => v as String?),
          bs: $checkedConvert('bs', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'catchPhrase': 'catch_phrase'},
    );

Map<String, dynamic> _$CompanyEntityToJson(CompanyEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'catch_phrase': instance.catchPhrase,
      'bs': instance.bs,
    };
