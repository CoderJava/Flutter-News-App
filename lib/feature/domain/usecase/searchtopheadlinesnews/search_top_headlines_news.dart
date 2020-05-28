import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/core/error/failure.dart';
import 'package:flutter_news_app/feature/domain/repository/news/news_repository.dart';
import 'package:meta/meta.dart';
import 'package:flutter_news_app/core/usecase/usecase.dart';
import 'package:flutter_news_app/feature/data/model/topheadlinesnews/top_headlines_news_response_model.dart';

class SearchTopHeadlinesNews implements UseCase<TopHeadlinesNewsResponseModel, ParamsSearchTopHeadlinesNews> {
  final NewsRepository newsRepository;

  SearchTopHeadlinesNews({@required this.newsRepository});

  @override
  Future<Either<Failure, TopHeadlinesNewsResponseModel>> call(ParamsSearchTopHeadlinesNews params) async {
    return await newsRepository.searchTopHeadlinesNews(params.keyword);
  }
}

class ParamsSearchTopHeadlinesNews extends Equatable {
  final String keyword;

  ParamsSearchTopHeadlinesNews({@required this.keyword});

  @override
  List<Object> get props => [keyword];

  @override
  String toString() {
    return 'ParamsSearchTopHeadlinesNews{keyword: $keyword}';
  }
}