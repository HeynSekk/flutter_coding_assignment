// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_sample_app/features/users_list/widgets/user_card.dart';
import 'package:flutter_sample_app/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserInfoCard', () {
    //Must show user data correctly
    testWidgets('Must show user data correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: UserInfoCard(
            user: User(
              id: 1,
              name: 'User 1',
              username: 'user1_nick',
              email: 'user1@example.com',
            ),
          ),
        ),
      );
      expect(find.text('user1_nick'), findsOneWidget);
      expect(find.text('user1@example.com'), findsOneWidget);
    });

    testWidgets('Must show fallback text when data is missing', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: UserInfoCard(
            user: User(id: 1),
          ),
        ),
      );
      expect(find.text('<No name>'), findsOneWidget);
      expect(find.text('<No email>'), findsOneWidget);
    });
  });
}
