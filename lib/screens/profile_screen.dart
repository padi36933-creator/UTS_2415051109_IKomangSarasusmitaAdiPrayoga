import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengembang'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.indigo,
              child: Icon(Icons.person, size: 54, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              'I Komang Sarasusmita Adi Prayoga',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'NIM: 2415051109',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Card(
              child: Column(
                children: const [
                  ListTile(
                    leading: Icon(Icons.school, color: Colors.indigo),
                    title: Text('Mata Kuliah'),
                    subtitle: Text('Pemrograman Mobile (Project UTS)'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.apps, color: Colors.indigo),
                    title: Text('Nama Aplikasi'),
                    subtitle: Text('NewsPulse - Portal Berita & Catatan Bacaan'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.cloud_sync, color: Colors.indigo),
                    title: Text('Integrasi Sistem'),
                    subtitle: Text('Spaceflight News REST API & Supabase PostgreSQL'),
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