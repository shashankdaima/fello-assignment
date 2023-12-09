import 'package:flutter/widgets.dart';
import 'package:flutter_template/services/api_services/dto/response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'success_response.g.dart';

@JsonSerializable()
class SuccessResponse extends HttpResponse {
  final String status;
  final int totalResults;
  final List<NewsArticle> articles;
  SuccessResponse(this.status, this.totalResults, this.articles);

  factory SuccessResponse.fromJson(Map<String, dynamic> json) =>
      _$SuccessResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SuccessResponseToJson(this);
}

@JsonSerializable()
class NewsArticle extends HttpResponse {
  final NewsArticleSource source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  NewsArticle(this.source, this.author, this.title, this.description,
      this.content, this.publishedAt, this.url, this.urlToImage);

  factory NewsArticle.fromJson(Map<String, dynamic> json) =>
      _$NewsArticleFromJson(json);
  Map<String, dynamic> toJson() => _$NewsArticleToJson(this);
}

@JsonSerializable()
class NewsArticleSource extends HttpResponse {
  final String? id;
  final String name;
  NewsArticleSource(this.id, this.name);

  factory NewsArticleSource.fromJson(Map<String, dynamic> json) =>
      _$NewsArticleSourceFromJson(json);
  Map<String, dynamic> toJson() => _$NewsArticleSourceToJson(this);
}
