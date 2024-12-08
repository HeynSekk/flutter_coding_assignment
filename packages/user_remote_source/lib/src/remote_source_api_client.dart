import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:user_remote_source/src/models/post.dart';
import 'package:user_remote_source/src/models/user.dart';

/// Exception thrown when userSearch fails.
class UserRequestFailure implements Exception {}

/// Exception thrown when addPost fails.
class AddPostRequestFailure implements Exception {}

/// {@template remote_source_api_client}
/// Dart API Client which wraps the [JSON Placeholder API](https://jsonplaceholder.typicode.com).
/// {@endtemplate}
class RemoteSourceApiClient {
  /// {@macro open_meteo_api_client}
  RemoteSourceApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'jsonplaceholder.typicode.com';

  final http.Client _httpClient;

  /// Fetch users [User] `/users`.
  Future<List<User>> fetchUsers() async {
    final userRequest = Uri.https(
      _baseUrl,
      '/users',
    );

    final userResponse = await _httpClient.get(userRequest);

    if (userResponse.statusCode != 200) {
      throw UserRequestFailure();
    }

    final usersJson = jsonDecode(userResponse.body) as List<dynamic>;

    return usersJson
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Add a new post [Post] `/post`. `id` field of `Post` is not required in
  /// the input.
  Future<void> addPost(Post post) async {
    final uri = Uri.https(
      _baseUrl,
      '/posts',
    );

    final userResponse = await _httpClient.post(
      uri,
      body: jsonEncode(post),
    );

    if (userResponse.statusCode != 201) {
      throw AddPostRequestFailure();
    }
  }
}
