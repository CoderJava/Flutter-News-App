import 'dart:convert';

import 'package:flutter_news_app/feature/data/model/news/news_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  final tModel = NewsResponse.fromJson(
    json.decode(
      fixture('news_response.json'),
    ),
  );

  test(
    'Make sure the output of props function',
    () async {
      // assert
      expect(
        tModel.props,
        [
          tModel.status,
          tModel.totalResults,
          tModel.listArticles,
        ],
      );
    },
  );

  test(
    'Make sure the output of toString function',
    () async {
      // assert
      expect(
        tModel.toString(),
        'NewsResponse{status: ${tModel.status}, totalResults: ${tModel.totalResults}, listArticles: ${tModel.listArticles}}',
      );
    },
  );

  test(
    'Make sure fromJson function should return class model',
    () async {
      // arrange
      final jsonData = json.decode(
        fixture('news_response.json'),
      );

      // act
      final actualModel = NewsResponse.fromJson(jsonData);

      // assert
      expect(actualModel, tModel);
    },
  );

  test(
    'Make sure toJson function should return Map',
    () async {
      // arrange
      final model = NewsResponse.fromJson(
        json.decode(
          fixture('news_response.json'),
        ),
      );

      // act
      final actualMap = json.encode(model.toJson());

      // assert
      expect(actualMap, json.encode(tModel.toJson()));
    },
  );
}
