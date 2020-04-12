import 'package:dio/dio.dart';
import 'package:flutter_news_app/src/model/topheadlinesnews/response_top_headlinews_news.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _baseUrl =
      'https://newsapi.org/v2/top-headlines?country=id&apiKey=YOUR_API_KEY';

  void printOutError(error, StackTrace stacktrace) {
    print('Exception occured: $error with stacktrace: $stacktrace');
  }

  Future<ResponseTopHeadlinesNews> getTopHeadlinesNews() async {
    try {
      final response = await _dio.get(_baseUrl);
      return ResponseTopHeadlinesNews.fromJson(response.data);
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
      return ResponseTopHeadlinesNews.withError('$error');
    }
  }

  Future<ResponseTopHeadlinesNews> getTopBusinessHeadlinesNews() async {
    try {
      final response = await _dio.get('$_baseUrl&category=business');
      return ResponseTopHeadlinesNews.fromJson(response.data);
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
      return ResponseTopHeadlinesNews.withError('$error');
    }
  }

  Future<ResponseTopHeadlinesNews> getTopEntertainmentHeadlinesNews() async {
    try {
      final response = await _dio.get('$_baseUrl&category=entertainment');
      return ResponseTopHeadlinesNews.fromJson(response.data);
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
      return ResponseTopHeadlinesNews.withError('$error');
    }
  }

  Future<ResponseTopHeadlinesNews> getTopHealthHeadlinesNews() async {
    try {
      final response = await _dio.get('$_baseUrl&category=health');
      return ResponseTopHeadlinesNews.fromJson(response.data);
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
      return ResponseTopHeadlinesNews.withError('$error');
    }
  }

  Future<ResponseTopHeadlinesNews> getTopScienceHeadlinesNews() async {
    try {
      final response = await _dio.get('$_baseUrl&category=science');
      return ResponseTopHeadlinesNews.fromJson(response.data);
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
      return ResponseTopHeadlinesNews.withError('$error');
    }
  }

  Future<ResponseTopHeadlinesNews> getTopSportHeadlinesNews() async {
    try {
      final response = await _dio.get('$_baseUrl&category=sport');
      return ResponseTopHeadlinesNews.fromJson(response.data);
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
      return ResponseTopHeadlinesNews.withError('$error');
    }
  }

  Future<ResponseTopHeadlinesNews> getTopTechnologyHeadlinesNews() async {
    try {
      final response = await _dio.get('$_baseUrl&category=technology');
      return ResponseTopHeadlinesNews.fromJson(response.data);
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
      return ResponseTopHeadlinesNews.withError('$error');
    }
  }
}
