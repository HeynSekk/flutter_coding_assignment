// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_sample_app/features/users_list/user_list_cubit.dart';
import 'package:flutter_sample_app/models/user.dart' as current;
import 'package:flutter_sample_app/util/connection_util.dart';
import 'package:flutter_sample_app/util/json_generator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_repository/user_repository.dart';

import '../../helper/hydrated_bloc.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockJsonGenerator extends Mock implements JsonGenerator {}

class MockConnectionUtil extends Mock implements ConnectionUtil {}

void main() {
  initHydratedStorage();

  group('UserListCubit', () {
    GetIt getIt = GetIt.instance;
    late UserRepository userRepository;
    late JsonGenerator jsonGenerator;
    late ConnectionUtil connectionUtil;
    late UserListCubit userListCubit;

    tearDown(() {
      getIt.reset();
    });

    test('initial state is correct', () {
      userRepository = MockUserRepository();
      jsonGenerator = MockJsonGenerator();
      final userListCubit = UserListCubit(userRepository, jsonGenerator);
      expect(userListCubit.state, UserListState());
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        userRepository = MockUserRepository();
        jsonGenerator = MockJsonGenerator();
        final userListCubit = UserListCubit(userRepository, jsonGenerator);
        final sampleState = userListCubit.state.copyWith(
          status: UserListStatus.initial,
          users: [
            current.User(
              id: 1,
              address: current.Address(
                city: 'city',
                geo: current.Geo(
                  lat: "1",
                ),
              ),
              company: current.Company(
                name: 'name',
              ),
            ),
          ],
        );
        final stateJson = userListCubit.toJson(sampleState);
        final stateObject = userListCubit.fromJson(stateJson);
        expect(
          stateObject,
          sampleState,
        );
      });
    });

    group('init', () {
      setUp(() {
        jsonGenerator = MockJsonGenerator();
      });
      //When connected to internet, must fecth from remote source
      blocTest<UserListCubit, UserListState>(
        'when connected to internet, must fecth from remote source',
        setUp: () {
          //arrange for ConnectionUtil
          connectionUtil = MockConnectionUtil();
          when(
            () => connectionUtil.isConnected(),
          ).thenAnswer((_) async => true);
          getIt.registerSingleton<ConnectionUtil>(connectionUtil);
          //arrange for UserRepository
          userRepository = MockUserRepository();
          when(
            () => userRepository.getUsers(),
          ).thenAnswer((_) async => []);
          //arrange for UserListCubit
          userListCubit = UserListCubit(userRepository, jsonGenerator);
        },
        build: () => userListCubit,
        act: (cubit) => cubit.init(),
        expect: () => <dynamic>[
          isA<UserListState>()
              .having((s) => s.status, 'status', UserListStatus.loading),
          isA<UserListState>()
              .having((s) => s.status, 'status', UserListStatus.success),
        ],
      );
      //No internet, and first time, must emit noInternet
      blocTest<UserListCubit, UserListState>(
        'No internet, and first time, must emit noInternet',
        setUp: () {
          //arrange for ConnectionUtil
          connectionUtil = MockConnectionUtil();
          when(
            () => connectionUtil.isConnected(),
          ).thenAnswer((_) async => false);
          getIt.registerSingleton<ConnectionUtil>(connectionUtil);
          //arrange for UserRepository
          userRepository = MockUserRepository();
          //arrange for UserListCubit
          userListCubit = UserListCubit(userRepository, jsonGenerator);
        },
        seed: () => UserListState(),
        build: () => userListCubit,
        act: (cubit) => cubit.init(),
        expect: () => <dynamic>[
          isA<UserListState>()
              .having((s) => s.status, 'status', UserListStatus.noInternet),
        ],
      );
      //No internet, not the first time, must show data from local db (status must
      //be success)
      blocTest<UserListCubit, UserListState>(
        'No internet, not the first time, must show data from local db',
        setUp: () {
          //arrange for ConnectionUtil
          connectionUtil = MockConnectionUtil();
          when(
            () => connectionUtil.isConnected(),
          ).thenAnswer((_) async => false);
          getIt.registerSingleton<ConnectionUtil>(connectionUtil);
          //arrange for UserRepository
          userRepository = MockUserRepository();
          //arrange for UserListCubit
          userListCubit = UserListCubit(userRepository, jsonGenerator);
        },
        seed: () => UserListState(status: UserListStatus.success),
        build: () => userListCubit,
        act: (cubit) => cubit.init(),
        expect: () => <UserListState>[],
        verify: (cubit) {
          expect(cubit.state.status, UserListStatus.success);
        },
      );
    });

    group('fetchUsers', () {
      setUp(() {
        jsonGenerator = MockJsonGenerator();
      });
      final users = [
        User(id: 1, address: Address(city: 'City 1')),
        User(id: 2)
      ];
      //Emit success state with correct users when succeed
      blocTest<UserListCubit, UserListState>(
        'Emit success state with correct users when succeed',
        setUp: () {
          //arrange for UserRepository
          userRepository = MockUserRepository();
          when(
            () => userRepository.getUsers(),
          ).thenAnswer((_) async => users);
          //arrange for UserListCubit
          userListCubit = UserListCubit(userRepository, jsonGenerator);
        },
        build: () => userListCubit,
        act: (cubit) => cubit.fetchUsers(),
        expect: () => <dynamic>[
          isA<UserListState>()
              .having((s) => s.status, 'status', UserListStatus.loading),
          isA<UserListState>()
              .having((s) => s.status, 'status', UserListStatus.success)
              .having((s) => s.users[0].id, 'id of second user', 1)
              .having((s) => s.users[1].id, 'id of second user', 2),
        ],
      );
      //Emit failure state when fail
      blocTest<UserListCubit, UserListState>(
        'Emit failure state when fail',
        setUp: () {
          //arrange for UserRepository
          userRepository = MockUserRepository();
          when(
            () => userRepository.getUsers(),
          ).thenThrow(Exception('oops'));
          //arrange for UserListCubit
          userListCubit = UserListCubit(userRepository, jsonGenerator);
        },
        build: () => userListCubit,
        act: (cubit) => cubit.fetchUsers(),
        expect: () => <dynamic>[
          isA<UserListState>()
              .having((s) => s.status, 'status', UserListStatus.loading),
          isA<UserListState>()
              .having((s) => s.status, 'status', UserListStatus.failure),
        ],
      );
    });

    group('generateJson', () {
      setUp(() {
        userRepository = MockUserRepository();
      });
      //Call correct function of the service with correct input
      blocTest<UserListCubit, UserListState>(
        'Call correct function of the service with correct input',
        seed: () => UserListState(users: const [current.User(id: 1)]),
        setUp: () {
          jsonGenerator = MockJsonGenerator();
          when(
            () => jsonGenerator.generateJson(any()),
          ).thenAnswer((_) async {});
          userListCubit = UserListCubit(userRepository, jsonGenerator);
        },
        build: () => userListCubit,
        act: (cubit) => cubit.generateJson(),
        verify: (cubit) {
          verify(() => jsonGenerator.generateJson(cubit.state.users)).called(1);
        },
      );
      //Emit success state when succeed
      blocTest<UserListCubit, UserListState>(
        'Emit success state when succeed',
        setUp: () {
          jsonGenerator = MockJsonGenerator();
          when(
            () => jsonGenerator.generateJson(any()),
          ).thenAnswer((_) async {});
          userListCubit = UserListCubit(userRepository, jsonGenerator);
        },
        build: () => userListCubit,
        act: (cubit) => cubit.generateJson(),
        expect: () => <dynamic>[
          isA<UserListState>()
              .having((s) => s.status, 'status', UserListStatus.loading),
          isA<UserListState>().having(
              (s) => s.status, 'status', UserListStatus.jsonGenerateSuccess),
        ],
      );
      //Emit failure state when fail
      blocTest<UserListCubit, UserListState>(
        'Emit failure state when fail',
        seed: () => UserListState(users: const [current.User(id: 1)]),
        setUp: () {
          //arrange for UserRepository
          jsonGenerator = MockJsonGenerator();
          when(
            () => jsonGenerator.generateJson(any()),
          ).thenThrow(Exception('oops'));
          userListCubit = UserListCubit(userRepository, jsonGenerator);
        },
        build: () => userListCubit,
        act: (cubit) => cubit.generateJson(),
        expect: () => <dynamic>[
          isA<UserListState>()
              .having((s) => s.status, 'status', UserListStatus.loading),
          isA<UserListState>().having(
              (s) => s.status, 'status', UserListStatus.jsonGenerateFailure),
        ],
      );
    });
  });
}
