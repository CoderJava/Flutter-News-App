import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_news_app/core/error/failure.dart';
import 'package:flutter_news_app/core/util/enum/top_headline_news_category.dart';
import 'package:flutter_news_app/feature/data/model/news/news_response.dart';
import 'package:flutter_news_app/feature/data/repository/news/news_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixture/fixture_reader.dart';
import '../../../../helper/mock_helper.mocks.dart';

void main() {
  late NewsRepositoryImpl newsRepositoryImpl;
  late MockNewsRemoteDataSource mockNewsRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNewsRemoteDataSource = MockNewsRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    newsRepositoryImpl = NewsRepositoryImpl(
      newsRemoteDataSource: mockNewsRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tRequestOptions = RequestOptions(path: '');

  void setUpMockNetworkConnected() {
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
  }

  void setUpMockNetworkDisconnected() {
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
  }

  void testDisconnected(Function endpointInvoke) {
    test(
      'Should return ConnectionFailure while device is not connected to the internet',
      () async {
        // arrange
        setUpMockNetworkDisconnected();

        // act
        final result = await endpointInvoke.call();

        // assert
        verify(mockNetworkInfo.isConnected);
        expect(result, Left(ConnectionFailure()));
      },
    );
  }

  void testParsingFailure(Function whenInvoke, Function actInvoke, Function verifyInvoke) {
    test(
      'Should return ParsingFailure while NewsRemoteDataSource failure parsing response JSON from the endpoint',
      () async {
        // arrange
        setUpMockNetworkConnected();
        when(whenInvoke.call()).thenThrow(TypeError());

        // act
        final result = await actInvoke.call();

        // assert
        verify(verifyInvoke.call());
        expect(result, Left(ParsingFailure(TypeError().toString())));
      },
    );
  }

  group('getTopHeadlineNews', () {
    const tTopHeadlineNewsCategory = TopHeadlineNewsCategory.general;
    final tResponse = NewsResponse.fromJson(
      json.decode(
        fixture('news_response.json'),
      ),
    );

    test(
      'Should return NewsResponse while NewsRemoteDataSoure retrieve response success from the endpoint',
      () async {
        // arrange
        setUpMockNetworkConnected();
        when(mockNewsRemoteDataSource.getTopHeadlineNews(any)).thenAnswer((_) async => tResponse);

        // act
        final result = await newsRepositoryImpl.getTopHeadlineNews(tTopHeadlineNewsCategory);

        // assert
        verify(mockNewsRemoteDataSource.getTopHeadlineNews(tTopHeadlineNewsCategory));
        expect(result, Right(tResponse));
      },
    );

    test(
      'Should return ServerFailure while NewsRemoteDataSource retrieve timeout response from the endpoint',
      () async {
        // arrange
        setUpMockNetworkConnected();
        when(mockNewsRemoteDataSource.getTopHeadlineNews(any)).thenThrow(
          DioError(
            requestOptions: tRequestOptions,
            error: 'testError',
          ),
        );

        // act
        final result = await newsRepositoryImpl.getTopHeadlineNews(tTopHeadlineNewsCategory);

        // assert
        verify(mockNewsRemoteDataSource.getTopHeadlineNews(tTopHeadlineNewsCategory));
        expect(result, Left(ServerFailure('testError')));
      },
    );

    test(
      'Should return ServerFailure while NewsRemoteDataSource retrieve failure response from the endpoint',
      () async {
        // arrange
        setUpMockNetworkConnected();
        when(mockNewsRemoteDataSource.getTopHeadlineNews(any)).thenThrow(
          DioError(
            requestOptions: tRequestOptions,
            error: 'testError',
            response: Response(
              requestOptions: tRequestOptions,
              statusCode: 400,
            ),
          ),
        );

        // act
        final result = await newsRepositoryImpl.getTopHeadlineNews(tTopHeadlineNewsCategory);

        // assert
        verify(mockNewsRemoteDataSource.getTopHeadlineNews(tTopHeadlineNewsCategory));
        expect(result, Left(ServerFailure('testError')));
      },
    );

    testParsingFailure(
      () => mockNewsRemoteDataSource.getTopHeadlineNews(any),
      () => newsRepositoryImpl.getTopHeadlineNews(tTopHeadlineNewsCategory),
      () => mockNewsRemoteDataSource.getTopHeadlineNews(tTopHeadlineNewsCategory),
    );

    testDisconnected(() => newsRepositoryImpl.getTopHeadlineNews(tTopHeadlineNewsCategory));
  });
}
