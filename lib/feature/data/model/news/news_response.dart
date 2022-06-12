import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_response.g.dart';

@JsonSerializable()
class NewsResponse extends Equatable {
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'totalResults')
  final int? totalResults;
  @JsonKey(name: 'articles')
  final List<ItemArticleNewsResponse> listArticles;

  const NewsResponse({
    required this.status,
    required this.totalResults,
    required this.listArticles,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) => _$NewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NewsResponseToJson(this);

  @override
  List<Object?> get props => [
        status,
        totalResults,
        listArticles,
      ];

  @override
  String toString() {
    return 'NewsResponse{status: $status, totalResults: $totalResults, listArticles: $listArticles}';
  }
}

@JsonSerializable()
class ItemArticleNewsResponse extends Equatable {
  @JsonKey(name: 'source')
  final SourceNewsResponse source;
  @JsonKey(name: 'author')
  final String? author;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'urlToImage')
  final String? urlImage;
  @JsonKey(name: 'publishedAt')
  final String? strPublishedAt;
  @JsonKey(name: 'content')
  final String? content;

  const ItemArticleNewsResponse({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlImage,
    required this.strPublishedAt,
    required this.content,
  });

  factory ItemArticleNewsResponse.fromJson(Map<String, dynamic> json) => _$ItemArticleNewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemArticleNewsResponseToJson(this);

  @override
  List<Object?> get props => [
        source,
        author,
        title,
        description,
        url,
        urlImage,
        strPublishedAt,
        content,
      ];

  @override
  String toString() {
    return 'ItemArticleNewsResponse{source: $source, author: $author, title: $title, description: $description, '
        'url: $url, urlImage: $urlImage, strPublishedAt: $strPublishedAt, content: $content}';
  }
}

@JsonSerializable()
class SourceNewsResponse extends Equatable {
  @JsonKey(name: 'name')
  final String? name;

  const SourceNewsResponse({
    required this.name,
  });

  factory SourceNewsResponse.fromJson(Map<String, dynamic> json) => _$SourceNewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SourceNewsResponseToJson(this);

  @override
  List<Object?> get props => [
        name,
      ];

  @override
  String toString() {
    return 'SourceNewsResponse{name: $name}';
  }
}
