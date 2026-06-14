import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sample_app/features/login/auth.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._auth) : super(const LoginState(status: LoginStatus.loading));
  final Auth _auth;

  Future<void> init() async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      final alreadyLogin = await _auth.isAuthenticated();
      if (alreadyLogin) {
        emit(state.copyWith(status: LoginStatus.alreadyLogin));
        return;
      }
      emit(state.copyWith(status: LoginStatus.initial));
    } on Exception catch (e) {
      if (e is FirebaseAuthException) {
        // we can handle error codes and create more good-UX error messages
        // here. For now, we just pass the error message from Firebase.
        emit(
          state.copyWith(
            status: LoginStatus.failure,
            message: 'Authentication failed. Code: ${e.code}',
          ),
        );
      } else {
        emit(
          state.copyWith(status: LoginStatus.failure, message: e.toString()),
        );
      }
    }
  }

  Future<void> login({required String email, required String password}) async {
    // final isConnected = await getIt<ConnectionUtil>().isConnected();
    // if (!isConnected) {
    //   emit(state.copyWith(status: LoginStatus.noInternet));
    //   return;
    // }

    emit(state.copyWith(status: LoginStatus.loading));

    try {
      await _auth.login(email: email, password: password);
      emit(state.copyWith(status: LoginStatus.success));
    } on Exception catch (e) {
      if (e is FirebaseAuthException) {
        // we can handle error codes and create more good-UX error messages
        // here. For now, we just pass the error message from Firebase.
        emit(
          state.copyWith(
            status: LoginStatus.failure,
            message: 'Authentication failed. Code: ${e.code}',
          ),
        );
      } else {
        emit(
          state.copyWith(status: LoginStatus.failure, message: e.toString()),
        );
      }
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await _auth.logout();
      emit(state.copyWith(status: LoginStatus.logoutSuccess));
    } on Exception catch (e) {
      if (e is FirebaseAuthException) {
        // we can handle error codes and create more good-UX error messages
        // here. For now, we just pass the error message from Firebase.
        emit(
          state.copyWith(
            status: LoginStatus.failure,
            message: 'Authentication failed. Code: ${e.code}',
          ),
        );
      } else {
        emit(
          state.copyWith(status: LoginStatus.failure, message: e.toString()),
        );
      }
    }
  }
}
