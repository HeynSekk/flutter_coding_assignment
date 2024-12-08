import 'package:equatable/equatable.dart';
import 'package:flutter_sample_app/features/login/auth.dart';
import 'package:flutter_sample_app/main.dart';
import 'package:flutter_sample_app/util/connection_util.dart';
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
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.authCheckFailure));
    }
  }

  Future<void> login({required String email, required String password}) async {
    final isConnected = await getIt<ConnectionUtil>().isConnected();
    if (!isConnected) {
      emit(state.copyWith(status: LoginStatus.noInternet));
      return;
    }

    emit(state.copyWith(status: LoginStatus.loading));

    try {
      await _auth.login(email: email, password: password);
      emit(
        state.copyWith(
          status: LoginStatus.success,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: LoginStatus.failure));
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await _auth.logout();
      emit(state.copyWith(
        status: LoginStatus.logoutSuccess,
      ));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.failure));
    }
  }
}
