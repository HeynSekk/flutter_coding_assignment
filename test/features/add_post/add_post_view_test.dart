// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app/features/add_post/add_post_cubit.dart';
import 'package:flutter_sample_app/features/add_post/add_post_view.dart';
import 'package:flutter_sample_app/features/users_list/user_list_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_repository/user_repository.dart';

import '../../helper/mock_go_router.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockAddPostCubit extends MockCubit<AddPostState>
    implements AddPostCubit {}

class MockUserListCubit extends MockCubit<UserListState>
    implements UserListCubit {}

class FakePost extends Fake implements Post {}

void main() {
  group('AddPostView', () {
    late AddPostCubit addPostCubit;

    setUpAll(() {
      registerFallbackValue(FakePost());
    });

    setUp(() {
      addPostCubit = MockAddPostCubit();
    });

    //When tap Upload button, must call addPost function of the cubit.
    //this test cases is failing
    testWidgets(
        'When tap Upload button, must call addPost function of the cubit with correct input',
        (tester) async {
      final Post post = Post(userId: 1, title: 't', body: 'b');
      when(() => addPostCubit.state)
          .thenReturn(AddPostState(status: AddPostStatus.initial));
      when(
        () => addPostCubit.addPost(
          any(),
        ),
      ).thenAnswer((_) async {});
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: AddPostView(addPostCubit: addPostCubit),
            ),
          ),
        ),
      );
      await tester.enterText(find.byKey(ValueKey('userId')), '1');
      await tester.enterText(find.byKey(ValueKey('title')), 't');
      await tester.enterText(find.byKey(ValueKey('body')), 'b');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      verify(
        () => addPostCubit.addPost(
          post,
          // Post(userId: 1, title: 't', body: 'b'),
        ),
      ).called(1);
    });

    //Initially, must show 3 text fields and Upload button.
    testWidgets('Initially, must show 3 text fields and Upload button.',
        (tester) async {
      when(() => addPostCubit.state)
          .thenReturn(AddPostState(status: AddPostStatus.initial));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: AddPostView(
                addPostCubit: addPostCubit,
              ),
            ),
          ),
        ),
      );
      expect(find.byKey(Key('userId')), findsOneWidget);
      expect(find.byKey(Key('title')), findsOneWidget);
      expect(find.byKey(Key('body')), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
    //Must show loading while loading.
    testWidgets('Must show loading while loading.', (tester) async {
      when(() => addPostCubit.state)
          .thenReturn(AddPostState(status: AddPostStatus.loading));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: AddPostView(
                addPostCubit: addPostCubit,
              ),
            ),
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
    //Must show success when success.
    testWidgets('Must show success when success.', (tester) async {
      when(() => addPostCubit.state)
          .thenReturn(AddPostState(status: AddPostStatus.success));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: AddPostView(
                addPostCubit: addPostCubit,
              ),
            ),
          ),
        ),
      );
      expect(find.text('Added the post successfully'), findsOneWidget);
    });

    testWidgets('Must close dialog when tap Ok button in success state.',
        (tester) async {
      //arrange
      final goRouter = MockGoRouter();
      when(() => addPostCubit.state)
          .thenReturn(AddPostState(status: AddPostStatus.success));
      when(() => goRouter.pop()).thenAnswer((_) {});
      //act
      await tester.pumpWidget(
        MaterialApp(
          home: MockGoRouterProvider(
            goRouter: goRouter,
            child: AddPostView(
              addPostCubit: addPostCubit,
            ),
          ),
        ),
      );
      await tester.tap(find.byKey(ValueKey('ok-success')));
      //assert
      verify(() => goRouter.pop()).called(1);
    });

    //Must show Cannot add post when fail.
    testWidgets('Must show Cannot add post when fail.', (tester) async {
      when(() => addPostCubit.state)
          .thenReturn(AddPostState(status: AddPostStatus.failure));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: AddPostView(
                addPostCubit: addPostCubit,
              ),
            ),
          ),
        ),
      );
      expect(find.text('Cannot add post'), findsOneWidget);
    });
    //Must show No internet when no internet.
    testWidgets('Must show No internet when no internet.', (tester) async {
      when(() => addPostCubit.state)
          .thenReturn(AddPostState(status: AddPostStatus.noInternet));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: AddPostView(
                addPostCubit: addPostCubit,
              ),
            ),
          ),
        ),
      );
      expect(find.text('No internet'), findsOneWidget);
    });
  });
}
