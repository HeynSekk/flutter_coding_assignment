part of 'add_post_cubit.dart';

enum AddPostStatus { initial, loading, success, failure, unauthorized }

final class AddPostState extends Equatable {
  const AddPostState({
    this.status = AddPostStatus.initial,
    this.message = '',
  });

  final AddPostStatus status;
  final String message;

  AddPostState copyWith({
    required AddPostStatus status,
    String? message,
  }) {
    return AddPostState(
      status: status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
      ];
}
