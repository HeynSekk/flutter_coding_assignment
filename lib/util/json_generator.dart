import 'dart:convert';

import 'package:simple_file_saver/simple_file_saver.dart';

import '../models/user.dart';

//TODO add tests
class JsonGenerator {
  /// Generate a json ans save it.
  /// Returns an exception if something went wrong. We can handle different
  /// failure cases here. But for simplicity, we will just return
  /// the exception and handle it in the cubit.
  Future<void> generateJson(List<User> users) async {
    try {
      final List<Map<String, dynamic>> usersMap = users
          .map((e) => e.toJson())
          .toList();
      final String usersStr = jsonEncode(usersMap);
      await SimpleFileSaver.saveFile(
        fileInfo: FileSaveInfo.fromBytes(
          bytes: utf8.encode(usersStr),
          basename: 'file_save',
          extension: 'txt',
        ),
      );
    } on Exception {
      throw Exception(
        'Failed to generate and save JSON file. Please check if you have enough storage space.',
      );
    }
  }
}
