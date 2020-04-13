import 'dart:convert';

import 'package:flutter_news_app/feature/data/model/categorynews/category_news_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  final tCategoryNewsModel = CategoryNewsModel(
    image: 'testImage',
    title: 'testTitle',
  );

  test(
    'make sure the output of the toString function',
    () async {
      // assert
      expect(
        tCategoryNewsModel.toString(),
        'CategoryNewsModel{image: ${tCategoryNewsModel.image}, title: ${tCategoryNewsModel.title}}',
      );
    },
  );

  test(
    'make sure the props value is [image, title]',
    () async {
      // assert
      expect(tCategoryNewsModel.props, [tCategoryNewsModel.image, tCategoryNewsModel.title]);
    },
  );

  group('fromJson', () {
    test(
      'make sure the fromJson function returns a valid model object when reading valid JSON',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('category_news_model.json'));

        // act
        final result = CategoryNewsModel.fromJson(jsonMap);

        // assert
        expect(result, tCategoryNewsModel);
      },
    );
  });

  group('toJson', () {
    test(
      'make sure the toJson function returns a JSON value in the form of a '
      'valid map object when converting model data to JSON',
      () async {
        // arrange
        final resultCategoryNewsModel = tCategoryNewsModel.toJson();

        // act
        final expectedMapCategoryNewsModel = {
          'image': 'testImage',
          'title': 'testTitle',
        };

        // assert
        expect(resultCategoryNewsModel, expectedMapCategoryNewsModel);
      },
    );
  });
}
