import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../widgets/news_card.dart';
import '../widgets/status_view.dart';
import 'news_detail_screen.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NewsProvider>().loadArticles();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Berita API'),
      ),
      body: Consumer<NewsProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              // Kolom Pencarian Berita
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Cari berita teknologi...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        provider.loadArticles();
                      },
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onSubmitted: (value) => provider.loadArticles(query: value),
                ),
              ),
              Expanded(
                child: StatusView(
                  isLoading: provider.isLoadingApi,
                  errorMessage: provider.apiError,
                  isEmpty: provider.articles.isEmpty,
                  emptyMessage: 'Tidak ada berita yang ditemukan.',
                  onRetry: () => provider.loadArticles(),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final bool isWide = constraints.maxWidth >= 600;

                      if (isWide) {
                        return GridView.builder(
                          padding: const EdgeInsets.all(12),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.25,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: provider.articles.length,
                          itemBuilder: (context, index) {
                            final article = provider.articles[index];
                            return NewsCard(
                              title: article.title,
                              subtitle: article.summary,
                              source: article.newsSite,
                              imageUrl: article.imageUrl,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => NewsDetailScreen(article: article),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: provider.articles.length,
                        itemBuilder: (context, index) {
                          final article = provider.articles[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: NewsCard(
                              title: article.title,
                              subtitle: article.summary,
                              source: article.newsSite,
                              imageUrl: article.imageUrl,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => NewsDetailScreen(article: article),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}