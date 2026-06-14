import 'package:equatable/equatable.dart';
import 'package:user_remote_source/user_remote_source.dart';

class Post extends Equatable {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  const Post({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  PostModel toModel() => PostModel(
        userId: userId,
        id: id,
        title: title,
        body: body,
      );

  @override
  List<Object?> get props => [userId, id, title, body];
}
