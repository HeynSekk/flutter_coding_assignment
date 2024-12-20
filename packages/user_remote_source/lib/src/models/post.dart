import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
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

  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  List<Object?> get props => [userId, id, title, body];
}
