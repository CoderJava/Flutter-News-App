import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_news_app/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfoImpl networkInfoImpl;
  MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('isConnected', () {
    test(
      'must call the DataConnectionChecker.hasConnection function and the connection is connected to the internet (online)',
      () async {
        // arrange
        final tHasConnectionFuture = Future.value(true);
        when(mockDataConnectionChecker.hasConnection).thenAnswer((_) => tHasConnectionFuture);

        // act
        final result = networkInfoImpl.isConnected;

        // assert
        verify(mockDataConnectionChecker.hasConnection);
        expect(result, tHasConnectionFuture);
      },
    );

    test(
      'must call the DataConnectionChecker.hasConnection function and the connection is not connected to the internet (offline)',
      () async {
        // arrange
        final tHasConnectionFuture = Future.value(false);
        when(mockDataConnectionChecker.hasConnection).thenAnswer((_) => tHasConnectionFuture);

        // act
        final result = networkInfoImpl.isConnected;

        // assert
        verify(mockDataConnectionChecker.hasConnection);
        expect(result, tHasConnectionFuture);
      },
    );
  });
}
