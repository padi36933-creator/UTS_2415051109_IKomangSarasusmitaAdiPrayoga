import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/article_model.dart';
import '../models/saved_news_model.dart';
import '../providers/news_provider.dart';

class AddBookmarkScreen extends StatefulWidget {
  final ArticleModel article;
  const AddBookmarkScreen({super.key, required this.article});

  @override
  State<AddBookmarkScreen> createState() => _AddBookmarkScreenState();
}

class _AddBookmarkScreenState extends State<AddBookmarkScreen> {
  final _formKey = GlobalKey<FormState>();
  final _noteController = TextEditingController();
  String _selectedCategory = 'Teknologi';
  int _importanceRating = 5;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simpan Berita ke Bookmark')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.article.title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Kategori Berita',
                  border: OutlineInputBorder(),
                ),
                items: ['Teknologi', 'Sains', 'Riset', 'Opini']
                    .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedCategory = val!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _noteController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Catatan Rangkuman / Opini Pribadi',
                  hintText: 'Tuliskan poin penting...',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().length < 5) {
                    return 'Catatan wajib diisi minimal 5 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Text('Tingkat Kepentingan: $_importanceRating / 5'),
              Slider(
                value: _importanceRating.toDouble(),
                min: 1,
                max: 5,
                divisions: 4,
                label: _importanceRating.toString(),
                onChanged: (val) => setState(() => _importanceRating = val.toInt()),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Simpan ke Database Supabase'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final newBookmark = SavedNewsModel(
                        articleId: widget.article.id,
                        title: widget.article.title,
                        newsSite: widget.article.newsSite,
                        imageUrl: widget.article.imageUrl,
                        personalNote: _noteController.text.trim(),
                        categoryTag: _selectedCategory,
                        importanceRating: _importanceRating,
                      );

                      final success = await context.read<NewsProvider>().addBookmark(newBookmark);
                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(success
                              ? 'Berhasil disimpan ke database!'
                              : 'Gagal menyimpan data'),
                        ),
                      );
                      if (success) Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}