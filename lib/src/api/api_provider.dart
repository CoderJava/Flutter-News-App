import 'package:dio/dio.dart';
import 'package:flutter_news_app/src/model/topheadlinesnews/response_top_headlinews_news.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://newsapi.org/v2/top-headlines?country=id&apiKey=fc14ae62fff14511a901ad9537987354';

  Future<ResponseTopHeadlinesNews> getTopHeadlinesNews() async {
    final response = await _dio.get(_baseUrl);
    if (response.statusCode == 200) {
      return ResponseTopHeadlinesNews.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch top headlines news');
    }
  }
}