import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../models/saved_news_model.dart';
import '../repositories/news_repository.dart';

class NewsProvider extends ChangeNotifier {
  final NewsRepository repository;
  NewsProvider({required this.repository});

  List<ArticleModel> articles = [];
  List<SavedNewsModel> bookmarks = [];

  bool isLoadingApi = false;
  bool isLoadingDb = false;
  String? apiError;
  String? dbError;

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

  Future<void> loadBookmarks() async {
    isLoadingDb = true;
    dbError = null;
    notifyListeners();
    try {
      bookmarks = await repository.getSavedNews();
    } catch (e) {
      dbError = e.toString();
    } finally {
      isLoadingDb = false;
      notifyListeners();
    }
  }

  Future<bool> addBookmark(SavedNewsModel news) async {
    try {
      await repository.createSavedNews(news);
      await loadBookmarks();
      return true;
    } catch (e) {
      dbError = e.toString();
      notifyListeners();
      return false;
    }
  }
}