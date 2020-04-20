import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_news_app/core/error/failure.dart';
import 'package:flutter_news_app/core/usecase/usecase.dart';
import 'package:flutter_news_app/feature/data/model/topheadlinesnews/top_headlines_news_response_model.dart';
import 'package:flutter_news_app/feature/domain/usecase/gettopheadlinesnews/get_top_headlines_news.dart';
import 'package:flutter_news_app/feature/presentation/bloc/topheadlinesnews/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixture/fixture_reader.dart';

class MockGetTopHeadlinesNews extends Mock implements GetTopHeadlinesNews {}

void main() {
  MockGetTopHeadlinesNews mockGetTopHeadlinesNews;
  TopHeadlinesNewsBloc topHeadlinesNewsBloc;

  setUp(() {
    mockGetTopHeadlinesNews = MockGetTopHeadlinesNews();
    topHeadlinesNewsBloc = TopHeadlinesNewsBloc(getTopHeadlinesNews: mockGetTopHeadlinesNews);
  });

  tearDown(() {
    topHeadlinesNewsBloc?.close();
  });

  test(
    'make sure that AssertionError will be called when accepting null arguments',
    () async {
      // assert
      expect(() => TopHeadlinesNewsBloc(getTopHeadlinesNews: null), throwsAssertionError);
    },
  );

  test(
    'make sure that initialState must be InitialTopHeadlinesNewsState',
    () async {
      // assert
      expect(topHeadlinesNewsBloc.initialState, InitialTopHeadlinesNewsState());
    },
  );

  test(
    'make sure that no state are emitted when TopHeadlinesNewsBloc is closed',
    () async {
      // act
      await topHeadlinesNewsBloc.close();

      // assert
      await expectLater(topHeadlinesNewsBloc, emitsInOrder([InitialTopHeadlinesNewsState(), emitsDone]));
    },
  );

  group('LoadTopHeadlinesNews', () {
    final tTopHeadlinesNewsResponseModel = TopHeadlinesNewsResponseModel.fromJson(
      json.decode(
        fixture('top_headlines_news_response_model.json'),
      ),
    );

    test(
      'make sure that the GetTopHeadlinesNews use case is really called',
      () async {
        // arrange
        when(mockGetTopHeadlinesNews(any)).thenAnswer((_) async => Right(tTopHeadlinesNewsResponseModel));

        // act
        topHeadlinesNewsBloc.add(LoadTopHeadlinesNewsEvent());
        await untilCalled(mockGetTopHeadlinesNews(any));

        // assert
        verify(mockGetTopHeadlinesNews(NoParams()));
      },
    );

    blocTest(
      'make sure to emit [LoadingTopHeadlinesNewsState, LoadedTopHeadlinesNewsState] when receive '
      'LoadTopHeadlinesNewsEvent with a successful process',
      build: () async {
        // arrange
        when(mockGetTopHeadlinesNews(any)).thenAnswer((_) async => Right(tTopHeadlinesNewsResponseModel));
        return topHeadlinesNewsBloc;
      },
      act: (bloc) {
        // act
        return bloc.add(LoadTopHeadlinesNewsEvent());
      },
      expect: [
        LoadingTopHeadlinesNewsState(),
        LoadedTopHeadlinesNewsState(listArticles: tTopHeadlinesNewsResponseModel.articles),
      ],
      verify: (_) async {
        verify(mockGetTopHeadlinesNews(NoParams())).called(1);
      },
    );

    blocTest(
      'make sure to emit [LoadingTopHeadlinesNewsState, FailureTopHeadlinesNewsState] when receive '
      'LoadTopHeadlinesNewsEvent with a failed process from endpoint',
      build: () async {
        // arrange
        when(mockGetTopHeadlinesNews(any)).thenAnswer(
          (_) async => Left(
            ServerFailure('testErrorMessage'),
          ),
        );
        return topHeadlinesNewsBloc;
      },
      act: (bloc) {
        // act
        return bloc.add(LoadTopHeadlinesNewsEvent());
      },
      expect: [
        LoadingTopHeadlinesNewsState(),
        FailureTopHeadlinesNewsState(errorMessage: 'testErrorMessage'),
      ],
      verify: (_) async {
        verify(mockGetTopHeadlinesNews(NoParams())).called(1);
      },
    );

    blocTest(
        'make sure to emit [LoadingTopHeadlinesNewsState, FailureTopHeadlinesNewsState] when the internet '
        'connection has a problem',
        build: () async {
          when(mockGetTopHeadlinesNews(any)).thenAnswer((_) async => Left(ConnectionFailure()));
          return topHeadlinesNewsBloc;
        },
        act: (bloc) {
          return bloc.add(LoadTopHeadlinesNewsEvent());
        },
        expect: [
          LoadingTopHeadlinesNewsState(),
          FailureTopHeadlinesNewsState(errorMessage: messageConnectionFailure),
        ],
        verify: (_) async {
          verify(mockGetTopHeadlinesNews(NoParams())).called(1);
        });
  });
}
