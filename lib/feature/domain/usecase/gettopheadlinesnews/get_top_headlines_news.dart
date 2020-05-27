import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/core/error/failure.dart';
import 'package:flutter_news_app/core/usecase/usecase.dart';
import 'package:flutter_news_app/feature/data/model/topheadlinesnews/top_headlines_news_response_model.dart';
import 'package:flutter_news_app/feature/domain/repository/news/news_repository.dart';
import 'package:meta/meta.dart';

class GetTopHeadlinesNews implements UseCase<TopHeadlinesNewsResponseModel, ParamsGetTopHeadlinesNews> {
  final NewsRepository newsRepository;

  GetTopHeadlinesNews({@required this.newsRepository});

  @override
  Future<Either<Failure, TopHeadlinesNewsResponseModel>> call(ParamsGetTopHeadlinesNews params) async {
    return await newsRepository.getTopHeadlinesNews(params.category);
  }
}

class ParamsGetTopHeadlinesNews extends Equatable {
  final String category;

  ParamsGetTopHeadlinesNews({@required this.category});

  @override
  List<Object> get props => [category];

  @override
  String toString() {
    return 'ParamsGetTopHeadlinesNews{category: $category}';
  }
}