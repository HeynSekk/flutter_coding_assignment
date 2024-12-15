import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_app/features/login/login_cubit.dart';
import 'package:flutter_sample_app/features/login/login_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helper/mock_go_router.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
  group('LoginPage', () {
    late LoginCubit loginCubit;

    testWidgets('Render LoginView and provide cubit', (tester) async {
      // GetIt getIt = GetIt.instance;
      loginCubit = MockLoginCubit();
      when(() => loginCubit.state)
          .thenReturn(const LoginState(status: LoginStatus.initial));
      when(() => loginCubit.init()).thenAnswer((_) async {});
      // getIt.registerSingleton(loginCubit);

      await tester.pumpWidget(MaterialApp(
        home: LoginPage(
          loginCubit: loginCubit,
        ),
      ));

      expect(find.byType(LoginView), findsOneWidget);
      // await getIt.reset();
    });
  });
  group('LoginView', () {
    late LoginCubit loginCubit;

    setUp(() {
      loginCubit = MockLoginCubit();
    });

    testWidgets('Call init method of the cubit when init', (tester) async {
      //arrange
      when(() => loginCubit.state)
          .thenReturn(const LoginState(status: LoginStatus.initial));
      when(() => loginCubit.init()).thenAnswer((_) async {});
      //act
      await tester.pumpWidget(
        BlocProvider.value(
          value: loginCubit,
          child: const MaterialApp(
            home: LoginView(),
          ),
        ),
      );
      //assert
      verify(() => loginCubit.init()).called(1);
    });

    testWidgets(
        'Call correct method of the cubit with correct input when tap Login button',
        (tester) async {
      //arrange
      when(() => loginCubit.state)
          .thenReturn(const LoginState(status: LoginStatus.authCheckFailure));
      when(() => loginCubit.init()).thenAnswer((_) async {});
      when(() => loginCubit.login(
          email: any(named: 'email'),
          password: any(named: 'password'))).thenAnswer((_) async {});
      //act
      await tester.pumpWidget(
        BlocProvider.value(
          value: loginCubit,
          child: const MaterialApp(
            home: LoginView(),
          ),
        ),
      );
      await tester.enterText(find.byKey(const ValueKey('email')), 'myEmail');
      await tester.enterText(find.byKey(const ValueKey('pwd')), 'myPwd');
      await tester.tap(find.text('Login'));
      //assert
      verify(() => loginCubit.login(email: 'myEmail', password: 'myPwd'))
          .called(1);
    });

    testWidgets('Show No internet in the case', (tester) async {
      //arrange
      when(() => loginCubit.state)
          .thenReturn(const LoginState(status: LoginStatus.noInternet));
      when(() => loginCubit.init()).thenAnswer((_) async {});
      //act
      await tester.pumpWidget(
        BlocProvider.value(
          value: loginCubit,
          child: const MaterialApp(
            home: LoginView(),
          ),
        ),
      );
      //assert
      expect(find.text('No internet'), findsOneWidget);
    });

    testWidgets('Show Need to login and input fields in the case',
        (tester) async {
      //arrange
      when(() => loginCubit.state)
          .thenReturn(const LoginState(status: LoginStatus.authCheckFailure));
      when(() => loginCubit.init()).thenAnswer((_) async {});
      //act
      await tester.pumpWidget(
        BlocProvider.value(
          value: loginCubit,
          child: const MaterialApp(
            home: LoginView(),
          ),
        ),
      );
      //assert
      expect(find.text('You need to login'), findsOneWidget);
      expect(find.byKey(const ValueKey('email')), findsOneWidget);
    });

    testWidgets('Show Cannot login and input fields in the case',
        (tester) async {
      //arrange
      when(() => loginCubit.state)
          .thenReturn(const LoginState(status: LoginStatus.failure));
      when(() => loginCubit.init()).thenAnswer((_) async {});
      //act
      await tester.pumpWidget(
        BlocProvider.value(
          value: loginCubit,
          child: const MaterialApp(
            home: LoginView(),
          ),
        ),
      );
      //assert
      expect(find.text('Cannot login'), findsOneWidget);
      expect(find.byKey(const ValueKey('email')), findsOneWidget);
    });

    testWidgets('Show Loading indicator in the case', (tester) async {
      //arrange
      when(() => loginCubit.state)
          .thenReturn(const LoginState(status: LoginStatus.loading));
      when(() => loginCubit.init()).thenAnswer((_) async {});
      //act
      await tester.pumpWidget(
        BlocProvider.value(
          value: loginCubit,
          child: const MaterialApp(
            home: LoginView(),
          ),
        ),
      );
      //assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Navigate to User List in states of login success',
        (tester) async {
      //arrange
      final goRouter = MockGoRouter();
      whenListen(loginCubit,
          Stream.value(const LoginState(status: LoginStatus.success)));
      when(() => goRouter.goNamed(any())).thenAnswer((_) async {});
      when(() => loginCubit.init()).thenAnswer((_) async {});
      when(() => loginCubit.state)
          .thenReturn(const LoginState(status: LoginStatus.loading));
      //act
      await tester.pumpWidget(
        BlocProvider.value(
          value: loginCubit,
          child: MaterialApp(
            home: MockGoRouterProvider(
              goRouter: goRouter,
              child: const LoginView(),
            ),
          ),
        ),
      );
      //assert
      verify(() => goRouter.goNamed('users-list')).called(1);
    });

    testWidgets('Navigate to User List in states of already login',
        (tester) async {
      //arrange
      final goRouter = MockGoRouter();
      whenListen(loginCubit,
          Stream.value(const LoginState(status: LoginStatus.alreadyLogin)));
      when(() => goRouter.goNamed(any())).thenAnswer((_) async {});
      when(() => loginCubit.init()).thenAnswer((_) async {});
      when(() => loginCubit.state)
          .thenReturn(const LoginState(status: LoginStatus.loading));
      //act
      await tester.pumpWidget(
        BlocProvider.value(
          value: loginCubit,
          child: MaterialApp(
            home: MockGoRouterProvider(
              goRouter: goRouter,
              child: const LoginView(),
            ),
          ),
        ),
      );
      //assert
      verify(() => goRouter.goNamed('users-list')).called(1);
    });
  });
}
