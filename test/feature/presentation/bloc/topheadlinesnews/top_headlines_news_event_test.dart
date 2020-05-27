import 'package:flutter_news_app/feature/presentation/bloc/topheadlinesnews/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoadTopHeadlinesNews', () {
    final tCategory = 'technology';

    test(
      'make sure the props value is []',
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
}
