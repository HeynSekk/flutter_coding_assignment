part of 'login_cubit.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  failure,
  noInternet,
  alreadyLogin,
  authCheckFailure,
  logoutSuccess,
}

final class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.loading,
  });

  final LoginStatus status;

  LoginState copyWith({
    required LoginStatus status,
  }) {
    return LoginState(
      status: status,
    );
  }

  @override
  List<Object?> get props => [
        status,
      ];
}
