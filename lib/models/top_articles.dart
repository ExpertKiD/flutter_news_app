import 'dart:convert';

import 'article.dart';

class TopArticles {
  TopArticles({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  final String status;
  final int totalResults;
  final List<Article> articles;

  factory TopArticles.fromRawJson(String str) =>
      TopArticles.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TopArticles.fromJson(Map<String, dynamic> json) => TopArticles(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}
