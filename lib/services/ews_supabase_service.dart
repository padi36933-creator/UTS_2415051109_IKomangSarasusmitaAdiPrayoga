import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/saved_news_model.dart';

class NewsSupabaseService {
  final SupabaseClient _db = Supabase.instance.client;
  final String _table = 'saved_news';

  Future<List<SavedNewsModel>> getBookmarks() async {
    final data = await _db.from(_table).select().order('created_at', ascending: false);
    return (data as List).map((e) => SavedNewsModel.fromJson(e)).toList();
  }

  Future<void> insertBookmark(SavedNewsModel item) async {
    await _db.from(_table).insert(item.toJson());
  }

  Future<void> updateBookmark(String id, Map<String, dynamic> data) async {
    await _db.from(_table).update(data).eq('id', id);
  }

  Future<void> deleteBookmark(String id) async {
    await _db.from(_table).delete().eq('id', id);
  }
}