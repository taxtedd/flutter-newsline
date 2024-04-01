import 'dart:convert';
import '../features/article/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  final List<ArticleModel> news = List<ArticleModel>.empty(growable: true);

  Future<void> getNews() async {
    const String url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=d67ecba1448a40ffb53521dd3ea7f717';

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((article) {
        if (article['urlToImage'] != null && article['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            author: article['author'],
            title: article['title'],
            description: article['description'],
            url: article['url'],
            urlToImage: article['urlToImage'],
          );

          news.add(articleModel);
        }
      });
    }
  }
}

class NewsInCategory {
  final List<ArticleModel> news = List<ArticleModel>.empty(growable: true);

  Future<void> getNewsInCategory(String category) async {
    final String url =
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=d67ecba1448a40ffb53521dd3ea7f717';

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((article) {
        if (article['urlToImage'] != null && article['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            author: article['author'],
            title: article['title'],
            description: article['description'],
            url: article['url'],
            urlToImage: article['urlToImage'],
          );

          news.add(articleModel);
        }
      });
    }
  }
}
