import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MonApplication());
}

class MonApplication extends StatelessWidget {
  const MonApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Magazine Infos',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // fond blanc global
        primaryColor: Colors.pink.shade600,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.pink.shade600, // navbar rose
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const HomePage(),
    );
  }
}
