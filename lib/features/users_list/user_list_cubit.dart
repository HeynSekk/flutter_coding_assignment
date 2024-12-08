import 'package:equatable/equatable.dart';
import 'package:flutter_sample_app/main.dart';
import 'package:flutter_sample_app/util/connection_util.dart';
import 'package:flutter_sample_app/util/json_generator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:user_repository/user_repository.dart';

part 'user_list_cubit.g.dart';
part 'user_list_state.dart';

class UserListCubit extends HydratedCubit<UserListState> {
  UserListCubit(this._userRepository, this._jsonGenerator)
      : super(const UserListState());
  final UserRepository _userRepository;
  final JsonGenerator _jsonGenerator;

  Future<void> init() async {
    final isConnected = await getIt<ConnectionUtil>().isConnected();
    if (isConnected) {
      fetchUsers();
      return;
    }
    //this mean we have data in local db
    if (state.status == UserListStatus.success) {
      return;
    }
    emit(
      state.copyWith(
        status: UserListStatus.noInternet,
      ),
    );
  }

  Future<void> fetchUsers() async {
    emit(state.copyWith(status: UserListStatus.loading));

    try {
      final users = await _userRepository.getUsers();
      emit(
        state.copyWith(
          status: UserListStatus.success,
          users: users,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: UserListStatus.failure));
    }
  }

  Future<void> generateJson() async {
    emit(state.copyWith(status: UserListStatus.loading));

    try {
      await _jsonGenerator.generateJson(state.users);
      emit(
        state.copyWith(
          status: UserListStatus.jsonGenerateSuccess,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: UserListStatus.jsonGenerateFailure));
    }
  }

  @override
  UserListState fromJson(Map<String, dynamic> json) =>
      UserListState.fromJson(json);

  @override
  Map<String, dynamic> toJson(UserListState state) => state.toJson();
}
