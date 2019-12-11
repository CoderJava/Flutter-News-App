// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_top_headlinews_news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseTopHeadlinesNews _$ResponseTopHeadlinesNewsFromJson(
    Map<String, dynamic> json) {
  return ResponseTopHeadlinesNews(
    json['status'] as String,
    json['totalResults'] as int,
    (json['articles'] as List)
        ?.map((e) =>
            e == null ? null : Article.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResponseTopHeadlinesNewsToJson(
        ResponseTopHeadlinesNews instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'articles': instance.articles,
    };

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    json['source'] == null
        ? null
        : Source.fromJson(json['source'] as Map<String, dynamic>),
    json['author'] as String,
    json['title'] as String,
    json['description'] as String,
    json['url'] as String,
    json['urlToImage'] as String,
    json['publishedAt'] as String,
    json['content'] as String,
  );
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'source': instance.source,
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt,
      'content': instance.content,
    };

Source _$SourceFromJson(Map<String, dynamic> json) {
  return Source(
    json['name'] as String,
  );
}

Map<String, dynamic> _$SourceToJson(Source instance) => <String, dynamic>{
      'name': instance.name,
    };
