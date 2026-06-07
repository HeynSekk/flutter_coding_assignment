import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:user_remote_source/src/models/post.dart';
import 'package:user_remote_source/src/models/user.dart';
import 'package:user_remote_source/src/utils/exception_handler.dart';

/// Exception thrown when userSearch fails.
class UserRequestFailure implements Exception {}

/// Exception thrown when addPost fails.
class AddPostRequestFailure implements Exception {}

/// {@template remote_source_api_client}
/// Dart API Client which wraps the [JSON Placeholder API](https://dummyjson.com/).
/// {@endtemplate}
class RemoteSourceApiClient {
  /// {@macro open_meteo_api_client}
  RemoteSourceApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'dummyjson.com';

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

    final usersJson = jsonDecode(userResponse.body);

    return (usersJson["users"] as List<dynamic>)
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Add a new post [Post] `/post`. `id` field of `Post` is not required in
  /// the input.
  Future<void> addPost(Post post) async {
    try {
      final uri = Uri.https(
        _baseUrl,
        '/posts/add',
      );

      // final userResponse = await _httpClient.post(
      //   uri,
      //   body: jsonEncode(post),
      //   headers: {'Content-Type': 'application/json'},
      // );

      final userResponse = http.Response('', 401);

      if (userResponse.statusCode != 201) {
        throw ExceptionHandler.getExceptionFromResponse(userResponse);
      }
    } on Exception catch (e) {
      throw ExceptionHandler.refineException(e);
    }
  }
}
