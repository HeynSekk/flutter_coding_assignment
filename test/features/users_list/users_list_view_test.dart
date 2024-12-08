// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_app/features/add_post/add_post_cubit.dart';
import 'package:flutter_sample_app/features/add_post/add_post_view.dart';
import 'package:flutter_sample_app/features/login/login_cubit.dart';
import 'package:flutter_sample_app/features/users_list/user_list_cubit.dart';
import 'package:flutter_sample_app/features/users_list/users_list_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_repository/user_repository.dart';

import '../../helper/hydrated_bloc.dart';
import '../../helper/mock_go_router.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockUserListCubit extends MockCubit<UserListState>
    implements UserListCubit {}

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
  GetIt getIt = GetIt.instance;
  initHydratedStorage();

  group('UserListPage', () {
    late UserListCubit userListCubit;
    late LoginCubit loginCubit;

    testWidgets(
        'Provide cubits correctly which mean rendering UserListView is ok',
        (tester) async {
      //arrange
      GetIt getIt = GetIt.instance;
      userListCubit = MockUserListCubit();
      loginCubit = MockLoginCubit();
      when(() => loginCubit.state)
          .thenReturn(LoginState(status: LoginStatus.initial));
      when(() => userListCubit.state)
          .thenReturn(UserListState(status: UserListStatus.initial));
      when(() => userListCubit.init()).thenAnswer((_) async {});
      getIt.registerSingleton(userListCubit);
      getIt.registerSingleton(loginCubit);
      //act
      await tester.pumpWidget(
        MaterialApp(
          home: UserListPage(),
        ),
      );
      //assert
      expect(find.byType(UserListView), findsOneWidget);
      getIt.reset();
    });
  });

  group('UserListView', () {
    late UserListCubit userListCubit;
    late LoginCubit loginCubit;
    late UserRepository userRepository;

    setUp(() {
      userListCubit = MockUserListCubit();
      loginCubit = MockLoginCubit();
      when(() => loginCubit.state)
          .thenReturn(LoginState(status: LoginStatus.initial));
    });

    //Must call init method of the cubit on start up.
    testWidgets('Must call init method of the cubit on start up.',
        (tester) async {
      when(() => userListCubit.state)
          .thenReturn(UserListState(status: UserListStatus.loading));
      when(() => userListCubit.init()).thenAnswer((_) async {});
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => userListCubit,
            ),
            BlocProvider.value(
              value: loginCubit,
            )
          ],
          child: MaterialApp(home: const UserListView()),
        ),
      );
      verify(() => userListCubit.init()).called(1);
    });

    //Must show loading while loading.
    testWidgets('Must show loading while loading.', (tester) async {
      when(() => userListCubit.state)
          .thenReturn(UserListState(status: UserListStatus.loading));
      when(() => userListCubit.init()).thenAnswer((_) async {});
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => userListCubit,
            ),
            BlocProvider.value(
              value: loginCubit,
            )
          ],
          child: MaterialApp(home: const UserListView()),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
    //Must show data correctly when get data.
    testWidgets('Must show data correctly when get data.', (tester) async {
      when(() => userListCubit.state).thenReturn(
        UserListState(
          status: UserListStatus.success,
          users: [
            User(id: 1, name: 'John', email: 'john@example.com'),
            User(id: 1, name: 'Alice', email: 'alice@example.com'),
          ],
        ),
      );
      when(() => userListCubit.init()).thenAnswer((_) async {});
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => userListCubit,
            ),
            BlocProvider.value(
              value: loginCubit,
            )
          ],
          child: MaterialApp(home: const UserListView()),
        ),
      );
      expect(find.text('John'), findsOneWidget);
      expect(find.text('john@example.com'), findsOneWidget);
      expect(find.text('Alice'), findsOneWidget);
      expect(find.text('alice@example.com'), findsOneWidget);
    });
    //Must show Cannot fetch user when fail.
    testWidgets('Must show Cannot fetch user when fail.', (tester) async {
      when(() => userListCubit.state)
          .thenReturn(UserListState(status: UserListStatus.failure));
      when(() => userListCubit.init()).thenAnswer((_) async {});
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => userListCubit,
            ),
            BlocProvider.value(
              value: loginCubit,
            )
          ],
          child: MaterialApp(home: const UserListView()),
        ),
      );
      expect(find.text('Cannot fetch users'), findsOneWidget);
    });
    //Must show No internet when no internet.
    testWidgets('Must show No internet when no internet.', (tester) async {
      when(() => userListCubit.state)
          .thenReturn(UserListState(status: UserListStatus.noInternet));
      when(() => userListCubit.init()).thenAnswer((_) async {});
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => userListCubit,
            ),
            BlocProvider.value(
              value: loginCubit,
            )
          ],
          child: MaterialApp(home: const UserListView()),
        ),
      );
      expect(find.text('No internet'), findsOneWidget);
    });
    //Must show Add Post dialog when tap Upload floating button.
    testWidgets('Must show Add Post dialog when tap Upload floating button.',
        (tester) async {
      when(() => userListCubit.state)
          .thenReturn(UserListState(status: UserListStatus.noInternet));
      when(() => userListCubit.init()).thenAnswer((_) async {});
      userRepository = MockUserRepository();
      getIt.registerSingleton<AddPostCubit>(AddPostCubit(userRepository));
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => userListCubit,
            ),
            BlocProvider.value(
              value: loginCubit,
            )
          ],
          child: MaterialApp(home: const UserListView()),
        ),
      );
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.byType(AddPostView), findsOneWidget);
      await getIt.reset();
    });
    //When user list is large, must be ok to show all users in a scroll view.
    testWidgets('Must use a scrollable', (tester) async {
      when(() => userListCubit.state).thenReturn(
        UserListState(
          status: UserListStatus.success,
        ),
      );
      when(() => userListCubit.init()).thenAnswer((_) async {});
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => userListCubit,
            ),
            BlocProvider.value(
              value: loginCubit,
            )
          ],
          child: MaterialApp(home: const UserListView()),
        ),
      );
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
    //Call correct method of cubit when tap Generate JSON
    testWidgets('Call correct method of cubit when tap Generate JSON',
        (tester) async {
      //arrange
      when(() => userListCubit.state)
          .thenReturn(UserListState(status: UserListStatus.success));
      when(() => userListCubit.generateJson()).thenAnswer((_) async {});
      when(() => userListCubit.init()).thenAnswer((_) async {});
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => userListCubit,
            ),
            BlocProvider.value(
              value: loginCubit,
            )
          ],
          child: MaterialApp(home: const UserListView()),
        ),
      );
      //act
      await tester.tap(find.byKey(ValueKey('popupMenuButton')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Generate JSON'));
      //assert
      verify(() => userListCubit.generateJson()).called(1);
    });
    //Call correct method of cubit when tap Logout
    testWidgets('Call correct method of cubit when tap Logout', (tester) async {
      //arrange
      when(() => userListCubit.state)
          .thenReturn(UserListState(status: UserListStatus.success));
      when(() => loginCubit.logout()).thenAnswer((_) async {});
      when(() => userListCubit.init()).thenAnswer((_) async {});
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => userListCubit,
            ),
            BlocProvider.value(
              value: loginCubit,
            )
          ],
          child: MaterialApp(home: const UserListView()),
        ),
      );
      //act
      await tester.tap(find.byKey(ValueKey('popupMenuButton')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Logout'));
      //assert
      verify(() => loginCubit.logout()).called(1);
    });
    //Go to login page when logout success
    testWidgets('Go to login page when logout success', (tester) async {
      //arrange
      final goRouter = MockGoRouter();
      whenListen(loginCubit,
          Stream.value(LoginState(status: LoginStatus.logoutSuccess)));
      when(() => userListCubit.state)
          .thenReturn(UserListState(status: UserListStatus.success));
      when(() => userListCubit.init()).thenAnswer((_) async {});
      when(() => goRouter.goNamed(any())).thenAnswer((_) async {});
      //act
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => userListCubit,
            ),
            BlocProvider.value(
              value: loginCubit,
            )
          ],
          child: MaterialApp(
            home: MockGoRouterProvider(
              goRouter: goRouter,
              child: const UserListView(),
            ),
          ),
        ),
      );
      //assert
      verify(() => goRouter.goNamed('login')).called(1);
    });
  });
}
