import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/news_provider.dart';
import 'repositories/news_repository.dart';
import 'services/news_api_service.dart';
import 'screens/main_shell.dart';

void main() {
  runApp(const NewsPulseApp());
}

class NewsPulseApp extends StatelessWidget {
  const NewsPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewsProvider(
            repository: NewsRepository(
              apiService: NewsApiService(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'NewsPulse UTS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const MainShell(),
      ),
    );
  }
}