// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserListState _$UserListStateFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'UserListState',
      json,
      ($checkedConvert) {
        final val = UserListState(
          status: $checkedConvert(
              'status',
              (v) =>
                  $enumDecodeNullable(_$UserListStatusEnumMap, v) ??
                  UserListStatus.initial),
          users: $checkedConvert(
              'users',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => User.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const []),
        );
        return val;
      },
    );

Map<String, dynamic> _$UserListStateToJson(UserListState instance) =>
    <String, dynamic>{
      'status': _$UserListStatusEnumMap[instance.status]!,
      'users': instance.users.map((e) => e.toJson()).toList(),
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
