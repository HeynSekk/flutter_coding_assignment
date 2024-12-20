import 'dart:convert';
import 'dart:io';

import 'package:cr_file_saver/file_saver.dart';
import 'package:path_provider/path_provider.dart';

import '../models/user.dart';

//TODO add tests
class JsonGenerator {
  Future<void> generateJson(List<User> users) async {
    final List<Map<String, dynamic>> usersMap =
        users.map((e) => e.toJson()).toList();
    final String usersStr = jsonEncode(usersMap);
    // Get the application documents directory
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    // Create the '/files' folder if it doesn't exist
    Directory filesDir = Directory('$appDocPath/files');
    if (!await filesDir.exists()) {
      await filesDir.create(recursive: true);
    }

    // Create the file path
    String filePath = '${filesDir.path}/user.json';
    File file = File(filePath);
    await file.writeAsString(usersStr);
    await CRFileSaver.requestWriteExternalStoragePermission();
    await CRFileSaver.saveFile(filePath, destinationFileName: 'user.json');
  }
}
