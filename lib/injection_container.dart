import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_news_app/config/constant_config.dart';
import 'package:flutter_news_app/config/flavor_config.dart';
import 'package:flutter_news_app/core/network/network_info.dart';
import 'package:flutter_news_app/core/util/dio_logging_interceptor.dart';
import 'package:flutter_news_app/feature/data/datasource/news/news_remote_data_source.dart';
import 'package:flutter_news_app/feature/data/repository/news/news_repository_impl.dart';
import 'package:flutter_news_app/feature/domain/usecase/gettopheadlinesnews/get_top_headlines_news.dart';
import 'package:get_it/get_it.dart';

import 'feature/presentation/bloc/topheadlinesnews/bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /**
   * ! Features
   */
  // Bloc
  sl.registerFactory(() => TopHeadlinesNewsBloc(getTopHeadlinesNews: sl()));

  // Use Case
  sl.registerLazySingleton(() => GetTopHeadlinesNews(newsRepository: sl()));

  // Repository
  sl.registerLazySingleton(() => NewsRepositoryImpl(newsRemoteDataSource: sl(), networkInfo: sl()));

  // Data Source
  sl.registerLazySingleton(() => NewsRemoteDataSourceImpl(dio: sl(), constantConfig: sl()));

  /**
   * ! Core
   */
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /**
   * ! External
   */
  sl.registerLazySingleton(() {
    final dio = Dio();
    dio.options.baseUrl = FlavorConfig.instance.values.baseUrl;
    dio.interceptors.add(DioLoggingInterceptor());
    return dio;
  });
  sl.registerLazySingleton(() => ConstantConfig());
  sl.registerLazySingleton(() => DataConnectionChecker());
}