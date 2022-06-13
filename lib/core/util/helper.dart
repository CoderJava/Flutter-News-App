import 'package:flutter_news_app/core/util/enum/top_headline_news_category.dart';

class Helper {
  String getStringTopHeadlineNewsCategory(TopHeadlineNewsCategory topHeadlineNewsCategory) {
    switch (topHeadlineNewsCategory) {
      case TopHeadlineNewsCategory.business:
        return 'business';
      case TopHeadlineNewsCategory.entertainment:
        return 'entertainment';
      case TopHeadlineNewsCategory.general:
        return 'general';
      case TopHeadlineNewsCategory.health:
        return 'health';
      case TopHeadlineNewsCategory.science:
        return 'science';
      case TopHeadlineNewsCategory.sports:
        return 'sports';
      case TopHeadlineNewsCategory.technology:
        return 'technology';
    }
  }
}