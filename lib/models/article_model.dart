class ArticleModel {
  final int id;
  final String title;
  final String summary;
  final String imageUrl;
  final String newsSite;
  final String publishedAt;
  final String url;

  ArticleModel({
    required this.id,
    required this.title,
    required this.summary,
    required this.imageUrl,
    required this.newsSite,
    required this.publishedAt,
    required this.url,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Tanpa Judul',
      summary: json['summary'] ?? 'Tidak ada ringkasan.',
      imageUrl: json['image_url'] ?? 'https://via.placeholder.com/400x250.png?text=NewsPulse',
      newsSite: json['news_site'] ?? 'Portal Berita',
      publishedAt: json['published_at'] ?? '',
      url: json['url'] ?? '',
    );
  }
}