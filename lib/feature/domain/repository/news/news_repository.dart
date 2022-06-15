import 'package:dartz/dartz.dart';
import 'package:flutter_news_app/core/error/failure.dart';
import 'package:flutter_news_app/core/util/enum/top_headline_news_category.dart';
import 'package:flutter_news_app/feature/data/model/news/news_response.dart';

abstract class NewsRepository {
  Future<Either<Failure, NewsResponse>> getTopHeadlineNews(TopHeadlineNewsCategory topHeadlineNewsCategory);
}