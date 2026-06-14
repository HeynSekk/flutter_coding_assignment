part of 'user_list_cubit.dart';

enum UserListStatus {
  initial,
  loading,
  success,
  jsonGenerateSuccess,
  failure,
  jsonGenerateFailure,
  unauthorized,
}

@JsonSerializable()
final class UserListState extends Equatable {
  const UserListState({
    this.status = UserListStatus.initial,
    this.users = const [],
    this.message,
  });

  final UserListStatus status;
  final List<UserEntity> users;
  final String? message;

  UserListState copyWith({
    required UserListStatus status,
    List<UserEntity>? users,
    String? message,
  }) {
    return UserListState(
      status: status,
      users: users ?? this.users,
      message: message ?? this.message,
    );
  }

  factory UserListState.fromJson(Map<String, dynamic> json) =>
      _$UserListStateFromJson(json);

  Map<String, dynamic> toJson() => _$UserListStateToJson(this);

  @override
  List<Object?> get props => [
        status,
        users,
        message,
      ];
}
