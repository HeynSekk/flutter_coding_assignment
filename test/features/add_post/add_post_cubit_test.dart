// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_sample_app/features/add_post/add_post_cubit.dart';
import 'package:flutter_sample_app/features/add_post/post.dart';
import 'package:flutter_sample_app/util/connection_util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_repository/user_repository.dart' as repo;

class MockUserRepository extends Mock implements repo.UserRepository {}

class MockConnectionUtil extends Mock implements ConnectionUtil {}

void main() {
  group('AddPostCubit', () {
    GetIt getIt = GetIt.instance;
    late repo.UserRepository userRepository;
    late ConnectionUtil connectionUtil;
    late AddPostCubit addPostCubit;

    tearDown(() {
      getIt.reset();
    });

    test('initial state is correct', () {
      userRepository = MockUserRepository();
      final addPostCubit = AddPostCubit(userRepository);
      expect(addPostCubit.state, AddPostState());
    });

    group('addPost', () {
      final inputPost = Post(userId: 2, title: 'nice title');
      final inputPostRepo = repo.Post(userId: 2, title: 'nice title');
      //No internet, add post, must emit noInternet.
      blocTest<AddPostCubit, AddPostState>(
        'No internet, add post, must emit noInternet.',
        setUp: () {
          //arrange for ConnectionUtil
          connectionUtil = MockConnectionUtil();
          when(
            () => connectionUtil.isConnected(),
          ).thenAnswer((_) async => false);
          getIt.registerSingleton<ConnectionUtil>(connectionUtil);
          //arrange for UserRepository
          userRepository = MockUserRepository();
          //arrange for AddPostCubit
          addPostCubit = AddPostCubit(userRepository);
        },
        build: () => addPostCubit,
        act: (cubit) => cubit.addPost(Post()),
        expect: () => <dynamic>[
          isA<AddPostState>()
              .having((s) => s.status, 'status', AddPostStatus.noInternet),
        ],
      );
      //Make call to repo method with correct input
      blocTest<AddPostCubit, AddPostState>(
        'Make call to repo method with correct input',
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
            () => userRepository.addPost(inputPostRepo),
          ).thenAnswer((_) async {});
          //arrange for AddPostCubit
          addPostCubit = AddPostCubit(userRepository);
        },
        build: () => addPostCubit,
        act: (cubit) => cubit.addPost(inputPost),
        verify: (cubit) {
          verify(() => userRepository.addPost(inputPostRepo)).called(1);
        },
      );
      //Add post succeed, must emit loading, and success
      blocTest<AddPostCubit, AddPostState>(
        'Add post succeed, must emit success',
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
            () => userRepository.addPost(inputPostRepo),
          ).thenAnswer((_) async {});
          //arrange for AddPostCubit
          addPostCubit = AddPostCubit(userRepository);
        },
        build: () => addPostCubit,
        act: (cubit) => cubit.addPost(inputPost),
        expect: () => <dynamic>[
          isA<AddPostState>()
              .having((s) => s.status, 'status', AddPostStatus.loading),
          isA<AddPostState>()
              .having((s) => s.status, 'status', AddPostStatus.success),
        ],
      );
      //Add post fail, must emit failure
      blocTest<AddPostCubit, AddPostState>(
        'Add post fail, must emit failure',
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
            () => userRepository.addPost(inputPostRepo),
          ).thenThrow(Exception('oopps'));
          //arrange for AddPostCubit
          addPostCubit = AddPostCubit(userRepository);
        },
        build: () => addPostCubit,
        act: (cubit) => cubit.addPost(inputPost),
        expect: () => <dynamic>[
          isA<AddPostState>()
              .having((s) => s.status, 'status', AddPostStatus.loading),
          isA<AddPostState>()
              .having((s) => s.status, 'status', AddPostStatus.failure),
        ],
      );
    });
  });
}
