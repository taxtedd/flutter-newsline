import 'package:flutter/material.dart';
import 'package:flutter_task1/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'features/news_list/news_list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        '/': (context) => const NewsListScreen(),
      },
    );
  }
}
