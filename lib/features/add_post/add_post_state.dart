part of 'add_post_cubit.dart';

enum AddPostStatus { initial, loading, success, failure, noInternet }

final class AddPostState extends Equatable {
  const AddPostState({
    this.status = AddPostStatus.initial,
  });

  final AddPostStatus status;

  AddPostState copyWith({
    AddPostStatus? status,
    List<User>? users,
  }) {
    return AddPostState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        status,
      ];
}
