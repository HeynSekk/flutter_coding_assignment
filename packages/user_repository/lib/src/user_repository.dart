import 'dart:async';

import 'package:user_remote_source/user_remote_source.dart';
import 'package:user_repository/src/models/post.dart';
import 'package:user_repository/src/models/user.dart';

class UserRepository {
  UserRepository({RemoteSourceApiClient? remoteSourceApiClient})
      : _remoteSourceApiClient =
            remoteSourceApiClient ?? RemoteSourceApiClient();

  final RemoteSourceApiClient _remoteSourceApiClient;

  Future<List<UserEntity>> getUsers() async {
    List<UserResponse> users = await _remoteSourceApiClient.fetchUsers();
    return users.map((e) => e.toEntity()).toList();
  }

  Future<void> addPost(Post post) async {
    await _remoteSourceApiClient.addPost(post.toModel());
  }
}
