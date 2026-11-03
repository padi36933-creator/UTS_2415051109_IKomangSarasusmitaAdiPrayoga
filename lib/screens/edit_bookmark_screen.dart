import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/saved_news_model.dart';
import '../providers/news_provider.dart';

class EditBookmarkScreen extends StatefulWidget {
  final SavedNewsModel bookmark;
  const EditBookmarkScreen({super.key, required this.bookmark});

  @override
  State<EditBookmarkScreen> createState() => _EditBookmarkScreenState();
}

class _EditBookmarkScreenState extends State<EditBookmarkScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _noteController;
  late String _selectedCategory;
  late int _importanceRating;
  late bool _isRead;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.bookmark.personalNote);
    _selectedCategory = widget.bookmark.categoryTag;
    _importanceRating = widget.bookmark.importanceRating;
    _isRead = widget.bookmark.isRead;
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Catatan Bookmark')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.bookmark.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().length < 5) {
                    return 'Catatan minimal 5 karakter';
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
              SwitchListTile(
                title: const Text('Tandai Sudah Dibaca'),
                value: _isRead,
                onChanged: (val) => setState(() => _isRead = val),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  icon: const Icon(Icons.update),
                  label: const Text('Perbarui Data di Database'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate() && widget.bookmark.id != null) {
                      final success = await context.read<NewsProvider>().editBookmark(
                            id: widget.bookmark.id!,
                            note: _noteController.text.trim(),
                            category: _selectedCategory,
                            rating: _importanceRating,
                            isRead: _isRead,
                          );

                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(success ? 'Berhasil diperbarui!' : 'Gagal memperbarui data'),
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