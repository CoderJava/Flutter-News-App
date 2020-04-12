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
      'pastikan fungsi toJson mengembalikan nilai JSON dalam bentuk objek map yang valid ketika '
      'melakukan konversi data model ke JSON',
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
