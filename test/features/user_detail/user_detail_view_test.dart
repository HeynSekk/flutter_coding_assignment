// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_sample_app/features/user_detail/user_detail_view.dart';
import 'package:flutter_sample_app/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final user = User(id: 1, name: 'user 1', website: 'user1.com');
  group('UserInfoCard', () {
    //Must show user data correctly
    testWidgets('Must show user data correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: UserDetailPage(
            user: user,
          ),
        ),
      );
      expect(find.text('1'), findsOneWidget);
      expect(find.text('user 1'), findsOneWidget);
      expect(find.text('user1.com'), findsOneWidget);
    });
  });
}
