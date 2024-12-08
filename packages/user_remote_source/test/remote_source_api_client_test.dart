// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:user_remote_source/user_remote_source.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('RemoteSourceApiClient', () {
    late http.Client httpClient;
    late RemoteSourceApiClient apiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      apiClient = RemoteSourceApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(RemoteSourceApiClient(), isNotNull);
      });
    });

    group('fetchUsers', () {
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await apiClient.fetchUsers();
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https(
              'jsonplaceholder.typicode.com',
              '/users',
            ),
          ),
        ).called(1);
      });

      test('throws UserRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => apiClient.fetchUsers(),
          throwsA(isA<UserRequestFailure>()),
        );
      });

      test('returns User list on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
          '''
[
{
    "id": 1,
    "name": "Leanne Graham",
    "username": "Bret",
    "email": "Sincere@april.biz",
    "address": {
      "street": "Kulas Light",
      "suite": "Apt. 556",
      "city": "Gwenborough",
      "zipcode": "92998-3874",
      "geo": {
        "lat": "-37.3159",
        "lng": "81.1496"
      }
    },
    "phone": "1-770-736-8031 x56442",
    "website": "hildegard.org",
    "company": {
      "name": "Romaguera-Crona",
      "catchPhrase": "Multi-layered client-server neural-net",
      "bs": "harness real-time e-markets"
    }
  },
  {
    "id": 2,
    "name": "Ervin Howell",
    "username": "Antonette",
    "email": "Shanna@melissa.tv",
    "address": {
      "street": "Victor Plains",
      "suite": "Suite 879",
      "city": "Wisokyburgh",
      "zipcode": "90566-7771",
      "geo": {
        "lat": "-43.9509",
        "lng": "-34.4618"
      }
    },
    "phone": "010-692-6593 x09125",
    "website": "anastasia.net",
    "company": {
      "name": "Deckow-Crist",
      "catchPhrase": "Proactive didactic contingency",
      "bs": "synergize scalable supply-chains"
    }
  }]
''',
        );
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await apiClient.fetchUsers();
        expect(
          actual[0],
          isA<User>()
              .having((l) => l.id, 'id', 1)
              .having((l) => l.username, 'username', 'Bret'),
        );
      });
    });

    group('addPost', () {
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.post(any(), body: ''))
            .thenAnswer((_) async => response);
        try {
          await apiClient.addPost(Post());
        } catch (_) {}
        verify(
          () => httpClient.post(
            Uri.https(
              'jsonplaceholder.typicode.com',
              '/posts',
            ),
            body: jsonEncode(Post()),
          ),
        ).called(1);
      });

      test('throws AddPostRequestFailure on non-201 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(
          () => httpClient.post(
            any(),
            body: jsonEncode(
              Post(),
            ),
          ),
        ).thenAnswer((_) async => response);
        expect(
          () async => apiClient.addPost(Post()),
          throwsA(isA<AddPostRequestFailure>()),
        );
      });

      test('returns nothing on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(201);
        when(() => response.body).thenReturn(
          '''
''',
        );
        when(
          () => httpClient.post(
            any(),
            body: jsonEncode(
              Post(),
            ),
          ),
        ).thenAnswer((_) async => response);
        bool err = false;
        try {
          await apiClient.addPost(Post());
        } catch (_) {
          err = true;
        }

        expect(
          err,
          false,
        );
      });
    });
  });
}
