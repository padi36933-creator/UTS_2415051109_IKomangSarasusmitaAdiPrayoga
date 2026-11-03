import '../models/article_model.dart';
import '../services/news_api_service.dart';

class NewsRepository {
  final NewsApiService apiService;

  NewsRepository({required this.apiService});

  Future<List<ArticleModel>> getNewsList(String query) => apiService.fetchArticles(search: query);
}