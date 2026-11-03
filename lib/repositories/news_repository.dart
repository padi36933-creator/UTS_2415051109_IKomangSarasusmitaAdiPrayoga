import '../models/article_model.dart';
import '../models/saved_news_model.dart';
import '../services/news_api_service.dart';
import '../services/news_supabase_service.dart';

class NewsRepository {
  final NewsApiService apiService;
  final NewsSupabaseService supabaseService;

  NewsRepository({required this.apiService, required this.supabaseService});

  Future<List<ArticleModel>> getNewsList(String query) => apiService.fetchArticles(search: query);
  Future<List<SavedNewsModel>> getSavedNews() => supabaseService.getBookmarks();
  Future<void> createSavedNews(SavedNewsModel news) => supabaseService.insertBookmark(news);
  Future<void> updateSavedNews(String id, Map<String, dynamic> values) => supabaseService.updateBookmark(id, values);
  Future<void> deleteSavedNews(String id) => supabaseService.deleteBookmark(id);
}