// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_sample_app/features/login/auth.dart';
import 'package:flutter_sample_app/features/login/login_cubit.dart';
import 'package:flutter_sample_app/util/connection_util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockAuth extends Mock implements Auth {}

class MockConnectionUtil extends Mock implements ConnectionUtil {}

void main() {
  group('LoginCubit', () {
    GetIt getIt = GetIt.instance;
    late Auth auth;
    late ConnectionUtil connectionUtil;
    late LoginCubit loginCubit;

    test('initial state is correct', () {
      auth = MockAuth();
      final loginCubit = LoginCubit(auth);
      expect(loginCubit.state, LoginState(status: LoginStatus.loading));
    });

    group('init', () {
      //Must call isAuthenticated function of the service
      blocTest<LoginCubit, LoginState>(
        'Must call isAuthenticated function of the service',
        setUp: () {
          auth = MockAuth();
          when(
            () => auth.isAuthenticated(),
          ).thenAnswer((_) async => true);
          loginCubit = LoginCubit(auth);
        },
        build: () => loginCubit,
        act: (cubit) => cubit.init(),
        verify: (cubit) {
          verify(() => auth.isAuthenticated()).called(1);
        },
      );
      //Already login, must emit alreadyLogin
      blocTest<LoginCubit, LoginState>(
        'Already login, must emit alreadyLogin',
        setUp: () {
          auth = MockAuth();
          when(
            () => auth.isAuthenticated(),
          ).thenAnswer((_) async => true);
          loginCubit = LoginCubit(auth);
        },
        build: () => loginCubit,
        act: (cubit) => cubit.init(),
        expect: () => <dynamic>[
          isA<LoginState>()
              .having((s) => s.status, 'status', LoginStatus.loading),
          isA<LoginState>()
              .having((s) => s.status, 'status', LoginStatus.alreadyLogin),
        ],
      );
      //Not already login, must emit initial
      blocTest<LoginCubit, LoginState>(
        'Not already login, must emit initial',
        setUp: () {
          auth = MockAuth();
          when(
            () => auth.isAuthenticated(),
          ).thenAnswer((_) async => false);
          loginCubit = LoginCubit(auth);
        },
        build: () => loginCubit,
        act: (cubit) => cubit.init(),
        expect: () => <dynamic>[
          isA<LoginState>()
              .having((s) => s.status, 'status', LoginStatus.loading),
          isA<LoginState>()
              .having((s) => s.status, 'status', LoginStatus.initial),
        ],
      );
      //When auth check failed, must emit authCheckFailure
      blocTest<LoginCubit, LoginState>(
        'When auth check failed, must emit authCheckFailure',
        setUp: () {
          auth = MockAuth();
          when(
            () => auth.isAuthenticated(),
          ).thenThrow(Exception('oopps'));
          loginCubit = LoginCubit(auth);
        },
        build: () => loginCubit,
        act: (cubit) => cubit.init(),
        expect: () => <dynamic>[
          isA<LoginState>()
              .having((s) => s.status, 'status', LoginStatus.loading),
          isA<LoginState>()
              .having((s) => s.status, 'status', LoginStatus.authCheckFailure),
        ],
      );
    });

    group('login', () {
      tearDown(() {
        getIt.reset();
      });
      //Must call login function of the service with correct input
      blocTest<LoginCubit, LoginState>(
        'Must call login function of the service with correct input',
        setUp: () {
          connectionUtil = MockConnectionUtil();
          when(
            () => connectionUtil.isConnected(),
          ).thenAnswer((_) async => true);
          getIt.registerSingleton<ConnectionUtil>(connectionUtil);
          auth = MockAuth();
          when(
            () => auth.login(
                email: any(named: 'email'), password: any(named: 'password')),
          ).thenAnswer((_) async => {});
          loginCubit = LoginCubit(auth);
        },
        build: () => loginCubit,
        act: (cubit) => cubit.login(email: 'e', password: 'p'),
        verify: (cubit) {
          verify(() => auth.login(email: 'e', password: 'p')).called(1);
        },
      );
      //If no internet, must emit noInternet
      blocTest<LoginCubit, LoginState>(
        'If no internet, must emit noInternet',
        setUp: () {
          connectionUtil = MockConnectionUtil();
          when(
            () => connectionUtil.isConnected(),
          ).thenAnswer((_) async => false);
          getIt.registerSingleton<ConnectionUtil>(connectionUtil);
          auth = MockAuth();
          loginCubit = LoginCubit(auth);
        },
        build: () => loginCubit,
        act: (cubit) => cubit.login(email: 'e', password: 'p'),
        expect: () => <dynamic>[
          isA<LoginState>()
              .having((s) => s.status, 'status', LoginStatus.noInternet),
        ],
      );
      //When login succeed, must emit loading and success
      blocTest<LoginCubit, LoginState>(
        'When login succeed, must emit loading and success',
        setUp: () {
          connectionUtil = MockConnectionUtil();
          when(
            () => connectionUtil.isConnected(),
          ).thenAnswer((_) async => true);
          getIt.registerSingleton<ConnectionUtil>(connectionUtil);
          auth = MockAuth();
          when(
            () => auth.login(
                email: any(named: 'email'), password: any(named: 'password')),
          ).thenAnswer((_) async => {});
          loginCubit = LoginCubit(auth);
        },
        build: () => loginCubit,
        act: (cubit) => cubit.login(email: 'e', password: 'p'),
        expect: () => <dynamic>[
          isA<LoginState>()
              .having((s) => s.status, 'status', LoginStatus.loading),
          isA<LoginState>()
              .having((s) => s.status, 'status', LoginStatus.success),
        ],
      );
      //When login fail, must emit loading and failure
      blocTest<LoginCubit, LoginState>(
        'When login fail, must emit loading and failure',
        setUp: () {
          connectionUtil = MockConnectionUtil();
          when(
            () => connectionUtil.isConnected(),
          ).thenAnswer((_) async => true);
          getIt.registerSingleton<ConnectionUtil>(connectionUtil);
          auth = MockAuth();
          when(
            () => auth.login(
                email: any(named: 'email'), password: any(named: 'password')),
          ).thenThrow(Exception('opps'));
          loginCubit = LoginCubit(auth);
        },
        build: () => loginCubit,
        act: (cubit) => cubit.login(email: 'e', password: 'p'),
        expect: () => <dynamic>[
          isA<LoginState>()
              .having((s) => s.status, 'status', LoginStatus.loading),
          isA<LoginState>()
              .having((s) => s.status, 'status', LoginStatus.failure),
        ],
      );
    });
    group('logout', () {
      //Must call logout function of the service
      blocTest<LoginCubit, LoginState>(
        'Must call logout function of the service',
        setUp: () {
          auth = MockAuth();
          when(
            () => auth.logout(),
          ).thenAnswer((_) async => {});
          loginCubit = LoginCubit(auth);
        },
        build: () => loginCubit,
        act: (cubit) => cubit.logout(),
        verify: (cubit) {
          verify(() => auth.logout()).called(1);
        },
      );
      //Success, emit loading and success
      blocTest<LoginCubit, LoginState>(
        'Success, emit loading and success',
        setUp: () {
          auth = MockAuth();
          when(
            () => auth.logout(),
          ).thenAnswer((_) async {});
          loginCubit = LoginCubit(auth);
        },
        build: () => loginCubit,
        act: (cubit) => cubit.logout(),
        expect: () => <dynamic>[
          isA<LoginState>()
              .having((s) => s.status, 'status', LoginStatus.loading),
          isA<LoginState>()
              .having((s) => s.status, 'status', LoginStatus.logoutSuccess),
        ],
      );
      //Failure, emit loading and failure
      blocTest<LoginCubit, LoginState>(
        'Failure, emit loading and failure',
        setUp: () {
          auth = MockAuth();
          when(
            () => auth.logout(),
          ).thenThrow(Exception('opps'));
          loginCubit = LoginCubit(auth);
        },
        build: () => loginCubit,
        act: (cubit) => cubit.logout(),
        expect: () => <dynamic>[
          isA<LoginState>()
              .having((s) => s.status, 'status', LoginStatus.loading),
          isA<LoginState>()
              .having((s) => s.status, 'status', LoginStatus.failure),
        ],
      );
    });
  });
}
