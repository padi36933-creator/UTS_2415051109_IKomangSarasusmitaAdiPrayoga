import 'package:flutter/material.dart';
import '../models/article_model.dart';
import 'add_bookmark_screen.dart';

class NewsDetailScreen extends StatelessWidget {
  final ArticleModel article;
  const NewsDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    // Mengambil tanggal aman (maksimal 10 karakter jika string tanggal tersedia)
    final dateStr = article.publishedAt.isNotEmpty 
        ? article.publishedAt.substring(0, 10) 
        : '';

    return Scaffold(
      appBar: AppBar(title: Text(article.newsSite)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              article.imageUrl,
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 220,
                color: Colors.grey.shade300,
                child: const Center(child: Icon(Icons.broken_image, size: 50)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sumber: ${article.newsSite} • $dateStr',
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.title,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Ringkasan Berita:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.summary,
                    style: const TextStyle(fontSize: 15, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Membuka halaman Form Tambah Bookmark dengan Passing Data (article)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddBookmarkScreen(article: article),
                          ),
                        );
                      },
                      icon: const Icon(Icons.bookmark_add_outlined),
                      label: const Text('Simpan Berita ke Bookmark'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}