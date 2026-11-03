class SavedNewsModel {
  final String? id;
  final int articleId;
  final String title;
  final String newsSite;
  final String imageUrl;
  final String personalNote;
  final String categoryTag;
  final int importanceRating;
  final bool isRead;

  SavedNewsModel({
    this.id,
    required this.articleId,
    required this.title,
    required this.newsSite,
    required this.imageUrl,
    required this.personalNote,
    required this.categoryTag,
    required this.importanceRating,
    this.isRead = false,
  });

  factory SavedNewsModel.fromJson(Map<String, dynamic> json) {
    return SavedNewsModel(
      id: json['id']?.toString(),
      articleId: json['article_id'] ?? 0,
      title: json['title'] ?? '',
      newsSite: json['news_site'] ?? '',
      imageUrl: json['image_url'] ?? '',
      personalNote: json['personal_note'] ?? '',
      categoryTag: json['category_tag'] ?? 'Teknologi',
      importanceRating: json['importance_rating'] ?? 3,
      isRead: json['is_read'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'article_id': articleId,
      'title': title,
      'news_site': newsSite,
      'image_url': imageUrl,
      'personal_note': personalNote,
      'category_tag': categoryTag,
      'importance_rating': importanceRating,
      'is_read': isRead,
    };
  }
}