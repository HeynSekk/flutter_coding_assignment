import 'package:equatable/equatable.dart';
import 'package:flutter_sample_app/main.dart';
import 'package:flutter_sample_app/util/connection_util.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit(this._userRepository) : super(const AddPostState());
  final UserRepository _userRepository;

  Future<void> addPost(Post post) async {
    final isConnected = await getIt<ConnectionUtil>().isConnected();
    if (!isConnected) {
      emit(state.copyWith(status: AddPostStatus.noInternet));
      return;
    }

    emit(state.copyWith(status: AddPostStatus.loading));

    try {
      await _userRepository.addPost(post);
      emit(
        state.copyWith(
          status: AddPostStatus.success,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: AddPostStatus.failure));
    }
  }
}
