// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_sample_app/features/users_list/widgets/user_card.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  group('UserInfoCard', () {
    //Must show user data correctly
    testWidgets('Must show user data correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: UserInfoCard(
            user: User(id: 1, name: 'User 1', email: 'user1@example.com'),
          ),
        ),
      );
      expect(find.text('User 1'), findsOneWidget);
      expect(find.text('user1@example.com'), findsOneWidget);
    });
  });
}
