import 'dart:convert';
import 'package:simple_file_saver/simple_file_saver.dart';
import 'package:user_repository/user_repository.dart';
import 'dart:typed_data';

class FileSaverWrapper {
  Future<String?> saveFile({
    required FileSaveInfo fileInfo,
    bool saveAs = false,
  }) {
    return SimpleFileSaver.saveFile(fileInfo: fileInfo, saveAs: saveAs);
  }
}

class JsonGenerator {
  final FileSaverWrapper _fileSaver;

  JsonGenerator({FileSaverWrapper? fileSaver})
    : _fileSaver = fileSaver ?? FileSaverWrapper();

  /// Generate a json ans save it.
  /// Returns an exception if something went wrong. We can handle different
  /// failure cases here. But for simplicity, we will just return
  /// the exception and handle it in the cubit.
  Future<void> generateJson(List<UserEntity> users) async {
    try {
      final List<Map<String, dynamic>> usersMap = users
          .map((e) => e.toJson())
          .toList();
      final String usersStr = jsonEncode(usersMap);
      await _fileSaver.saveFile(
        fileInfo: FileSaveInfo.fromBytes(
          bytes: Uint8List.fromList(utf8.encode(usersStr)),
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
