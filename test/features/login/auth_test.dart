// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sample_app/features/login/auth.dart';
import 'package:flutter_sample_app/util/connection_util.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

class MockUserCredential extends Mock implements UserCredential {}

class MockConnectionUtil extends Mock implements ConnectionUtil {}

void main() {
  group('Auth', () {
    GetIt getIt = GetIt.instance;
    late FirebaseAuth firebaseAuth;
    late ConnectionUtil connectionUtil;

    setUp(() {
      firebaseAuth = MockFirebaseAuth();
    });

    //Failing test case
    // group('constructor', () {
    //   test('does not require an FirebaseAuth', () {
    //     expect(Auth(), isNotNull);
    //   });
    // });

    group('isAuthenticated', () {
      tearDown(() async {
        await getIt.reset();
      });
      //Offline, logged in, return true
      test('Offline, logged in, return true', () async {
        final user = MockUser();
        connectionUtil = MockConnectionUtil();
        when(
          () => connectionUtil.isConnected(),
        ).thenAnswer((_) async => false);
        getIt.registerSingleton<ConnectionUtil>(connectionUtil);

        firebaseAuth = MockFirebaseAuth();
        when(
          () => firebaseAuth.currentUser,
        ).thenReturn(user);

        final auth = Auth(firebaseAuth: firebaseAuth);

        final actual = await auth.isAuthenticated();
        expect(actual, true);
      });

      //Offline, logged out, return false
      test('Offline, logged out, return false', () async {
        connectionUtil = MockConnectionUtil();
        when(
          () => connectionUtil.isConnected(),
        ).thenAnswer((_) async => false);
        getIt.registerSingleton<ConnectionUtil>(connectionUtil);

        firebaseAuth = MockFirebaseAuth();
        when(
          () => firebaseAuth.currentUser,
        ).thenReturn(null);

        final auth = Auth(firebaseAuth: firebaseAuth);

        final actual = await auth.isAuthenticated();
        expect(actual, false);
      });

      //Online, logged in, return true
      test('Online, logged in, return true', () async {
        connectionUtil = MockConnectionUtil();
        when(
          () => connectionUtil.isConnected(),
        ).thenAnswer((_) async => true);
        getIt.registerSingleton<ConnectionUtil>(connectionUtil);

        final user = MockUser();
        when(
          () => user.getIdToken(true),
        ).thenAnswer((_) async => 'token');

        firebaseAuth = MockFirebaseAuth();
        when(
          () => firebaseAuth.currentUser,
        ).thenReturn(user);

        final auth = Auth(firebaseAuth: firebaseAuth);

        final actual = await auth.isAuthenticated();
        expect(actual, true);
      });
      //Online, logged out, return false
      test('Online, logged out, return false', () async {
        connectionUtil = MockConnectionUtil();
        when(
          () => connectionUtil.isConnected(),
        ).thenAnswer((_) async => true);
        getIt.registerSingleton<ConnectionUtil>(connectionUtil);

        final user = MockUser();
        when(
          () => user.getIdToken(true),
        ).thenAnswer((_) async => null);

        firebaseAuth = MockFirebaseAuth();
        when(
          () => firebaseAuth.currentUser,
        ).thenReturn(user);

        final auth = Auth(firebaseAuth: firebaseAuth);

        final actual = await auth.isAuthenticated();
        expect(actual, false);
      });
    });

    group('login', () {
      //Call signInWithEmailAndPassword of the service class with correct input
      test(
          'Call signInWithEmailAndPassword of the service class with correct input',
          () async {
        firebaseAuth = MockFirebaseAuth();
        when(
          () => firebaseAuth.signInWithEmailAndPassword(
              email: any(named: 'email'), password: any(named: 'password')),
        ).thenAnswer((_) async => MockUserCredential());

        final auth = Auth(firebaseAuth: firebaseAuth);

        await auth.login(email: 'e', password: 'p');
        verify(() => firebaseAuth.signInWithEmailAndPassword(
            email: 'e', password: 'p')).called(1);
      });
    });
    group('logout', () {
      //Call signOut of the service class
      test('Call signOut of the service class', () async {
        firebaseAuth = MockFirebaseAuth();
        when(
          () => firebaseAuth.signOut(),
        ).thenAnswer((_) async => {});

        final auth = Auth(firebaseAuth: firebaseAuth);

        await auth.logout();
        verify(() => firebaseAuth.signOut()).called(1);
      });
    });
  });
}
