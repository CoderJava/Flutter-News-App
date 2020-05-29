import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_news_app/core/error/failure.dart';
import 'package:flutter_news_app/core/network/network_info.dart';
import 'package:flutter_news_app/feature/data/datasource/news/news_remote_data_source.dart';
import 'package:flutter_news_app/feature/data/model/topheadlinesnews/top_headlines_news_response_model.dart';
import 'package:flutter_news_app/feature/data/repository/news/news_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixture/fixture_reader.dart';

class MockNewsRemoteDataSource extends Mock implements NewsRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NewsRepositoryImpl newsRepositoryImpl;
  MockNewsRemoteDataSource mockNewsRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNewsRemoteDataSource = MockNewsRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    newsRepositoryImpl = NewsRepositoryImpl(
      newsRemoteDataSource: mockNewsRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void setUpMockNetworkConnected() {
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
  }

  void setUpMockNetworkDisconnected() {
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
  }

  void testNetworkConnected(Function endpointCall) {
    test(
      'make sure that the device is connected to the internet when making a request to the endpoint',
      () async {
        // arrange
        setUpMockNetworkConnected();

        // act
        await endpointCall.call();

        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );
  }

  void testNetworkDisconnected(Function endpointCall) {
    test(
      'make sure to return the ConnectionFailure object when the device connection is not connected to the internet',
      () async {
        // arrange
        setUpMockNetworkDisconnected();

        // act
        final result = await endpointCall.call();

        // assert
        verify(mockNetworkInfo.isConnected);
        expect(result, Left(ConnectionFailure()));
      },
    );
  }

  group('getTopHeadlinesNews', () {
    final tCategory = 'technology';
    final tTopHeadlinesNewsResponseModel = TopHeadlinesNewsResponseModel.fromJson(
      json.decode(
        fixture('top_headlines_news_response_model.json'),
      ),
    );

    testNetworkConnected(() => newsRepositoryImpl.getTopHeadlinesNews(tCategory));

    test(
      'make sure to return the value of the TopHeadlinesNewsResponseModel object when '
      'NewsRemoteDataSource successfully receives a successful data response from the endpoint',
      () async {
        // arrange
        setUpMockNetworkConnected();
        when(mockNewsRemoteDataSource.getTopHeadlinesNews(tCategory))
            .thenAnswer((_) async => tTopHeadlinesNewsResponseModel);

        // act
        final result = await newsRepositoryImpl.getTopHeadlinesNews(tCategory);

        // assert
        verify(mockNewsRemoteDataSource.getTopHeadlinesNews(tCategory));
        expect(result, Right(tTopHeadlinesNewsResponseModel));
      },
    );

    test(
      'make sure to return the ServerFailure object when NewsRemoteDataSource receives a failure '
      'data response from the endpoint',
      () async {
        // arrange
        setUpMockNetworkConnected();
        when(mockNewsRemoteDataSource.getTopHeadlinesNews(tCategory)).thenThrow(DioError(error: 'testError'));

        // act
        final result = await newsRepositoryImpl.getTopHeadlinesNews(tCategory);

        // assert
        verify(mockNewsRemoteDataSource.getTopHeadlinesNews(tCategory));
        expect(result, Left(ServerFailure('testError')));
      },
    );

    testNetworkDisconnected(() => newsRepositoryImpl.getTopHeadlinesNews(tCategory));
  });

  group('searchTopHeadlinesNews', () {
    final tKeyword = 'testKeyword';
    final tTopHeadlinesNewsResponseModel = TopHeadlinesNewsResponseModel.fromJson(
      json.decode(
        fixture('top_headlines_news_response_model.json'),
      ),
    );

    testNetworkConnected(() => newsRepositoryImpl.searchTopHeadlinesNews(tKeyword));

    test(
      'make sure to return the value of the TopHeadlinesNewsResponseModel object when '
      'NewsRemoteDataSource successfully receives a successful data response from the endpoint',
      () async {
        // arrange
        setUpMockNetworkConnected();
        when(mockNewsRemoteDataSource.searchTopHeadlinesNews(tKeyword))
            .thenAnswer((_) async => tTopHeadlinesNewsResponseModel);

        // act
        final result = await newsRepositoryImpl.searchTopHeadlinesNews(tKeyword);

        // assert
        verify(mockNewsRemoteDataSource.searchTopHeadlinesNews(tKeyword));
        expect(result, Right(tTopHeadlinesNewsResponseModel));
      },
    );

    test(
      'make sure to return the ServerFailure object when NewsRemoteDataSource receives a failure '
      'data response from the endpoint',
      () async {
        // arrange
        setUpMockNetworkConnected();
        when(mockNewsRemoteDataSource.searchTopHeadlinesNews(tKeyword)).thenThrow(DioError(error: 'testError'));

        // act
        final result = await newsRepositoryImpl.searchTopHeadlinesNews(tKeyword);

        // assert
        verify(mockNewsRemoteDataSource.searchTopHeadlinesNews(tKeyword));
        expect(result, Left(ServerFailure('testError')));
      },
    );

    testNetworkDisconnected(() => newsRepositoryImpl.searchTopHeadlinesNews(tKeyword));
  });
}
