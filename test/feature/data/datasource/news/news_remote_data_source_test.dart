import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_news_app/config/base_url_config.dart';
import 'package:flutter_news_app/config/constant_config.dart';
import 'package:flutter_news_app/feature/data/datasource/news/news_remote_data_source.dart';
import 'package:flutter_news_app/feature/data/model/topheadlinesnews/top_headlines_news_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixture/fixture_reader.dart';

class MockDioAdapter extends Mock implements HttpClientAdapter {}

class MockDio extends Mock implements Dio {}

void main() {
  NewsRemoteDataSourceImpl newsRemoteDataSource;
  ConstantConfig constantConfig;
  MockDio mockDio;
  MockDioAdapter mockDioAdapter;

  setUp(() {
    mockDio = MockDio();
    constantConfig = ConstantConfig();
    mockDioAdapter = MockDioAdapter();
    mockDio.httpClientAdapter = mockDioAdapter;
    mockDio.options = BaseOptions(
      baseUrl: BaseUrlConfig().baseUrlDevelopment,
    );
    newsRemoteDataSource = NewsRemoteDataSourceImpl(
      dio: mockDio,
      constantConfig: constantConfig,
    );
  });

  group('getTopHeadlinesNews', () {
    final tTopHeadlinesNewsResponseModel = TopHeadlinesNewsResponseModel.fromJson(
      json.decode(
        fixture('top_headlines_news_response_model.json'),
      ),
    );

    void setUpMockDioSuccess() {
      final responsePayload = json.decode(fixture('top_headlines_news_response_model.json'));
      final response = Response(
        data: responsePayload,
        statusCode: 200,
        headers: Headers.fromMap({
          Headers.contentTypeHeader: [Headers.jsonContentType],
        }),
      );
      when(
        mockDio.get(
          any,
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenAnswer((_) async => response);
    }

    test(
      'make sure there is a GET request to endpoint /v2/top-headlines?country=:country&apiKey=:apiKey',
      () async {
        // arrange
        setUpMockDioSuccess();

        // act
        await newsRemoteDataSource.getTopHeadlinesNews();

        // assert
        verify(
          mockDio.get(
            '/v2/top-headlines',
            queryParameters: {
              'country': 'id',
              'apiKey': constantConfig.apiKeyNewsApi,
            },
          ),
        );
      },
    );

    test(
      'make sure to return the TopHeadlinesNewsResponseModel object when the '
      'response code is successful from the endpoint',
      () async {
        // arrange
        setUpMockDioSuccess();

        // act
        final result = await newsRemoteDataSource.getTopHeadlinesNews();

        // assert
        expect(result, tTopHeadlinesNewsResponseModel);
      },
    );

    test(
      'make sure to receive DioError when the response code fails from the endpoint',
      () async {
        // arrange
        final response = Response(
          data: 'Bad Request',
          statusCode: 400,
        );
        when(mockDio.get(any, queryParameters: anyNamed('queryParameters'))).thenAnswer((_) async => response);

        // act
        final call = newsRemoteDataSource.getTopHeadlinesNews();

        // assert
        expect(() => call, throwsA(TypeMatcher<DioError>()));
      },
    );
  });
}
