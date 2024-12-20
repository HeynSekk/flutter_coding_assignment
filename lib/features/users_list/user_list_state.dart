part of 'user_list_cubit.dart';

enum UserListStatus {
  initial,
  loading,
  success,
  jsonGenerateSuccess,
  failure,
  jsonGenerateFailure,
  noInternet
}

@JsonSerializable()
final class UserListState extends Equatable {
  const UserListState({
    this.status = UserListStatus.initial,
    this.users = const [],
  });

  final UserListStatus status;
  final List<User> users;

  UserListState copyWith({
    required UserListStatus status,
    List<User>? users,
  }) {
    return UserListState(
      status: status,
      users: users ?? this.users,
    );
  }

  factory UserListState.fromJson(Map<String, dynamic> json) =>
      _$UserListStateFromJson(json);

  Map<String, dynamic> toJson() => _$UserListStateToJson(this);

  @override
  List<Object?> get props => [
        status,
        users,
      ];
}
