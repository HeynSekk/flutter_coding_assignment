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
  const LoginState({this.status = LoginStatus.loading, this.message = ''});

  final LoginStatus status;
  final String message;

  LoginState copyWith({required LoginStatus status, String? message}) {
    return LoginState(status: status, message: message ?? this.message);
  }

  @override
  List<Object?> get props => [status, message];
}
