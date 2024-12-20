// ignore_for_file: prefer_const_constructors
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:user_remote_source/user_remote_source.dart' as remote;
import 'package:user_repository/user_repository.dart';

class MockRemoteSourceApiClient extends Mock
    implements remote.RemoteSourceApiClient {}

void main() {
  group('UserRepository', () {
    late remote.RemoteSourceApiClient remoteApiClient;
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
        try {
          await userRepository.addPost(Post(userId: 2));
        } catch (_) {}
        verify(
          () => remoteApiClient.addPost(
            remote.Post(userId: 2),
          ),
        ).called(1);
      });
    });

    group('getUsers', () {
      test(
          'get the result of api client and transform remote.User to current.User object',
          () async {
        when(
          () => remoteApiClient.fetchUsers(),
        ).thenAnswer((_) async => [remote.User(name: 'John')]);
        List<User> users = await userRepository.getUsers();
        expect(
          users[0],
          isA<User>().having((l) => l.name, 'name', 'John'),
        );
      });
    });
  });
}
