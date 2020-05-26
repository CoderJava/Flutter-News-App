import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_news_app/core/error/failure.dart';
import 'package:flutter_news_app/core/network/network_info.dart';
import 'package:flutter_news_app/feature/data/datasource/news/news_remote_data_source.dart';
import 'package:flutter_news_app/feature/data/model/topheadlinesnews/top_headlines_news_response_model.dart';
import 'package:flutter_news_app/feature/domain/repository/news/news_repository.dart';
import 'package:meta/meta.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource newsRemoteDataSource;
  final NetworkInfo networkInfo;

  NewsRepositoryImpl({
    @required this.newsRemoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, TopHeadlinesNewsResponseModel>> getTopHeadlinesNews(String category) async {
    var isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        var response = await newsRemoteDataSource.getTopHeadlinesNews(category);
        return Right(response);
      } on DioError catch (error) {
        return Left(ServerFailure(error.message));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
