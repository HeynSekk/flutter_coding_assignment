// ignore_for_file: prefer_const_constructors
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:user_remote_source/user_remote_source.dart'
    as user_remote_source;
import 'package:user_repository/user_repository.dart';

class MockRemoteSourceApiClient extends Mock
    implements user_remote_source.RemoteSourceApiClient {}

void main() {
  group('UserRepository', () {
    late user_remote_source.RemoteSourceApiClient remoteApiClient;
    late UserRepository userRepository;

    setUp(() {
      remoteApiClient = MockRemoteSourceApiClient();
      userRepository = UserRepository(
        remoteSourceApiClient: remoteApiClient,
      );
    });

    group('constructor', () {
      test('instantiates internal remote api client when not injected', () {
        expect(UserRepository(), isNotNull);
      });
    });

    group('call methods of remote api client correctly', () {
      test('calls getUsers of remote api client', () async {
        try {
          await userRepository.getUsers();
        } catch (_) {}
        verify(() => remoteApiClient.fetchUsers()).called(1);
      });

      test('calls addPost of remote api client with correct input', () async {
        final post = Post(userId: 2);
        try {
          await userRepository.addPost(post);
        } catch (_) {}
        verify(
          () => remoteApiClient.addPost(
            post,
          ),
        ).called(1);
      });
    });
  });
}
