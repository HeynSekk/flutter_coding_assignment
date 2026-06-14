import 'dart:async';

import 'package:user_remote_source/user_remote_source.dart' as remote;
import 'package:user_repository/src/models/post.dart' as current;
import 'package:user_repository/src/models/user.dart' as current;

class UserRepository {
  UserRepository({remote.RemoteSourceApiClient? remoteSourceApiClient})
      : _remoteSourceApiClient =
            remoteSourceApiClient ?? remote.RemoteSourceApiClient();

  final remote.RemoteSourceApiClient _remoteSourceApiClient;

  Future<List<current.User>> getUsers() async {
    List<remote.User> users = await _remoteSourceApiClient.fetchUsers();
    return users
        .map((e) => current.User(
              id: e.id,
              name: e.name,
              username: e.username,
              email: e.email,
              address: current.Address(
                street: e.address?.street,
                suite: e.address?.suite,
                city: e.address?.city,
                zipcode: e.address?.zipcode,
                geo: current.Geo(
                  lat: e.address?.geo?.lat,
                  lng: e.address?.geo?.lng,
                ),
              ),
              phone: e.phone,
              website: e.website,
              company: current.Company(
                name: e.company?.name,
                catchPhrase: e.company?.catchPhrase,
                bs: e.company?.bs,
              ),
            ))
        .toList();
  }

  Future<void> addPost(current.Post post) async {
    await _remoteSourceApiClient.addPost(remote.Post(
      userId: post.userId,
      id: post.id,
      title: post.title,
      body: post.body,
    ));
  }
}
