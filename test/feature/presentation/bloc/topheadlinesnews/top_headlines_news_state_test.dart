import 'dart:convert';

import 'package:flutter_news_app/feature/data/model/topheadlinesnews/top_headlines_news_response_model.dart';
import 'package:flutter_news_app/feature/presentation/bloc/topheadlinesnews/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  group('InitialTopHeadlinesNewsState', () {
    test(
      'make sure the props value is []',
      () async {
        // assert
        expect(InitialTopHeadlinesNewsState().props, []);
      },
    );

    test(
      'make sure the output of the toString function',
      () async {
        // assert
        expect(InitialTopHeadlinesNewsState().toString(), 'InitialTopHeadlinesNewsState');
      },
    );
  });

  group('LoadingTopHeadlinesNewsState', () {
    test(
      'make sure the props value is []',
      () async {
        // assert
        expect(LoadingTopHeadlinesNewsState().props, []);
      },
    );

    test(
      'make sure the output of the toString function',
      () async {
        // assert
        expect(LoadingTopHeadlinesNewsState().toString(), 'LoadingTopHeadlinesNewsState');
      },
    );
  });

  group('LoadedTopHeadlinesNewsState', () {
    final tTopHeadlinesNewsResponseModel = TopHeadlinesNewsResponseModel.fromJson(
      json.decode(
        fixture('top_headlines_news_response_model.json'),
      ),
    );
    final tListArticles = tTopHeadlinesNewsResponseModel.articles;
    final tLoadedTopHeadlinesNewsState = LoadedTopHeadlinesNewsState(listArticles: tListArticles);

    test(
      'make sure the props value is [listArticles]',
      () async {
        // assert
        expect(tLoadedTopHeadlinesNewsState.props, [tListArticles]);
      },
    );

    test(
      'make sure the output of the toString function',
      () async {
        // assert
        expect(tLoadedTopHeadlinesNewsState.toString(), 'LoadedTopHeadlinesNewsState{listArticles: $tListArticles}');
      },
    );
  });

  group('FailureTopHeadlinesNewsState', () {
    final tErrorMessage = 'testErrorMessage';
    final tFailureTopHeadlinesNewsState = FailureTopHeadlinesNewsState(errorMessage: tErrorMessage);

    test(
      'make sure the props value is [errorMessage]',
      () async {
        // assert
        expect(tFailureTopHeadlinesNewsState.props, [tErrorMessage]);
      },
    );

    test(
      'make sure the output of the toString function',
      () async {
        // assert
        expect(tFailureTopHeadlinesNewsState.toString(), 'FailureTopHeadlinesNewsState{errorMessage: $tErrorMessage}');
      },
    );
  });
}
