// ignore_for_file: prefer_const_constructors

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_sample_app/util/connection_util.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  group('ConnectionUtil', () {
    late Connectivity connectivity;
    late ConnectionUtil connectionUtil;

    setUp(() {
      connectivity = MockConnectivity();
      connectionUtil = ConnectionUtil(connectivity: connectivity);
    });

    group('isConnected', () {
      //not connected to any network, must return false
      test('not connected to any network, must return false', () async {
        when(() => connectivity.checkConnectivity())
            .thenAnswer((_) async => []);
        final isConnected = await connectionUtil.isConnected();
        expect(isConnected, false);
      });
      //connected to some networks, must return true
      test('connected to some networks, must return true', () async {
        when(() => connectivity.checkConnectivity())
            .thenAnswer((_) async => [ConnectivityResult.mobile]);
        final isConnected = await connectionUtil.isConnected();
        expect(isConnected, true);
      });
    });
  });
}
