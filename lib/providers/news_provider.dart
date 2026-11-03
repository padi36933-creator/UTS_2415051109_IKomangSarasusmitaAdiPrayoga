import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../models/saved_news_model.dart';

class NewsProvider extends ChangeNotifier {
  // State sementara untuk placeholder sebelum API & DB dihubungkan penuh
  List<ArticleModel> articles = [];
  List<SavedNewsModel> bookmarks = [];

  bool isLoadingApi = false;
  bool isLoadingDb = false;
  String? apiError;
  String? dbError;
  String selectedCategoryFilter = 'Semua';

  List<SavedNewsModel> get filteredBookmarks {
    if (selectedCategoryFilter == 'Semua') return bookmarks;
    return bookmarks.where((b) => b.categoryTag == selectedCategoryFilter).toList();
  }

  void setCategoryFilter(String category) {
    selectedCategoryFilter = category;
    notifyListeners();
  }

  // Fungsi placeholder testing state
  void setDummyLoading() {
    isLoadingApi = true;
    notifyListeners();
    Future.delayed(const Duration(seconds: 1), () {
      isLoadingApi = false;
      notifyListeners();
    });
  }
}