import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_news_app/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String apiUrl =
        "https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=8147ba6e2b6d46cbb9d6d460e38995bb";

    var response = await http.get(Uri.parse(apiUrl));
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
              element['title'],
              element["description"],
              element["url"],
              element["urlToImage"],
              DateTime.parse(element['publishedAt']));
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];

  Future<void> getNews(String categoryName) async {
    String apiUrl =
        "https://newsapi.org/v2/top-headlines?category=$categoryName&country=us&category=technology&apiKey=8147ba6e2b6d46cbb9d6d460e38995bb";

    var response = await http.get(Uri.parse(apiUrl));
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
              element['title'],
              element["description"],
              element["url"],
              element["urlToImage"],
              DateTime.parse(element['publishedAt']));
          news.add(articleModel);
        }
      });
    }
  }
}
