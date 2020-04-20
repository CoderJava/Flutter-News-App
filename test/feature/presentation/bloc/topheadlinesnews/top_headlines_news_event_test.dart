import 'package:flutter_news_app/feature/presentation/bloc/topheadlinesnews/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoadTopHeadlinesNews', () {
    test(
      'make sure the props value is []',
      () async {
        // assert
        expect(LoadTopHeadlinesNewsEvent().props, []);
      },
    );

    test(
      'make sure the output of the toString function',
      () async {
        // assert
        expect(LoadTopHeadlinesNewsEvent().toString(), 'LoadTopHeadlinesNewsEvent');
      },
    );
  });
}
