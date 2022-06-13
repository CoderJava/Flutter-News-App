import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_news_app/config/flavor_config.dart';
import 'package:flutter_news_app/core/util/enum/top_headline_news_category.dart';
import 'package:flutter_news_app/feature/data/datasource/news/news_remote_data_source.dart';
import 'package:flutter_news_app/feature/data/model/news/news_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixture/fixture_reader.dart';
import '../../../../helper/mock_helper.mocks.dart';

void main() {
  late NewsRemoteDataSource newsRemoteDataSource;
  late MockDio mockDio;
  late MockHelper mockHelper;

  const baseUrl = 'https://newsapi.org/v2/top-headlines';

  setUp(() {
    FlavorConfig(
      flavor: Flavor.development,
      values: FlavorValues(
        baseUrlNewsEndpoint: baseUrl,
      ),
    );
    mockDio = MockDio();
    mockHelper = MockHelper();
    newsRemoteDataSource = NewsRemoteDataSourceImpl(
      dio: mockDio,
      helper: mockHelper,
    );
  });

  final tRequestOptions = RequestOptions(path: '');

  group('getTopHeadlineNews', () {
    const tTopHeadlineNewsCategory = TopHeadlineNewsCategory.general;
    const tStringTopHeadlineNewsCategory = 'general';
    final tResponse = NewsResponse.fromJson(
      json.decode(
        fixture('news_response.json'),
      ),
    );

    void setUpMockDioSuccess() {
      final responsePayload = json.decode(
        fixture('news_response.json'),
      );
      final response = Response(
        requestOptions: tRequestOptions,
        data: responsePayload,
        statusCode: 200,
        headers: Headers.fromMap({
          Headers.contentTypeHeader: [Headers.jsonContentType],
        }),
      );
      when(mockHelper.getStringTopHeadlineNewsCategory(any)).thenReturn(tStringTopHeadlineNewsCategory);
      when(
        mockDio.get(
          any,
          options: anyNamed('options'),
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenAnswer((_) async => response);
    }

    test(
      'Make sure getTopHeadlineNews endpoint actually called with GET method',
      () async {
        // arrange
        setUpMockDioSuccess();

        // act
        await newsRemoteDataSource.getTopHeadlineNews(tTopHeadlineNewsCategory);

        // assert
        verify(mockHelper.getStringTopHeadlineNewsCategory(tTopHeadlineNewsCategory));
        verify(
          mockDio.get(
            '$baseUrl/top-headlines',
            options: anyNamed('options'),
            queryParameters: anyNamed('queryParameters'),
          ),
        );
      },
    );

    test(
      'Should return NewsResponse class model when receiving response code successfully from endpoint',
      () async {
        // arrange
        setUpMockDioSuccess();

        // act
        final result = await newsRemoteDataSource.getTopHeadlineNews(tTopHeadlineNewsCategory);

        // assert
        expect(result, tResponse);
      },
    );

    test(
      'Should return exception DioError when receiving response code failure from endpoint',
      () async {
        // arrange
        final response = Response(
          requestOptions: tRequestOptions,
          data: 'Bad Request',
          statusCode: 400,
        );
        when(mockHelper.getStringTopHeadlineNewsCategory(any)).thenReturn(tStringTopHeadlineNewsCategory);
        when(
          mockDio.get(
            any,
            options: anyNamed('options'),
            queryParameters: anyNamed('queryParameters'),
          ),
        ).thenAnswer((_) async => response);

        // act
        final call = newsRemoteDataSource.getTopHeadlineNews(tTopHeadlineNewsCategory);

        // assert
        expect(() => call, throwsA(const TypeMatcher<DioError>()));
      },
    );
  });
}
