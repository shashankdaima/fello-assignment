import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/services/db_services/entities/time_base_entity.dart';

@Entity(tableName: 'news_table', primaryKeys: ['pageNo', 'url'])
class NewsEntity extends TimeBaseEntity {
  @ColumnInfo(name: 'page_no')
  final int pageNo;
  final String author;
  final String title;
  final String description;
  final String url;
  @ColumnInfo(name: 'url_to_image')
  final String urlToImage;
  @ColumnInfo(name: 'published_at')
  final String publishedAt;
  final String content;

  NewsEntity(
      {required this.pageNo,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content,
      required super.createdAt,
      required super.updatedAt});
}
