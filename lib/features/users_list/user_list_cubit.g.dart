// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserListState _$UserListStateFromJson(Map<String, dynamic> json) =>
    UserListState(
      status: $enumDecodeNullable(_$UserListStatusEnumMap, json['status']) ??
          UserListStatus.initial,
      users: (json['users'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserListStateToJson(UserListState instance) =>
    <String, dynamic>{
      'status': _$UserListStatusEnumMap[instance.status]!,
      'users': instance.users,
    };

const _$UserListStatusEnumMap = {
  UserListStatus.initial: 'initial',
  UserListStatus.loading: 'loading',
  UserListStatus.success: 'success',
  UserListStatus.jsonGenerateSuccess: 'jsonGenerateSuccess',
  UserListStatus.failure: 'failure',
  UserListStatus.jsonGenerateFailure: 'jsonGenerateFailure',
  UserListStatus.noInternet: 'noInternet',
};
