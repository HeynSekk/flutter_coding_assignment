// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_sample_app/features/users_list/user_list_cubit.dart';
import 'package:flutter_sample_app/features/users_list/users_list_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('JsonGenerationStatus', () {
    //Must show message correctly
    testWidgets('Show failure message correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: JsonGenerationStatus(
            userListState: UserListState(
              status: UserListStatus.jsonGenerateFailure,
            ),
          ),
        ),
      );
      expect(find.text('Failed to generate JSON file'), findsOneWidget);
    });
    testWidgets('Show success message correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: JsonGenerationStatus(
            userListState: UserListState(
              status: UserListStatus.jsonGenerateSuccess,
            ),
          ),
        ),
      );
      expect(find.text('Json Generation Succeeded!'), findsOneWidget);
    });
    testWidgets(
        'Show nothing when status is neither generation success nor failure',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: JsonGenerationStatus(
            userListState: UserListState(
              status: UserListStatus.initial,
            ),
          ),
        ),
      );
      expect(find.byType(Container), findsOneWidget);
    });
  });
}
