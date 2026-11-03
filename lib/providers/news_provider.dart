import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../repositories/news_repository.dart';

class NewsProvider extends ChangeNotifier {
  final NewsRepository repository;
  NewsProvider({required this.repository});

  List<ArticleModel> articles = [];
  bool isLoadingApi = false;
  String? apiError;

  Future<void> loadArticles({String query = ''}) async {
    isLoadingApi = true;
    apiError = null;
    notifyListeners();

    try {
      articles = await repository.getNewsList(query);
    } catch (e) {
      apiError = e.toString();
    } finally {
      isLoadingApi = false;
      notifyListeners();
    }
  }
}