import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_news_app/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/mock_helper.mocks.dart';

void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfoImpl = NetworkInfoImpl(mockConnectivity);
  });

  group('ConnectionChecker', () {
    test(
      'Make sure the checkConnectivity function is actually called with the '
      'connection condition using mobile data',
      () async {
        // arrange
        final tHasConnection = Future.value(ConnectivityResult.mobile);
        when(mockConnectivity.checkConnectivity()).thenAnswer((_) => tHasConnection);

        // act
        final result = await networkInfoImpl.isConnected;

        // assert
        verify(mockConnectivity.checkConnectivity());
        expect(result, true);
      },
    );

    test(
      'Make sure the checkConnectivity function is actually called with the '
      'connection condition using wifi',
      () async {
        // arrange
        final tHasConnection = Future.value(ConnectivityResult.wifi);
        when(mockConnectivity.checkConnectivity()).thenAnswer((_) => tHasConnection);

        // act
        final result = await networkInfoImpl.isConnected;

        // assert
        verify(mockConnectivity.checkConnectivity());
        expect(result, true);
      },
    );

    test(
      'Make sure the the checkConnectivity function is actually called with the '
      'condition that the internet connection is not connected',
      () async {
        // arrange
        final tHasConnection = Future.value(ConnectivityResult.none);
        when(mockConnectivity.checkConnectivity()).thenAnswer((_) => tHasConnection);

        // act
        final result = await networkInfoImpl.isConnected;

        // assert
        verify(mockConnectivity.checkConnectivity());
        expect(result, false);
      },
    );
  });
}
