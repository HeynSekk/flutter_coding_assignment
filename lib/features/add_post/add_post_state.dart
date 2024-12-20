part of 'add_post_cubit.dart';

enum AddPostStatus { initial, loading, success, failure, noInternet }

final class AddPostState extends Equatable {
  const AddPostState({
    this.status = AddPostStatus.initial,
  });

  final AddPostStatus status;

  AddPostState copyWith({
    required AddPostStatus status,
  }) {
    return AddPostState(
      status: status,
    );
  }

  @override
  List<Object?> get props => [
        status,
      ];
}
