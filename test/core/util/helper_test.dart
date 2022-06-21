import 'package:flutter_news_app/core/util/enum/top_headline_news_category.dart';
import 'package:flutter_news_app/core/util/helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final helper = Helper();

  test(
    'Should return string of TopHeadlineNewsCategory',
    () async {
      // arrange
      const business = TopHeadlineNewsCategory.business;
      const entertainment = TopHeadlineNewsCategory.entertainment;
      const general = TopHeadlineNewsCategory.general;
      const health = TopHeadlineNewsCategory.health;
      const science = TopHeadlineNewsCategory.science;
      const sports = TopHeadlineNewsCategory.sports;
      const technology = TopHeadlineNewsCategory.technology;

      // act
      final resultBusiness = helper.getStringTopHeadlineNewsCategory(business);
      final resultEntertainment = helper.getStringTopHeadlineNewsCategory(entertainment);
      final resultGeneral = helper.getStringTopHeadlineNewsCategory(general);
      final resultHealth = helper.getStringTopHeadlineNewsCategory(health);
      final resultScience = helper.getStringTopHeadlineNewsCategory(science);
      final resultSports = helper.getStringTopHeadlineNewsCategory(sports);
      final resultTechnology = helper.getStringTopHeadlineNewsCategory(technology);

      // assert
      expect(resultBusiness, 'business');
      expect(resultEntertainment, 'entertainment');
      expect(resultGeneral, 'general');
      expect(resultHealth, 'health');
      expect(resultScience, 'science');
      expect(resultSports, 'sports');
      expect(resultTechnology, 'technology');
    },
  );
}