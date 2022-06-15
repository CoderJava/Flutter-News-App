import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_news_app/core/error/failure.dart';
import 'package:flutter_news_app/core/network/network_info.dart';
import 'package:flutter_news_app/core/util/enum/top_headline_news_category.dart';
import 'package:flutter_news_app/feature/data/datasource/news/news_remote_data_source.dart';
import 'package:flutter_news_app/feature/data/model/news/news_response.dart';
import 'package:flutter_news_app/feature/domain/repository/news/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource newsRemoteDataSource;
  final NetworkInfo networkInfo;

  NewsRepositoryImpl({
    required this.newsRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NewsResponse>> getTopHeadlineNews(
    TopHeadlineNewsCategory topHeadlineNewsCategory,
  ) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await newsRemoteDataSource.getTopHeadlineNews(topHeadlineNewsCategory);
        return Right(response);
      } on DioError catch (error) {
        return Left(ServerFailure(error.message));
      } on TypeError catch (error) {
        return Left(ParsingFailure(error.toString()));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
