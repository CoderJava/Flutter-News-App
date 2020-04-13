// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_headlines_news_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopHeadlinesNewsResponseModel _$TopHeadlinesNewsResponseModelFromJson(
    Map<String, dynamic> json) {
  return TopHeadlinesNewsResponseModel(
    status: json['status'] as String,
    totalResults: json['totalResults'] as int,
    articles: (json['articles'] as List)
        ?.map((e) => e == null
            ? null
            : ItemArticleTopHeadlinesNewsResponseModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TopHeadlinesNewsResponseModelToJson(
        TopHeadlinesNewsResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'articles': instance.articles,
    };

ItemArticleTopHeadlinesNewsResponseModel _$ItemArticleTopHeadlinesNewsFromJson(
    Map<String, dynamic> json) {
  return ItemArticleTopHeadlinesNewsResponseModel(
    source: json['source'] == null
        ? null
        : ItemSourceTopHeadlinesNewsResponseModel.fromJson(
            json['source'] as Map<String, dynamic>),
    author: json['author'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    url: json['url'] as String,
    urlToImage: json['urlToImage'] as String,
    publishedAt: json['publishedAt'] as String,
    content: json['content'] as String,
  );
}

Map<String, dynamic> _$ItemArticleTopHeadlinesNewsToJson(
        ItemArticleTopHeadlinesNewsResponseModel instance) =>
    <String, dynamic>{
      'source': instance.source,
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt,
      'content': instance.content,
    };

ItemSourceTopHeadlinesNewsResponseModel _$ItemSourceTopHeadlinesNewsFromJson(
    Map<String, dynamic> json) {
  return ItemSourceTopHeadlinesNewsResponseModel(
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$ItemSourceTopHeadlinesNewsToJson(
        ItemSourceTopHeadlinesNewsResponseModel instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
