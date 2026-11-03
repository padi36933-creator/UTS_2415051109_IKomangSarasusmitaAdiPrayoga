import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class NewsApiService {
  static const String _baseUrl = 'https://api.spaceflightnewsapi.net/v4/articles';

  Future<List<ArticleModel>> fetchArticles({String search = ''}) async {
    final query = search.trim().isNotEmpty ? '&search=${Uri.encodeComponent(search)}' : '';
    final uri = Uri.parse('$_baseUrl/?limit=20$query');

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final List results = body['results'] ?? [];
      return results.map((item) => ArticleModel.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat berita dari server (Status: ${response.statusCode})');
    }
  }
}