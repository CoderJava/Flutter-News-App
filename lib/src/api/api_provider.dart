import 'package:dio/dio.dart';
import 'package:flutter_news_app/src/model/topheadlinesnews/response_top_headlinews_news.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _baseUrl =
      'https://newsapi.org/v2/top-headlines?country=id&apiKey=fc14ae62fff14511a901ad9537987354';

  Future<ResponseTopHeadlinesNews> getTopHeadlinesNews() async {
    final response = await _dio.get(_baseUrl);
    if (response.statusCode == 200) {
      return ResponseTopHeadlinesNews.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch top headlines news');
    }
  }

  Future<ResponseTopHeadlinesNews> getTopBusinessHeadlinesNews() async {
    final response = await _dio.get('$_baseUrl&category=business');
    if (response.statusCode == 200) {
      return ResponseTopHeadlinesNews.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch top business headlines news');
    }
  }

  Future<ResponseTopHeadlinesNews> getTopEntertainmentHeadlinesNews() async {
    final response = await _dio.get('$_baseUrl&category=entertainment');
    if (response.statusCode == 200) {
      return ResponseTopHeadlinesNews.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch top entertainment headlines news');
    }
  }

  Future<ResponseTopHeadlinesNews> getTopHealthHeadlinesNews() async {
    final response = await _dio.get('$_baseUrl&category=health');
    if (response.statusCode == 200) {
      return ResponseTopHeadlinesNews.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch top health headlinews news');
    }
  }

  Future<ResponseTopHeadlinesNews> getTopScienceHeadlinesNews() async {
    final response = await _dio.get('$_baseUrl&category=science');
    if (response.statusCode == 200) {
      return ResponseTopHeadlinesNews.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch top science headlines news');
    }
  }

  Future<ResponseTopHeadlinesNews> getTopSportHeadlinesNews() async {
    final response = await _dio.get('$_baseUrl&category=sport');
    if (response.statusCode == 200) {
      return ResponseTopHeadlinesNews.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch top sport headlines news');
    }
  }

  Future<ResponseTopHeadlinesNews> getTopTechnologyHeadlinesNews() async {
    final response = await _dio.get('$_baseUrl&category=technology');
    if (response.statusCode == 200) {
      return ResponseTopHeadlinesNews.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch top technology headlines news');
    }
  }
}
