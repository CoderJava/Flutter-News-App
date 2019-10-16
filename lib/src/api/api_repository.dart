import 'dart:async';

import 'package:flutter_news_app/src/api/api_provider.dart';
import 'package:flutter_news_app/src/model/topheadlinesnews/response_top_headlinews_news.dart';

class ApiRepository {
  final _apiProvider = ApiProvider();

  Future<ResponseTopHeadlinesNews> fetchTopHeadlinesNews() => _apiProvider.getTopHeadlinesNews();
}