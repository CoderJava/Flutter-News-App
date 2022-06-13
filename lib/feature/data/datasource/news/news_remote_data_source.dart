import 'package:dio/dio.dart';
import 'package:flutter_news_app/config/base_url_config.dart';
import 'package:flutter_news_app/config/flavor_config.dart';
import 'package:flutter_news_app/core/util/enum/top_headline_news_category.dart';
import 'package:flutter_news_app/core/util/helper.dart';
import 'package:flutter_news_app/feature/data/model/news/news_response.dart';

abstract class NewsRemoteDataSource {
  /// Hit endpoint [BaseUrlNews.PrefixV2]/top-headlines
  ///
  /// Throws [DioError] for all code errors.
  Future<NewsResponse> getTopHeadlineNews(TopHeadlineNewsCategory topHeadlineNewsCategory);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final Dio dio;
  final Helper helper;

  NewsRemoteDataSourceImpl({
    required this.dio,
    required this.helper,
  });

  final baseUrl = FlavorConfig.instance.values.baseUrlNewsEndpoint;
  final baseUrlConfig = BaseUrlConfig();

  @override
  Future<NewsResponse> getTopHeadlineNews(TopHeadlineNewsCategory topHeadlineNewsCategory) async {
    final path = '$baseUrl/top-headlines';
    final category = helper.getStringTopHeadlineNewsCategory(topHeadlineNewsCategory);
    final response = await dio.get(
      path,
      options: Options(
        headers: {
          baseUrlConfig.requiredToken: true,
        },
      ),
      queryParameters: {
        'category': category,
        'country': 'id',
      },
    );
    if (response.statusCode == 200) {
      return NewsResponse.fromJson(response.data);
    } else {
      throw DioError(requestOptions: RequestOptions(path: path));
    }
  }
}
