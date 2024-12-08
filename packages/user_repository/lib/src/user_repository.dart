import 'dart:async';

import 'package:user_remote_source/user_remote_source.dart';

class UserRepository {
  UserRepository({RemoteSourceApiClient? remoteSourceApiClient})
      : _remoteSourceApiClient =
            remoteSourceApiClient ?? RemoteSourceApiClient();

  final RemoteSourceApiClient _remoteSourceApiClient;

  Future<List<User>> getUsers() async {
    return await _remoteSourceApiClient.fetchUsers();
  }

  Future<void> addPost(Post post) async {
    await _remoteSourceApiClient.addPost(post);
  }
}
