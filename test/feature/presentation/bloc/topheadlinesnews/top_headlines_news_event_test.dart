import 'package:flutter_news_app/feature/presentation/bloc/topheadlinesnews/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoadTopHeadlinesNews', () {
    final tCategory = 'technology';

    test(
      'make sure the props value is [category]',
      () async {
        // assert
        expect(LoadTopHeadlinesNewsEvent(category: tCategory).props, [tCategory]);
      },
    );

    test(
      'make sure the output of the toString function',
      () async {
        // assert
        expect(
          LoadTopHeadlinesNewsEvent(category: tCategory).toString(),
          'LoadTopHeadlinesNewsEvent{category: $tCategory}',
        );
      },
    );
  });

  group('ChangeCategoryTopHeadlinesNews', () {
    final tChangeCategoryTopHeadlinesNewsEvent = ChangeCategoryTopHeadlinesNewsEvent(indexCategorySelected: 0);

    test(
      'make sure the props value is [indexCategorySelected]',
      () async {
        // assert
        expect(
          tChangeCategoryTopHeadlinesNewsEvent.props,
          [tChangeCategoryTopHeadlinesNewsEvent.indexCategorySelected],
        );
      },
    );

    test(
      'make sure the output of the toString function',
      () async {
        // assert
        expect(
          tChangeCategoryTopHeadlinesNewsEvent.toString(),
          'ChangeCategoryTopHeadlinesNewsEvent{indexCategorySelected: ${tChangeCategoryTopHeadlinesNewsEvent.indexCategorySelected}}',
        );
      },
    );
  });

  group('SearchTopHeadlinesNews', () {
    final tKeyword = 'testKeyword';
    final tSearchTopHeadlinesNewsEvent = SearchTopHeadlinesNewsEvent(keyword: tKeyword);

    test(
      'make sure the props value is [keyword]',
      () async {
        // assert
        expect(
          tSearchTopHeadlinesNewsEvent.props,
          [tSearchTopHeadlinesNewsEvent.keyword],
        );
      },
    );

    test(
      'make sure the output of the toString function',
      () async {
        // assert
        expect(
          tSearchTopHeadlinesNewsEvent.toString(),
          'SearchTopHeadlinesNewsEvent{keyword: ${tSearchTopHeadlinesNewsEvent.keyword}}',
        );
      },
    );
  });
}
