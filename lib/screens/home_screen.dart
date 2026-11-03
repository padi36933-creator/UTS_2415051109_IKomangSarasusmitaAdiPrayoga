import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onExploreTap;
  final VoidCallback onSavedTap;

  const HomeScreen({
    super.key,
    required this.onExploreTap,
    required this.onSavedTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewsPulse Dashboard'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWide = constraints.maxWidth >= 600;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner Utama
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(isWide ? 28 : 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.indigo.shade800, Colors.blue.shade600],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.public, color: Colors.white, size: 26),
                          SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'Portal Berita & Catatan Riset',
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Eksplorasi Berita Sains & Teknologi Terkini Secara Real-time',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isWide ? 24 : 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: onExploreTap,
                        icon: const Icon(Icons.travel_explore),
                        label: const Text('Buka Katalog Berita API'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Menu Cepat (Responsive Layout)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                // Kondisi Responsif: Wide (Row 2 kolom) vs Compact (Column menurun)
                if (isWide)
                  Row(
                    children: [
                      Expanded(child: _buildFeatureCard(Icons.newspaper, 'Katalog REST API', 'Baca berita global terbaru', Colors.indigo, onExploreTap)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildFeatureCard(Icons.bookmarks, 'Bookmark Database', 'Kelola catatan & opini pribadi', Colors.teal, onSavedTap)),
                    ],
                  )
                else
                  Column(
                    children: [
                      _buildFeatureCard(Icons.newspaper, 'Katalog REST API', 'Baca berita global terbaru', Colors.indigo, onExploreTap),
                      const SizedBox(height: 12),
                      _buildFeatureCard(Icons.bookmarks, 'Bookmark Database', 'Kelola catatan & opini pribadi', Colors.teal, onSavedTap),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, String subtitle, Color color, VoidCallback onTap) {
    return Card(
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}