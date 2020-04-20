import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_news_app/core/error/failure.dart';
import 'package:flutter_news_app/core/usecase/usecase.dart';
import 'package:flutter_news_app/feature/domain/usecase/gettopheadlinesnews/get_top_headlines_news.dart';
import 'package:meta/meta.dart';

import './bloc.dart';

class TopHeadlinesNewsBloc extends Bloc<TopHeadlinesNewsEvent, TopHeadlinesNewsState> {
  final GetTopHeadlinesNews getTopHeadlinesNews;

  TopHeadlinesNewsBloc({@required this.getTopHeadlinesNews}) : assert(getTopHeadlinesNews != null);

  @override
  TopHeadlinesNewsState get initialState => InitialTopHeadlinesNewsState();

  @override
  Stream<TopHeadlinesNewsState> mapEventToState(
    TopHeadlinesNewsEvent event,
  ) async* {
    if (event is LoadTopHeadlinesNewsEvent) {
      yield* _mapLoadTopHeadlinesNewsEventToState();
    }
  }

  Stream<TopHeadlinesNewsState> _mapLoadTopHeadlinesNewsEventToState() async* {
    yield LoadingTopHeadlinesNewsState();
    var response = await getTopHeadlinesNews(NoParams());
    yield response.fold(
      // ignore: missing_return
      (failure) {
        if (failure is ServerFailure) {
          return FailureTopHeadlinesNewsState(errorMessage: failure.errorMessage);
        } else if (failure is ConnectionFailure) {
          return FailureTopHeadlinesNewsState(errorMessage: failure.errorMessage);
        }
      },
      (data) => LoadedTopHeadlinesNewsState(listArticles: data.articles),
    );
  }
}
