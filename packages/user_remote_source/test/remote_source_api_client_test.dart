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
        when(() => response.body).thenReturn('{"users": []}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await apiClient.fetchUsers();
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https(
              'dummyjson.com',
              '/users',
            ),
          ),
        ).called(1);
      });

      test('throws Exception on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => apiClient.fetchUsers(),
          throwsA(isA<Exception>()),
        );
      });

      test('returns User list on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
          '''
{
  "users": [
    {
      "id": 1,
      "firstName": "Terry",
      "lastName": "Medhurst",
      "maidenName": "Smitham",
      "age": 50,
      "gender": "male",
      "email": "atowsand0@bing.com",
      "phone": "+63 791 675 8914",
      "username": "atowsand0",
      "password": "password",
      "birthDate": "2000-12-25",
      "image": "https://robohash.org/hicvelres.png",
      "bloodGroup": "A+",
      "height": 189,
      "weight": 75.4,
      "eyeColor": "Green",
      "hair": {
        "color": "Black",
        "type": "Strands"
      },
      "domain": "google.com",
      "ip": "21.179.162.2",
      "address": {
        "address": "1745 T Street NW",
        "city": "Washington",
        "coordinates": {
          "lat": 38.9072,
          "lng": -77.0369
        },
        "postalCode": "20009",
        "state": "DC"
      },
      "macAddress": "01:23:45:67:89:AB",
      "university": "Capitol University",
      "bank": {
        "cardExpire": "05/26",
        "cardNumber": "1234567890123456",
        "cardType": "MasterCard",
        "currency": "USD",
        "iban": "US12345678901234567890"
      },
      "company": {
        "address": {
          "address": "123 Main St",
          "city": "New York",
          "coordinates": {
            "lat": 40.7128,
            "lng": -74.0060
          },
          "postalCode": "10001",
          "state": "NY"
        },
        "department": "Engineering",
        "name": "Tech Corp",
        "title": "Software Engineer"
      },
      "ein": "12-3456789",
      "ssn": "123-456-7890",
      "userAgent": "Mozilla/5.0",
      "crypto": {
        "coin": "Bitcoin",
        "wallet": "1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa",
        "network": "Ethereum"
      }
    }
  ]
}
''',
        );
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await apiClient.fetchUsers();
        expect(
          actual[0],
          isA<UserResponse>()
              .having((l) => l.id, 'id', 1)
              .having((l) => l.username, 'username', 'atowsand0'),
        );
      });
    });

    group('addPost', () {
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(201);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.post(any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'))).thenAnswer((_) async => response);
        try {
          await apiClient.addPost(PostModel());
        } catch (_) {}
        verify(
          () => httpClient.post(
            Uri.https(
              'dummyjson.com',
              '/posts/add',
            ),
            body: jsonEncode(PostModel()),
            headers: {'Content-Type': 'application/json'},
          ),
        ).called(1);
      });

      test('throws Exception on non-201 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(
          () => httpClient.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => response);
        expect(
          () async => apiClient.addPost(PostModel()),
          throwsA(isA<Exception>()),
        );
      });

      test('returns nothing on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(201);
        when(() => response.body).thenReturn('{}');
        when(
          () => httpClient.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => response);
        bool err = false;
        try {
          await apiClient.addPost(PostModel());
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
