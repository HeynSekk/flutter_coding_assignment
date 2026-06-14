import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_sample_app/models/user.dart';
import 'package:flutter_sample_app/util/json_generator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_file_saver/simple_file_saver.dart';

class MockFileSaverWrapper extends Mock implements FileSaverWrapper {}

class FakeFileSaveInfo extends Fake implements FileSaveInfo {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeFileSaveInfo());
  });

  group('JsonGenerator', () {
    late MockFileSaverWrapper mockFileSaver;
    late JsonGenerator jsonGenerator;

    setUp(() {
      mockFileSaver = MockFileSaverWrapper();
      jsonGenerator = JsonGenerator(fileSaver: mockFileSaver);
    });

    test('generateJson calls saveFile with correctly encoded JSON', () async {
      // arrange
      final users = [
        const User(id: 1, username: 'user1', email: 'user1@example.com'),
        const User(id: 2, username: 'user2', email: 'user2@example.com'),
      ];

      final expectedJson = jsonEncode(users.map((e) => e.toJson()).toList());
      final expectedBytes = Uint8List.fromList(utf8.encode(expectedJson));

      when(
        () => mockFileSaver.saveFile(
          fileInfo: any(named: 'fileInfo'),
          saveAs: any(named: 'saveAs'),
        ),
      ).thenAnswer((_) async => 'path/to/file');

      // act
      await jsonGenerator.generateJson(users);

      // assert
      verify(
        () => mockFileSaver.saveFile(
          fileInfo: any(
            named: 'fileInfo',
            that: isA<FileBytesInfo>().having(
              (info) => info.bytes,
              'bytes',
              expectedBytes,
            ),
          ),
        ),
      ).called(1);
    });

    test('generateJson throws custom exception when saveFile fails', () async {
      // arrange
      final users = [const User(id: 1)];
      when(
        () => mockFileSaver.saveFile(
          fileInfo: any(named: 'fileInfo'),
          saveAs: any(named: 'saveAs'),
        ),
      ).thenThrow(Exception('Native error'));

      // act & assert
      expect(
        () async => jsonGenerator.generateJson(users),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Failed to generate and save JSON file'),
          ),
        ),
      );
    });
  });
}
