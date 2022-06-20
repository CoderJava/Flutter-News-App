import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/core/error/failure.dart';
import 'package:flutter_news_app/core/use_case/use_case.dart';
import 'package:flutter_news_app/core/util/enum/top_headline_news_category.dart';
import 'package:flutter_news_app/feature/data/model/news/news_response.dart';
import 'package:flutter_news_app/feature/domain/repository/news/news_repository.dart';

class GetTopHeadlineNews implements UseCase<NewsResponse, ParamsGetTopHeadlineNews> {
  final NewsRepository newsRepository;

  GetTopHeadlineNews(this.newsRepository);

  @override
  Future<Either<Failure, NewsResponse>> call(params) {
    return newsRepository.getTopHeadlineNews(params.topHeadlineNewsCategory);
  }
}

class ParamsGetTopHeadlineNews extends Equatable {
  final TopHeadlineNewsCategory topHeadlineNewsCategory;

  const ParamsGetTopHeadlineNews({required this.topHeadlineNewsCategory});

  @override
  List<Object?> get props => [
    topHeadlineNewsCategory,
  ];

  @override
  String toString() {
    return 'ParamsGetTopHeadlineNews{topHeadlineNewsCategory: $topHeadlineNewsCategory}';
  }
}