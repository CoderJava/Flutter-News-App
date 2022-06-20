import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_news_app/core/util/enum/top_headline_news_category.dart';
import 'package:flutter_news_app/feature/data/model/news/news_response.dart';
import 'package:flutter_news_app/feature/domain/use_case/get_top_headline_news/get_top_headline_news.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixture/fixture_reader.dart';
import '../../../../helper/mock_helper.mocks.dart';

void main() {
  late GetTopHeadlineNews useCase;
  late MockNewsRepository mockNewsRepository;

  setUp(() {
    mockNewsRepository = MockNewsRepository();
    useCase = GetTopHeadlineNews(mockNewsRepository);
  });

  const tTopHeadlineNewsCategory = TopHeadlineNewsCategory.general;
  const tParams = ParamsGetTopHeadlineNews(topHeadlineNewsCategory: tTopHeadlineNewsCategory);

  test(
    'Make sure repository receive success and failure response from the endpoint getTopHeadlineNews',
    () async {
      // arrange
      final tResponse = NewsResponse.fromJson(
        json.decode(
          fixture('news_response.json'),
        ),
      );
      when(mockNewsRepository.getTopHeadlineNews(any)).thenAnswer((_) async => Right(tResponse));

      // act
      final result = await useCase(tParams);

      // assert
      expect(result, Right(tResponse));
      verify(mockNewsRepository.getTopHeadlineNews(tTopHeadlineNewsCategory));
      verifyNoMoreInteractions(mockNewsRepository);
    },
  );

  test(
    'Make sure the output from props function class params',
    () async {
      // assert
      expect(
        tParams.props,
        [
          tParams.topHeadlineNewsCategory,
        ],
      );
    },
  );

  test(
    'Make sure the output from toString function class params',
    () async {
      // assert
      expect(
        tParams.toString(),
        'ParamsGetTopHeadlineNews{topHeadlineNewsCategory: ${tParams.topHeadlineNewsCategory}}',
      );
    },
  );
}
